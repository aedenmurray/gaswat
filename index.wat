(module
  (import "env" "fn" (func $fn (param externref)))
  (global $str (import "string_constants" "aaa") externref)

  (func $init
    (global.get $str)
    call $fn 
  )
  
  (start $init)
)