# Convert to list
#' @export
S7::method(as.list, Enum_class) <- function(x, ...) {
  result <- x@values
  names(result) <- x@enum_names
  result
}

# Convert to vector
#' @export
S7::method(as.vector, Enum_class) <- function(x, mode = "any") {
  unname(do.call(c, x@values))
}
