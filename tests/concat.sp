import test_utils for assert_equal

var a = [1, 2]
var b = [3, 4]
fun concat(a, b) {
    var ans = []

    for x (a) {
        ans.add(x)
    }

    for x (b) {
        ans.add(x)
    }

    return ans
}

assert_equal(a.count, 2, "`a.count == 2` assert failed!")
assert_equal(b.count, 2, "`b.count == 2` assert failed!")
var c = concat(a, b)
assert_equal(c.count, 4, "`c.count == 4` assert failed!")
assert_equal(c[0], 1, "`c[0] == 1` assert failed!")
assert_equal(c[1], 2, "`c[1] == 2` assert failed!")
assert_equal(c[2], 3, "`c[2] == 3` assert failed!")
assert_equal(c[3], 4, "`c[3] == 4` assert failed!")
