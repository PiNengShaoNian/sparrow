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