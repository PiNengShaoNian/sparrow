import test_utils for assert_equal

class Bob {
    new(){}

    bob3() {
        return [1, 2, 3]
    }
}

var b = Bob.new()

assert_equal(b.bob3()[0], 1, "`b.bob3()[0] == 1` assert failed!")
assert_equal((b.bob3())[1], 2, "`(b.bob3())[1] == 2` assert failed!")