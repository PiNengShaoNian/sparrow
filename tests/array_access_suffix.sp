import test_utils for assert_equal, assert_deep_equal

var a = [1]
assert_equal(2, a[0] += 1, "assert failed!")
assert_equal(2, a[0], "assert failed!")
assert_equal(2, a[0]++, "assert failed!")
assert_equal(3, a[0], "assert failed!")
a[0] = Fn.new{|a, b|
    return a + b
}
assert_equal(666, a[0](333, 333), "assert failed!")

var i = 0
var list = []
a[0] = Fn.new{
    list.add(i++)
    return a
}
a[0]()[0]()[0]()
assert_deep_equal([0, 1, 2], list, "assert failed!")


a[0] = [1]
assert_equal(2, a[0][0] += 1, "assert failed!")
assert_equal(2, a[0][0], "assert failed!")
assert_equal(2, a[0][0]++, "assert failed!")
assert_equal(3, a[0][0], "assert failed!")
a[0][0] = Fn.new{|a, b|
    return a + b
}
assert_equal(666, a[0][0](333, 333), "assert failed!")