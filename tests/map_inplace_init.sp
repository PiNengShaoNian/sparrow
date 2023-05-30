import test_utils for assert_equal

var x = {"bob":1, "fred":2}

assert_equal(2, x.count, "assert failed!")


// Make sure vector elements are copied into place for consistency with
// map inplace construction
var i = 1
var y = {"a":i}

assert_equal(1, y["a"], "assert failed!")
i = 3
assert_equal(3, i, "assert failed!")
assert_equal(1, y["a"], "assert failed!")