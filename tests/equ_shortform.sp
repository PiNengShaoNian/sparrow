import test_utils for assert_equal

var x=.5
assert_equal(.5, x, "`.5 == x` assert failed!")
var y=-.5
assert_equal(-.5, y, "`-.5 == y` assert failed!")