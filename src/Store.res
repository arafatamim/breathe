open Rx

type dispatch<'action> = 'action => unit

type sub<'action> = dispatch<'action> => unit

module Effect = {
  type t<'action> = sub<'action>
  let none: t<'action> = _ => ()
  let fromAction: 'action => t<'action> = (action, dispatch) => dispatch(action)

  let ofSub: sub<'action> => t<'action> = sub => sub

  let fromPromise: Promise.t<'action> => t<'action> = promise => {
    let delayedEffect = dispatch => {
      promise->Promise.thenResolve(res => dispatch(res))->ignore
    }
    ofSub(delayedEffect)
  }
}

type reducer<'state, 'action> = ('state, 'action) => ('state, Effect.t<'action>)

type t<'state, 'action> = {
  subscribe: ('state => unit) => unit,
  dispatch: dispatch<'action>,
}

let make: (reducer<'state, 'action>, 'state) => t<'state, 'action> = (reducer, initialState) => {
  let state = BehaviorSubject.make(initialState)

  let rec dispatch = action => {
    let oldState = state->BehaviorSubject.getValue()
    let (newState, effect) = reducer(oldState, action)
    state->BehaviorSubject.next(newState)
    effect(dispatch)
  }

  let subscribe = callback => state->BehaviorSubject.subscribe(callback)

  {
    dispatch: dispatch,
    subscribe: subscribe,
  }
}
