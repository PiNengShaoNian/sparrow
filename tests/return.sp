import test_utils for assert_equal

fun sam() {
  return 5
}

assert_equal(5, sam(), "assert failed!")