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
  if (is.character(i)) {
    invalid_names <- i[!i %in% x@enum_names]
    if (length(invalid_names) > 0) {
      stop("Invalid enum names: ", paste(invalid_names, collapse = ", "), call. = FALSE)
    }
    idx <- match(i, x@enum_names)
    return(unlist(x@values[[idx]], use.names = FALSE))
  } else if (is.numeric(i)) {
    if (any(i < 1 | i > length(x@values))) {
      stop("Index out of bounds", call. = FALSE)
    }
    return(unlist(x@values[[i]], use.names = FALSE))
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
