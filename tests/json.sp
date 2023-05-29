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
        idx = idx + 1
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
      idx = idx + 1
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
        idx = idx + 1
        continue
      }

      if(str[idx] == "]") {
        idx = idx + 1
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
        idx = idx + 1
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
      idx = idx + 1
    }

    if(idx >= n) {
      Thread.abort("unterminated string")
    } else {
      idx = idx + 1
      return str[start..idx-2]
    }
  }

  parseNum = Fn.new{
    var a = 0
    while(idx < n) {
      var char = str.byteAt_(idx) - 48
      if(char >= 0 && char <= 9) {
        a = a * 10 + char
        idx = idx + 1
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
    }

    if(c == "[") {
      return paseArray()
    }

    if(n - idx >= 4 && str[idx..idx+3] == "null") {
      return null
    }
    
    if(n - idx >= 4 && str[idx..idx+3] == "true") {
      return true
    }

    if(n - idx >= 5 && str[idx..4] == "false") {
      return false
    }

    if(str[idx] == "\"") {
      return parseStr()
    }


    if(str.byteAt_(idx) >= 48 && str.byteAt_(idx) <= 57) {
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
    if(v.type == List) {
      var first = true
      ans = ans + "["
      for x (v) {
        if(!first) {
          ans = ans + ","
        }
        first = false
        Impl(x)
      }
      ans = ans + "]"
      return
    }

    if(v.type == Map) {
      var first = true
      ans = ans + "{"
      for key (v.keys) {
        var value = v[key]
        if(!first) {
          ans = ans + "," 
        }
        first = false
        Impl(key)
        ans = ans + ":"
        Impl(value)
      }
      ans = ans + "}"
      return
    }

    if(v.type == String) {
      ans = ans + "\"%(v)\""
      return
    }

    if(v.type == Num) {
      ans = ans + "%(v.toString)"
      return
    }

    Thread.abort("unreachable!")
  }

  Impl(obj)
  return ans
}