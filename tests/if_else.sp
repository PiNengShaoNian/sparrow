import test_utils for assert_equal

var i = 3
var b1 = false
var b2 = false

if (i == 2) {
  b1 = true
}
else {
  b2 = true
}

assert_equal(false, b1, "`false == b1` assert failed!")
assert_equal(true, b2, "`true == b2` assert failed!")