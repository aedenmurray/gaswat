(module
  (global $h (import "string_constants" "hello ") externref)
  (func $fn (import "env" "fn") (param externref))

  (func $init
    (global.get $h)
    call $fn 
  )
  
  (start $init)
)