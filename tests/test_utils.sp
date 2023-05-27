fun assert_true(condition, msg) {
    if(condition != true)
    {
        Thread.abort(msg)
    }
}