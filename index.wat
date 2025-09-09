(module
  (import "x" "default" (func $x))

  (func $init
    call $x
  )
  
  (start $init)
)