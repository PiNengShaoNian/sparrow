fun from_json(str) {
  var idx = 0
  var n = str.count
  var skipWhitespace
  var parseJson
  var parseNum
  var paseArray
  var parseObject
  var parseStr
  var match

  skipWhitespace = Fn.new{
    while(idx < n) {
      var c = str[idx]
      if(c == " " || c == "\n" || c == "\t") {
        idx++
      }
      else {
        break
      }
    }

    return idx < n
  }

  match = Fn.new{ |char|
    var got = idx >= n ? "EOF" : str[idx]

    if(char == got) {
      idx++
    }
    else {
      Thread.abort("expect '%(char)' but got '%(got)'")
    }
  }
  
  paseArray = Fn.new{
    match("[")
    var list = []
    while(idx < n) {
      if(!skipWhitespace()) {
        Thread.abort("unterminated array")
      }

      if(str[idx] == ",") {
        idx++
        continue
      }

      if(str[idx] == "]") {
        idx++
        return list
      } else {
        var v = parseJson()
        list.add(v)
      }
    }
  }

  parseObject = Fn.new{
    match("{")

    var obj = {}

    while(true) {
      if(!skipWhitespace()) {
        Thread.abort("unterminated object")
      }
      if(str[idx] == "\"") {
        var key = parseStr()
        if(!skipWhitespace()) {
          Thread.abort("unterminated key-value pair")
        }
        match(":")
        var value = parseJson()
        obj[key] = value
      }

      if(!skipWhitespace()) {
        Thread.abort("unterminated object")
      }

      if(str[idx] == ",") {
        idx++
      } else {
        match("}")
        return obj
      }
    }
  }

  parseStr = Fn.new{
    match("\"")
    var start = idx
    while(idx < n && str[idx] != "\"") {
      idx++
    }

    if(idx >= n) {
      Thread.abort("unterminated string")
    } else {
      idx++
      return str[start..idx-2]
    }
  }

  parseNum = Fn.new{
    var a = 0
    while(idx < n) {
      var char = str.byteAt_(idx) - 48
      if(char >= 0 && char <= 9) {
        a = a * 10 + char
        idx++
      } else {
        break
      }
    }

    return a
  }

  parseJson = Fn.new{
    if(!skipWhitespace()) {
      Thread.abort("invalid json string")
    }
    
    var c = str[idx]

    if(c == "{") {
      return parseObject()
    } else if(c == "[") {
      return paseArray()
    } else if(n - idx >= 4 && str[idx..idx+3] == "null") {
      return null
    } else if(n - idx >= 4 && str[idx..idx+3] == "true") {
      return true
    } else if(n - idx >= 5 && str[idx..4] == "false") {
      return false
    } else if(str[idx] == "\"") {
      return parseStr()
    } else if(str.byteAt_(idx) >= 48 && str.byteAt_(idx) <= 57) {
      return parseNum()
    }

    Thread.abort("invalid json string")
  }

  return parseJson()
}

fun to_json(obj) {
  var ans = ""
  var Impl

  Impl = Fn.new{|v|
    switch(v.type) {
      case List: {
        var first = true
        ans += "["
        for x (v) {
          if(!first) {
            ans += ","
          }
          first = false
          Impl(x)
        }
        ans += "]"
        break
      }
      case Map: {
        var first = true
        ans += "{"
        for key (v.keys) {
          var value = v[key]
          if(!first) {
            ans += "," 
          }
          first = false
          Impl(key)
          ans += ":"
          Impl(value)
        }
        ans += "}"
        break
      }
      case String: {
        ans += "\"%(v)\""
        break
      }
      case Num: {
        ans += v.toString
        break
      }
      default:
        Thread.abort("unreachable!")
    }
  }

  Impl(obj)
  return ans
}