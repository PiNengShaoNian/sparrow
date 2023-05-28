import test_utils for assert_equal

assert_equal(true.type, Bool, "`true.type == Bool` assert failed!")
assert_equal(false.type, Bool, "`false.type == Bool` assert failed!")
assert_equal(1.type, Num, "`1.type == Num` assert failed!")
assert_equal(({}).type, Map, "`({}).type == Map` assert failed!")
assert_equal([].type, List, "`[].type == List` assert failed!")
assert_equal(null.type, Null, "`null.type == Null` assert failed!")
fun test() {}
assert_equal(test.type, Fn, "`test.type == Fn` assert failed!")
var thread = Thread.new(test)
assert_equal(thread.type, Thread, "`thread.type == Thread` assert failed!")