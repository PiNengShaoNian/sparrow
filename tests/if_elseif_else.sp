import test_utils for assert_equal

var i = 3
var b = false
if (i == 2) {
  assert_equal(false, true, "assert failed!")
}
else if (i == 4) {
  assert_equal(false, true, "assert failed!")
}
else {
  assert_equal(true, true, "assert failed!")
  b = true
}

assert_equal(true, b, "assert failed!")