import test_utils for assert_equal

class Bob {
    var z
    new() {}
}

var x = Bob.new()
x.z = 10
var y = Bob.new()
y.z = 20

assert_equal(10, x.z, "assert failed!")
assert_equal(20, y.z, "assert failed!")