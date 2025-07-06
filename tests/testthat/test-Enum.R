test_that("Enum can be created with named values", {
  # Test creating an enum with character values
  color_enum <- Enum(RED = "red", GREEN = "green", BLUE = "blue")
  expect_true(is.enum(color_enum))
})

test_that("Enum can be created with numeric values", {
  # Test creating an enum with numeric values
  priority_enum <- Enum(LOW = 1, MEDIUM = 2, HIGH = 3)
  expect_true(is.enum(priority_enum))
})

test_that("Enum can be created with mixed value types", {
  # Test creating an enum with different value types
  mixed_enum <- Enum(ZERO = 0L, ONE = "one", TWO = 2.0, THREE = TRUE)
  expect_true(is.enum(mixed_enum))
})

test_that("Empty Enum can be created", {
  empty_enum <- Enum()
  expect_true(is.enum(empty_enum))
  expect_equal(length(empty_enum), 0)
})

test_that("Enum values can be compared for equality", {
  status_enum <- Enum(ACTIVE = 1, INACTIVE = 0)
  expect_true(status_enum$ACTIVE == 1)
  expect_true(status_enum$INACTIVE == 0)
  expect_false(status_enum$ACTIVE == 0)
  expect_false(status_enum$INACTIVE == 1)
})

test_that("Two identical Enums are equal", {
  enum1 <- Enum(A = 1, B = 2, C = 3)
  enum2 <- Enum(A = 1, B = 2, C = 3)
  expect_true(enum1 == enum2)
})

test_that("Two different Enums are not equal", {
  enum1 <- Enum(A = 1, B = 2, C = 3)
  enum2 <- Enum(A = 1, B = 2, C = 4)
  expect_false(enum1 == enum2)
})

test_that("Enum can be converted to list", {
  grade_enum <- Enum(A = 90, B = 80, C = 70)
  grade_list <- as.list(grade_enum)
  expect_type(grade_list, "list")
  expect_equal(grade_list$A, 90)
  expect_equal(grade_list$B, 80)
  expect_equal(grade_list$C, 70)
})

test_that("Enum can be converted to vector", {
  grade_enum <- Enum(A = 90, B = 80, C = 70)
  grade_vector <- as.vector(grade_enum)
  expect_type(grade_vector, "double")
  expect_equal(grade_vector, c(90, 80, 70))
})


test_that("Enum throws error for invalid access", {
  status_enum <- Enum(PENDING = "pending", COMPLETE = "complete")
  expect_error(status_enum$INVALID, "Invalid enum name")
})

test_that("Enum throws error for duplicate names", {
  expect_error(Enum(A = 1, A = 2), "Duplicate enum names")
})

test_that("Enum throws error for unnamed values", {
  expect_error(Enum("red", "green", "blue"), "All enum values must be named")
})

test_that("Enum is immutable - cannot modify existing values", {
  status_enum <- Enum(PENDING = "pending", COMPLETE = "complete")
  expect_error(status_enum$PENDING <- "new_pending", "Cannot modify enum")
})

test_that("Enum is immutable - cannot add new values", {
  status_enum <- Enum(PENDING = "pending", COMPLETE = "complete")
  expect_error(status_enum$NEW_STATUS <- "new", "Cannot modify enum")
})

test_that("Enum is immutable - cannot delete values", {
  status_enum <- Enum(PENDING = "pending", COMPLETE = "complete")
  expect_error(status_enum$PENDING <- NULL, "Cannot modify enum")
})
