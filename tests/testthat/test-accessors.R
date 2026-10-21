test_that("Enum values can be accessed by name", {
  status_enum <- Enum(PENDING = "pending", COMPLETE = "complete", FAILED = "failed")
  expect_equal(status_enum$PENDING, "pending")
  expect_equal(status_enum$COMPLETE, "complete")
  expect_equal(status_enum$FAILED, "failed")
})

test_that("Enum values can be accessed using bracket notation", {
  status_enum <- Enum(PENDING = "pending", COMPLETE = "complete", FAILED = "failed")
  expect_equal(status_enum[["PENDING"]], "pending")
  expect_equal(status_enum[["COMPLETE"]], "complete")
  expect_equal(status_enum[["FAILED"]], "failed")
})

test_that("Enum names can be retrieved", {
  day_enum <- Enum(MONDAY = 1, TUESDAY = 2, WEDNESDAY = 3)
  expect_equal(names(day_enum), c("MONDAY", "TUESDAY", "WEDNESDAY"))
})

test_that("Enum length returns correct count", {
  day_enum <- Enum(MONDAY = 1, TUESDAY = 2, WEDNESDAY = 3)
  expect_equal(length(day_enum), 3)
})

test_that("is.valid function works correctly", {
  colors <- Enum(RED = 1, GREEN = 2, BLUE = 3)
  expect_true(is.valid(colors, 1))
  expect_true(is.valid(colors, 2))
  expect_true(is.valid(colors, 3))
  expect_false(is.valid(colors, 4))
  expect_false(is.valid(colors, "red"))
})

test_that("key.by.value function works correctly", {
  colors <- Enum(RED = 1, GREEN = 2, BLUE = 3)
  expect_equal(key.by.value(colors, 1), "RED")
  expect_equal(key.by.value(colors, 2), "GREEN")
  expect_equal(key.by.value(colors, 3), "BLUE")
  expect_null(key.by.value(colors, 4))
  expect_null(key.by.value(colors, "red"))
})

test_that("Utility functions handle edge cases", {
  empty_enum <- Enum()
  expect_false(is.valid(empty_enum, 1))
  expect_null(key.by.value(empty_enum, 1))
})

test_that("is.valid and key.by.value are exported", {
  expect_true(all(c("is.valid", "key.by.value") %in% getNamespaceExports("enum")))
})

test_that("is.valid and key.by.value are type-aware", {
  e <- Enum(RED = 1, GREEN = 2, BLUE = 3)
  expect_false(is.valid(e, "1"))
  expect_null(key.by.value(e, "1"))
  expect_false(is.valid(e, TRUE))
  expect_null(key.by.value(e, TRUE))

  s <- Enum(A = "a", B = "b")
  expect_true(is.valid(s, "a"))
  expect_false(is.valid(s, 1))
})

test_that("lookups work with vector, NULL and function values", {
  for (e in list(Enum(A = 1:3, B = 2), Enum(A = NULL, B = 2), Enum(A = sum, B = 2))) {
    expect_no_error(is.valid(e, 2))
    expect_true(is.valid(e, 2))
    expect_equal(key.by.value(e, 2), "B")
  }
  expect_true(is.valid(Enum(A = NULL, B = 2), NULL))
  expect_equal(key.by.value(Enum(A = NULL, B = 2), NULL), "A")
  expect_equal(key.by.value(Enum(A = sum, B = 2), sum), "A")
  expect_equal(key.by.value(Enum(A = 1:3, B = 2), 1:3), "A")
})

test_that("a vector value is matched as a whole and returns a scalar", {
  v <- Enum(A = 1:3)
  expect_true(is.valid(v, 1:3))
  expect_false(is.valid(v, 1))
  expect_false(is.valid(v, 1:2))

  e <- Enum(RED = 1, GREEN = 2, BLUE = 3)
  expect_identical(is.valid(e, c(1, 2)), FALSE)
  expect_identical(is.valid(e, numeric(0)), FALSE)
  expect_null(key.by.value(e, c(1, 2)))
  expect_identical(key.by.value(e, 2), "GREEN")
})

test_that("key.by.value returns the first match for duplicate values", {
  dup <- Enum(A = 1, B = 1, C = 2)
  expect_equal(key.by.value(dup, 1), "A")
  expect_equal(key.by.value(dup, 2), "C")
})

test_that("is.valid and key.by.value reject non-Enum input", {
  expect_error(is.valid(list(A = 1), 1), "First argument must be an Enum")
  expect_error(key.by.value("x", 1), "First argument must be an Enum")
})
