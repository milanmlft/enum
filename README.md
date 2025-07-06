
<!-- README.md is generated from README.Rmd. Please edit that file -->

# enum

<!-- badges: start -->

[![R-CMD-check](https://github.com/milanmlft/enum/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/milanmlft/enum/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/milanmlft/enum/graph/badge.svg)](https://app.codecov.io/gh/milanmlft/enum)
<!-- badges: end -->

The `enum` package provides a robust implementation of enumerations
(enums) for R, enabling the creation of type-safe, validated sets of
named constants. Enums help prevent errors by constraining variables to
predefined values and offer better code readability and maintainability.

## Installation

You can install the development version of enum from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("milanmlft/enum")
```

## Example

``` r
library(enum)

# Create an enum for days of the week
Days <- Enum(
  MONDAY = 1,
  TUESDAY = 2,
  WEDNESDAY = 3,
  THURSDAY = 4,
  FRIDAY = 5,
  SATURDAY = 6,
  SUNDAY = 7
)

# Use the enum
today <- Days$MONDAY
today
#> [1] 1
```

## Features

- **Validation**: Values are automatically validated against defined
  constants
- **Readability**: Named constants make code more self-documenting
- **Maintainability**: Centralized definition of related constants

## Development

This package uses [pre-commit](https://pre-commit.com/) hooks to ensure
code quality. To set up the development environment:

``` bash
# Install pre-commit
pip install pre-commit

# Install the hooks
pre-commit install

# Run hooks manually
pre-commit run --all-files
```

## License

This project is licensed under the MIT License - see the
[LICENSE](LICENSE) file for details.
