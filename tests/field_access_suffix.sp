import test_utils for assert_equal

class Foo {
    static var x1 = 1
    var x2

    new() {
        x2 = 1
    }
}

assert_equal(2, Foo.x1 += 1, "assert failed!")
assert_equal(2, Foo.x1, "assert failed!")
assert_equal(2, Foo.x1++, "assert failed!")
assert_equal(3, Foo.x1, "assert failed!")


var a = Foo.new()
assert_equal(2, a.x2 += 1, "assert failed!")
assert_equal(2, a.x2, "assert failed!")
assert_equal(2, a.x2++, "assert failed!")
assert_equal(3, a.x2, "assert failed!")