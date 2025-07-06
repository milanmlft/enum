#' Create an Enum
#'
#' TODO: description
#'
#' @param ... Named or unnamed arguments to include in the enumeration.
#'
#' @return An `Enum`.
#'
#' @examples
#' # Create a simple enum with named values
#' colors <- Enum(RED = 1, GREEN = 2, BLUE = 3)
#' colors$RED
#' colors$GREEN
#'
#' @export
Enum <- function(...) {
  return(list(...))
}
