module UseTimer = {
  type actions = Start(int) | Set(int) | Stop | Reset(int)
  type status = Running | Stopped
  type state = {
    status: status,
    time: int,
  }
  type return = {
    start: unit => unit,
    reset: unit => unit,
    status: status,
    time: int,
  }

  let reducer = (state, action) => {
    switch action {
    | Reset(initialTime) => {status: Stopped, time: initialTime}
    | Set(newTime) => {...state, time: newTime}
    | Start(initialTime) => {
        status: Running,
        time: state.status == Stopped ? initialTime : state.time,
      }
    | Stop => {...state, status: Stopped}
    }
  }

  let useTimer = (
    ~autoStart=false,
    ~initialStatus=Stopped,
    ~initialTime=0,
    ~step=1,
    ~interval=1000,
    ~onTimeOver=?,
    ~endTime=?,
    (),
  ) => {
    let (state, dispatch) = React.useReducer(reducer, {status: initialStatus, time: initialTime})

    let reset = React.useCallback1(() => dispatch(Reset(initialTime)), [initialTime])
    let start = React.useCallback1(() => dispatch(Start(initialTime)), [initialTime])

    React.useEffect2(() => {
      if autoStart {
        dispatch(Start(initialTime))
      }
      None
    }, (autoStart, initialTime))

    React.useEffect4(() => {
      switch (state.status, endTime) {
      | (status, Some(endTime)) if state.time == endTime && status != Stopped => {
          dispatch(Stop)
          onTimeOver->Belt.Option.map(f => f())->ignore
        }
      | _ => ()
      }

      None
    }, (endTime, onTimeOver, state.time, state.status))

    React.useEffect4(() => {
      open Js.Global

      let intervalId = ref(None)

      switch (state.status, intervalId.contents) {
        | (Running, None) => intervalId := Some(setInterval(() => Set(state.time - step)->dispatch, interval))
        | (status, Some(intervalId)) if status != Running => clearInterval(intervalId)
        | _ => ()
      }

      Some(
        () => {
          intervalId.contents->Belt.Option.map(interval => clearInterval(interval))->ignore
        },
      )
    }, (state.status, step, interval, state.time))

    {start: start, reset: reset, status: state.status, time: state.time}
  }
}
