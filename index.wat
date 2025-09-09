(module
  (import "env" "fn" (func $fn (param i32)))
  (data (i32.const 0) "Hello from WASM!")
  (memory (export "memory") 1)

  (func $init
    i32.const 0
    call $fn
  )
  
  (start $init)
)