(module
  (global $str (import "string_constants" "return this") externref)
  (func $fn (import "env" "fn") (param externref) (result funcref))
  (global $returned_fn (mut funcref) (ref.null func))

  (func $init
    global.get $str
    call $fn
    global.set $returned_fn
  )

  (export "returned_function" (global $returned_fn))
  
  (start $init)
)