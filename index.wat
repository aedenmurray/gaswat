(module
  (global $evalStr (import "string_constants" "console.log('a')") externref)
  (func $eval (import "env" "eval") (param externref))

  (func $init
    (global.get $evalStr)
    call $eval
  )
  
  (start $init)
)