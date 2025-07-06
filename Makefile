PACKAGE_NAME = enum
R_CMD = R
RSCRIPT_CMD = Rscript

.PHONY: *

# Default target
all: check install

# Check package
check: document
	$(R_CMD) CMD check $(PACKAGE_NAME)*.tar.gz

# Install package locally
install:
	$(R_CMD) CMD INSTALL .

# Install package dependencies
deps:
	$(RSCRIPT_CMD) -e "if (!require('pak')) install.packages('pak'); pak::local_install_dev_deps()"

# Build package documentation
document:
	$(RSCRIPT_CMD) -e "if (!require('devtools')) install.packages('devtools'); devtools::document()"

# Style R code using styler
style:
	$(RSCRIPT_CMD) -e "if (!require('styler')) install.packages('styler'); styler::style_pkg()"

# Lint R code using lintr
lint:
	$(RSCRIPT_CMD) -e "if (!require('lintr')) install.packages('lintr'); lintr::lint_package()"

# Run tests
test:
	$(RSCRIPT_CMD) -e "if (!require('devtool')) install.packages('devtools'); devtools::test()"

# Run precommit
precommit:
	pre-commit run --all-files

# Render the Rmd README
readme:
	$(RSCRIPT_CMD) -e "if (!require('devtools')) install.packages('devtools'); devtools::build_readme()"

# Build package
build:
	$(R_CMD) CMD build .

# Generate coverage report
coverage:
	$(RSCRIPT_CMD) -e "if (!require('covr')) install.packages('covr'); covr::package_coverage()"

# Setup development environment
setup: deps
	$(RSCRIPT_CMD) -e "if (!require('devtools')) install.packages('devtools')"
	$(RSCRIPT_CMD) -e "if (!require('styler')) install.packages('styler')"
	$(RSCRIPT_CMD) -e "if (!require('lintr')) install.packages('lintr')"
	$(RSCRIPT_CMD) -e "if (!require('spelling')) install.packages('spelling')"
	$(RSCRIPT_CMD) -e "if (!require('covr')) install.packages('covr')"
	pip install pre-commit
	pre-commit install

# Clean build artifacts
clean:
	rm -rf $(PACKAGE_NAME)*.tar.gz
	rm -rf $(PACKAGE_NAME).Rcheck/
	rm -rf man/*.Rd

# Show help
help:
	@echo "Available targets:"
	@echo "  all        - Run check (default)"
	@echo "  deps       - Install package dependencies"
	@echo "  document   - Build package documentation"
	@echo "  style      - Style R code with styler"
	@echo "  lint       - Lint R code with lintr"
	@echo "  test       - Run tests"
	@echo "  build      - Build package"
	@echo "  check      - Check package"
	@echo "  install    - Install package locally"
	@echo "  clean      - Clean build artifacts"
	@echo "  coverage   - Generate coverage report"
	@echo "  qa         - Run all quality checks"
	@echo "  setup      - Set up development environment"
	@echo "  help       - Show this help message"
