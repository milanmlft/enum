# Dollar sign accessor
#' @export
S7::method(`$`, Enum_class) <- function(x, name) {
  if (!name %in% x@enum_names) {
    stop(sprintf("Invalid enum name: %s", name), call. = FALSE)
  }

  idx <- match(name, x@enum_names)
  x@values[[idx]]
}

# Dollar sign assignment (should fail for immutability)
#' @export
S7::method(`$<-`, Enum_class) <- function(x, name, value) {
  stop("Cannot modify enum", call. = FALSE)
}

# Bracket accessor
#' @export
S7::method(`[[`, Enum_class) <- function(x, i, ...) {
  if (length(i) != 1) {
    stop("Index must be a single name or position", call. = FALSE)
  }
  if (is.na(i)) {
    stop("Index must not be NA", call. = FALSE)
  }

  if (is.character(i)) {
    if (!i %in% x@enum_names) {
      stop(sprintf("Invalid enum name: %s", i), call. = FALSE)
    }
    x@values[[match(i, x@enum_names)]]
  } else if (is.numeric(i)) {
    if (i < 1 || i > length(x@values)) {
      stop("Index out of bounds", call. = FALSE)
    }
    x@values[[i]]
  } else {
    stop("Invalid index type", call. = FALSE)
  }
}

# Bracket assignment (should fail for immutability)
#' @export
S7::method(`[[<-`, Enum_class) <- function(x, i, value) {
  stop("Cannot modify enum", call. = FALSE)
}

# Length method
#' @export
S7::method(length, Enum_class) <- function(x) {
  length(x@values)
}

# Names method
#' @export
S7::method(names, Enum_class) <- function(x) {
  x@enum_names
}

# Internal: validate that `x` is an Enum
check_enum <- function(x) {
  if (!is.enum(x)) {
    stop("First argument must be an Enum", call. = FALSE)
  }
  invisible(x)
}

# Internal: strict, type-aware matching of `value` against the enum values.
# Returns the integer indices of all values that are `identical()` to `value`.
.match_value <- function(enum, value) {
  which(vapply(enum@values, identical, logical(1), y = value))
}

#' Check if a value is valid for an enum
#'
#' Matching is strict and type-aware: the value must be `identical()` to one of
#' the enum values, so `"1"` and `TRUE` do not match `1`. A vector `value` is
#' treated as a single value and matched as a whole.
#'
#' @param enum An Enum object
#' @param value The value to check (treated as a single object)
#'
#' @return A single `TRUE` if the value is valid for the enum, `FALSE` otherwise
#'
#' @examples
#' colors <- Enum(RED = 1, GREEN = 2, BLUE = 3)
#' is.valid(colors, 1) # TRUE
#' is.valid(colors, 4) # FALSE
#' is.valid(colors, "1") # FALSE
#'
#' @export
is.valid <- function(enum, value) {
  check_enum(enum)
  length(.match_value(enum, value)) > 0
}

#' Get the key (name) for a given value in an enum
#'
#' Matching is strict and type-aware (see [is.valid()]). If several keys share
#' the same value, the key of the first match is returned.
#'
#' @param enum An Enum object
#' @param value The value to find the key for (treated as a single object)
#'
#' @return A single string with the key (name) for the value, or `NULL` if not
#'   found
#'
#' @examples
#' colors <- Enum(RED = 1, GREEN = 2, BLUE = 3)
#' key.by.value(colors, 1) # "RED"
#' key.by.value(colors, 4) # NULL
#'
#' # With duplicate values, the first match wins
#' dup <- Enum(A = 1, B = 1)
#' key.by.value(dup, 1) # "A"
#'
#' @export
key.by.value <- function(enum, value) {
  check_enum(enum)
  idx <- .match_value(enum, value)
  if (length(idx) == 0) {
    return(NULL)
  }
  enum@enum_names[idx[1]]
}
