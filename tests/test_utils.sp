fun assert_true(condition, msg) {
    if(condition != true)
    {
        Thread.abort(msg)
    }
}

fun assert_false(condition, msg) {
    if(condition != false)
    {
        Thread.abort(msg)
    }
}

fun assert_equal(a, b, msg) {
    if(a != b) 
    {
        Thread.abort(msg)
    }
}

fun assert_deep_equal(a, b, msg) {
    if(a.type != b.type) 
    {
        Thread.abort(msg)
    }

    if(a.type == String || a.type == Num || a == null) {
        assert_equal(a, b, msg)
        return
    }

    if(a.type == List) {
        assert_equal(a.count, b.count, msg)
        if(a.count == 0) {
            return
        }
        for i (0..a.count-1) {
            assert_deep_equal(a[i], b[i], msg)
        }
        return
    }

    if(a.type == Map) {
        assert_equal(a.count, b.count, msg)
        for key (a.keys) {
            assert_deep_equal(a[key], b[key], msg)
        }
        return
    }

    assert_equal(a, b, msg)
}