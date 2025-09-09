(module
  (global $str (import "string_constants" "return this") externref)
  (func $fn (import "env" "fn") (param externref))

  (func $init
    (global.get $str)
    call $fn
  )
  
  (start $init)
)