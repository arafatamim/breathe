@send
external padStart: (string, int, string) => string = "padStart"

let formatSeconds = num => {
  let min = mod(num, 3600) / 60
  let secs = mod(num, 60)
  `${string_of_int(min)}:${secs->string_of_int->padStart(2, "0")}`
}

@react.component
let make = (~onAbort) => {
  open React

  let {time} = Hooks.UseTimer.useTimer(
    ~autoStart=true,
    ~endTime=0,
    ~initialTime=110,
    ~onTimeOver={onAbort},
    (),
  )

  <>
    <div className="flex flex-col gap-6 justify-center">
      <div id="outer-circle" className="rounded-full flex place-items-center place-content-center">
        <div id="inner-circle" className="rounded-full bg-white " />
      </div>
      <button
        title="Stop Exercise"
        onClick={_ => onAbort()}
        className="absolute left-2/4 top-2/4 -translate-x-2/4 -translate-y-2/4 rounded-full w-[50px] h-[50px]">
        <Icons.Stop className="inline-block text-pink-500" size="28" />
      </button>
    </div>
    <h1 className="absolute absolute-middle text-2xl top-[87vh]">
      {time->formatSeconds->string}
    </h1>
  </>
}
