import test_utils for assert_equal

fun join(list, separator) {
  var ans = ""
  var first = true
  for x (list) {
    if(!first) {
        ans = ans + separator
    }
    else {
      first = false
    }
    ans = ans + x.toString
  }
  return ans
}

assert_equal("1*2*3", join([1, 2, 3], "*"), "`\"1*2*3\" == join([1, 2, 3], \".\")` assert failed!")