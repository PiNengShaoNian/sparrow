import test_utils for assert_equal

var total = 0

switch(2) { 
  case 1: { 
    total += 1
  } 
  case 2: { 
    total += 2
  } 
  case 3: { 
    total += 4
    break
  } 
  case 4: { 
    total += 8
  }
}

assert_equal(total, 6, "assert failed!")