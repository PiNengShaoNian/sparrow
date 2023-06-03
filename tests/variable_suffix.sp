import test_utils for assert_equal, assert_deep_equal

var a = 1

assert_equal(2, a += 1, "assert failed!")
assert_equal(2, a, "assert failed!")
assert_equal(2, a++, "assert failed!")
assert_equal(3, a, "assert failed!")
a = Fn.new{|a, b|
    return a + b
}

assert_equal(666, a(333, 333), "assert failed!")

fun test_local_variable_suffix() {
    var b = 1

    assert_equal(2, b += 1, "assert failed!")
    assert_equal(2, b, "assert failed!")
    assert_equal(2, b++, "assert failed!")
    assert_equal(3, b, "assert failed!")
    b = Fn.new{|a, b|
        return a + b
    }

    assert_equal(666, b(333, 333), "assert failed!")
}

test_local_variable_suffix()


var i = 0
var list = []
a = Fn.new{
    list.add(i++)
    return a
}
a()()()
assert_deep_equal([0, 1, 2], list, "assert failed!")