# Convert to list
#' @export
S7::method(as.list, Enum_class) <- function(x, ...) {
  result <- x@values
  names(result) <- x@enum_names
  result
}
