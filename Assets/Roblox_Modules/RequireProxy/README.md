## RequireProxy
[RequireProxy]: #user-content-requireproxy
This module allows you to "bypass" a sandboxed
require function with a metatable

To use the module
```lua
require(script:WaitForChild'RequireProxy')(module asset id here)(other stuff)
--ModuleScript Instance ^

require(proxy asset id)(module asset id)(extras here)
--proxy asset id ^
```
