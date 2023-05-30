import test_utils for assert_equal

var ans = ""
var i = 0
var thread = Thread.new{
  while(i < 10) {
    ans = ans + "b"
    i = i + 1
    Thread.yield()
  }
}

while(i < 10) {
  ans = ans + "a"
  i = i + 1
  thread.call()
}

assert_equal(ans, "ababababab", "assert failed!")