type page = Home | Started

type state = {page: page}

let init = {
  page: Home,
}

type action = StartExercise | StopExercise

let reducer = (_state, action) => {
  switch action {
  | StartExercise => {page: Started}
  | StopExercise => {page: Home}
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, init)

  <div className="App">
    {switch state.page {
    | Home => <Home onStart={() => dispatch(StartExercise)} />
    | Started => <Exercise onAbort={() => dispatch(StopExercise)} />
    }}
  </div>
}
