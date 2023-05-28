import test_utils for assert_true

class MyClass
{
  var x
  new()
  {
    x = 2
  }
}


var o = MyClass.new()
var o2 = MyClass.new()

o2.x = 5
o = o2

assert_true(o.x == 5, "`o.x == 5` assert failed!")
assert_true(o == o2, "`o == o2` assert failed!")

o2.x = 3

assert_true(o2.x == o.x, "`o2.x == o.x` assert failed!")
assert_true(o2.x == 3, "`o2.x == 3` assert failed!")
assert_true(o == o2, "`o == o2` assert failed!")