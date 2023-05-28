import test_utils for assert_equal

var a = [1,2,3, [4,5,6] ]

assert_equal(a[3][0], 4, "`a[3][0] == 4` assert failed!")


class Test {
    var a
    new() {
        a = [1, 2, 3]
    }
}

var t = Test.new()

assert_equal(t.a[0], 1, "`t.a[0] == 1` assert failed!")