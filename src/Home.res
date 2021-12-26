@react.component
let make = (~onStart) => {
  <>
    <div className="absolute absolute-middle top-[70vh] flex-row justify-center text-center">
      <h1 className="text-2xl"> {"Breathe!"->React.string} </h1>
      <h1 className="text-white/50 mb-4"> {"by Tamim Arafat"->React.string} </h1>
      <a
        className="self-center"
        href="https://github.com/arafatamim/breathe"
        title="Git Repository"
        target="_blank">
        <Icons.Git className="m-auto" size="30" />
      </a>
    </div>
    <div className="flex flex-col gap-6 justify-center">
      <button title="Start Exercise" className="rounded-full w-[50px] h-[50px]" onClick={_ => onStart()}>
        <Icons.Play className="inline-block text-pink-500 ml-[2px]" size="38" />
      </button>
    </div>
  </>
}
