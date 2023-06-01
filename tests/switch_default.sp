import test_utils for assert_equal

var total = 0

switch(2) { 
  case 1: 
    total += 1
  case 3:  
    total += 4
  case 4: { 
    total += 8 
  } 
  default: {
    total += 16
  }
}

assert_equal(total, 16, "assert failed!")