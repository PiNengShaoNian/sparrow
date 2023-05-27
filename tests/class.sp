import test_utils for assert_equal

class Vector3
{
  var x
  var y
  var z

  new(a,b,c)
  {
    x = a
    y = b
    z = c
  }

  doSomething(mult)
  {
    return x * y * z * mult
  }
}


var v = Vector3.new(1,2,3)
assert_equal(1, v.x, "`1 == v.x` assert failed!")
assert_equal(v.doSomething(2), 12, "`v.doSomething(2) == 12` assert failed!")