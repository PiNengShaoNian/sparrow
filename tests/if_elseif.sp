import test_utils for assert_equal

var b1 = false
var b2 = false
var b3 = false

var i = 3
if (i == 2) {
  b1 = true
}
else if (i == 4) {
  b2 = true
}
else if (i == 3) {
  b3 = true
}

assert_equal(false, b1, "`false == b1` assert failed!")
assert_equal(false, b2, "`false == b2` assert failed!")
assert_equal(true, b3, "`true == b3` assert failed!")