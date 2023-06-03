import test_utils for assert_equal

var a = [1]
assert_equal(2, a[0] += 1, "assert failed!")
assert_equal(2, a[0], "assert failed!")
assert_equal(2, a[0]++, "assert failed!")
assert_equal(3, a[0], "assert failed!")
a[0] = Fn.new{|a, b|
    return a + b
}
assert_equal(666, a[0](333, 333), "assert failed!")


a[0] = [1]
assert_equal(2, a[0][0] += 1, "assert failed!")
assert_equal(2, a[0][0], "assert failed!")
assert_equal(2, a[0][0]++, "assert failed!")
assert_equal(3, a[0][0], "assert failed!")
a[0][0] = Fn.new{|a, b|
    return a + b
}
assert_equal(666, a[0][0](333, 333), "assert failed!")