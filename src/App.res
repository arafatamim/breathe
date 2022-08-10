open Types

let patch = {
  open Snabbdom
  init(
    [styleModule, propsModule, attributesModule, eventListenersModule],
    Obj.magic(),
    {"experimental": {"fragments": true}},
  )
}

let mount = {
  open Webapi.Dom
  document->Document.getElementById("app")->Js.Option.getExn->ref
}

let decrementTimer = initialTimer => {
  let sub = dispatch => {
    Js.Global.setTimeout(() => {
      dispatch(SetTimer(initialTimer - 1))
    }, 1000)->ignore
  }
  if initialTimer == 0 {
    Effect.fromAction(Stop)
  } else {
    Effect.ofSub(sub)
  }
}

let initialState = {
  page: Home,
  timer: 110,
}

let reducer = (state, action) =>
  switch action {
  | Start => ({...state, page: Exercise}, decrementTimer(state.timer))
  | Stop => ({page: Home, timer: initialState.timer}, [])
  | SetTimer(num) => ({...state, timer: num}, decrementTimer(num))
  }

let store = Store.make(reducer, initialState)

let app = state => {
  open Snabbdom
  h(
    "div#root",
    empty,
    [
      h(
        "div.App",
        empty,
        [
          switch state.page {
          | Home => Home.make(store, state)
          | Exercise => Exercise.make(store, state)
          },
        ],
      ),
    ],
  )
}

store.subscribe(state => {
  let component = app(state)
  mount.contents = patch(mount.contents, component)
}) |> ignore
