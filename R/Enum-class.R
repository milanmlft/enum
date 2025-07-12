#' Enum S7 Class
#'
#' An S7 class representing an enumeration with named values.
Enum_class <- S7::new_class("Enum",
  properties = list(
    values = class_list,
    enum_names = class_character
  ),
  validator = function(self) {
    if (length(self@enum_names) != length(self@values)) {
      return("Names and values must have the same length")
    }

    if (any(duplicated(self@enum_names))) {
      return("Duplicate enum names are not allowed")
    }

    if (length(self@enum_names) > 0 && any(self@enum_names == "" | is.na(self@enum_names))) {
      return("All enum names must be non-empty strings")
    }
  }
)

#' Create an Enum
#'
#' Creates a new enumeration with named values. Enums are immutable objects
#' that provide type-safe access to a fixed set of named constants.
#'
#' @param ... Named arguments representing the enum values. All arguments
#'   must be named. Values can be of any type.
#'
#' @return An `Enum` object.
#'
#' @examples
#' # Create a simple enum with named values
#' colors <- Enum(RED = 1, GREEN = 2, BLUE = 3)
#' colors$RED
#' colors$GREEN
#'
#' # Create an enum with character values
#' status <- Enum(PENDING = "pending", COMPLETE = "complete", FAILED = "failed")
#' status$PENDING
#'
#' # Create an enum with mixed types
#' mixed <- Enum(ZERO = 0L, ONE = "one", TWO = 2.0, THREE = TRUE)
#' mixed$ZERO
#'
#' @export
Enum <- function(...) {
  args <- list(...)

  arg_names <- names(args)
  if (is.null(arg_names) || any(arg_names == "")) {
    if (length(args) > 0) {
      unnamed_positions <- which(arg_names == "" | is.null(arg_names))
      stop(sprintf(
        "All enum values must be named. Unnamed values at positions: %s",
        paste(unnamed_positions, collapse = ", ")
      ), call. = FALSE)
    }
  }

  if (any(duplicated(arg_names))) {
    duplicates <- unique(arg_names[duplicated(arg_names)])
    stop(sprintf("Duplicate enum names: %s", paste(duplicates, collapse = ", ")), call. = FALSE)
  }

  Enum_class(
    values = args,
    enum_names = arg_names %||% character(0)
  )
}

# Print method
#' @export
S7::method(print, Enum_class) <- function(x, ...) {
  cat("Enum with", length(x), "values:\n")
  if (length(x) > 0) {
    for (i in seq_along(x@enum_names)) {
      cat("  ", x@enum_names[i], ": ", format(x@values[[i]]), "\n", sep = "")
    }
  }
  invisible(x)
}

#' Check if an object is an Enum
#'
#' @param x An object to test.
#'
#' @return `TRUE` if the object is an Enum, `FALSE` otherwise.
#'
#' @examples
#' colors <- Enum(RED = 1, GREEN = 2, BLUE = 3)
#' is.enum(colors) # TRUE
#' is.enum(list(a = 1, b = 2)) # FALSE
#'
#' @export
is.enum <- function(x) {
  S7::S7_inherits(x, Enum_class)
}

# Equality comparison
#' @export
S7::method(`==`, list(Enum_class, Enum_class)) <- function(e1, e2) {
  identical(e1@values, e2@values) && identical(e1@enum_names, e2@enum_names)
}

# Inequality comparison
#' @export
S7::method(`!=`, list(Enum_class, Enum_class)) <- function(e1, e2) {
  !(e1 == e2)
}

# Helper function for NULL-default operator
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}
