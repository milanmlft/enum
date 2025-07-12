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
