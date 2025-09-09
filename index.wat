(module
  (import "env" "fn" (func $fn (param i32 i32)))
  (memory (export "memory") 1)
  (data (i32.const 0) "Hello from WASM!")

  (func $init
    i32.const 0   ;; pointer to string
    i32.const 16  ;; length of string
    call $fn
  )
  
  (start $init)
)