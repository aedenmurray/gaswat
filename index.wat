(module
  (global $str (import "string_constants" "console.log('a')") externref)
  (func $fn (import "env" "fn") (param externref))

  (func $init
    global.get $str
    call $fn
  )
  
  (start $init)
)