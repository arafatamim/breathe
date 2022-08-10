@module("snabbdom") external h: (string, {..}, array<Dom.element>) => Dom.element = "h"

type patchFn = (Dom.element, Dom.element) => Dom.element

@module("snabbdom") external init: (array<{..}>, Obj.t, 'b) => patchFn = "init"

@module("snabbdom") external propsModule: 'a = "propsModule"
@module("snabbdom") external styleModule: 'a = "styleModule"
@module("snabbdom") external eventListenersModule: 'a = "eventListenersModule"
@module("snabbdom") external attributesModule: 'a = "attributesModule"
@module("snabbdom") external fragment: array<Dom.element> => Dom.element = "fragment"

external string: string => Dom.element = "%identity"
external int: int => Dom.element = "%identity"

let empty = Js.Obj.empty()
