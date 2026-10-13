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
