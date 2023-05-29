import test_utils for assert_equal

{
    var a = 1
    var b = 2
    assert_equal(a + b, 3, "`a + b == 3` assert failed!")
}

{
    var a = 3
    var b = 4
    assert_equal(a + b, 7, "`a + b == 7` assert failed!")
}

fun test() {
    var a = 1
    var b = 2
    var c = 666
    {
        var a = 3
        var b = 4
        assert_equal(a + b, 7, "`a + b == 7` assert failed!")
    
        {
            var a = 5
            var b = 6
            assert_equal(a + b, 11, "`a + b == 11` assert failed!")
        }
    }
    
    {
        var a = 7
        var b = 8
        assert_equal(a + b, 15, "`a + b == 15` assert failed!")
    }

    assert_equal(a + b, 3, "`a + b == 3` assert failed!")
    assert_equal(c, 666, "`c == 666` assert failed!")
}

test()