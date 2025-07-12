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
S7::method(`[`, Enum_class) <- function(x, i, ...) {
  if (is.character(i)) {
    if (!i %in% x@enum_names) {
      stop("Invalid enum name: ", i, call. = FALSE)
    }
    idx <- match(i, x@enum_names)
    return(x@values[[idx]])
  } else if (is.numeric(i)) {
    if (i < 1 || i > length(x@values)) {
      stop("Index out of bounds", call. = FALSE)
    }
    return(x@values[[i]])
  } else {
    stop("Invalid index type", call. = FALSE)
  }
}

# Bracket assignment (should fail for immutability)
#' @export
S7::method(`[<-`, Enum_class) <- function(x, i, value) {
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
