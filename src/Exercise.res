open Types
open Store

@send
external padStart: (string, int, string) => string = "padStart"

let formatSeconds = num => {
  let min = mod(num, 3600) / 60
  let secs = mod(num, 60)
  `${string_of_int(min)}:${secs->string_of_int->padStart(2, "0")}`
}

let make = (store, state) => {
  open Snabbdom
  fragment([
    h(
      "div.flex.flex-col.gap-6.justify-center",
      empty,
      [
        h(
          "div#outer-circle.rounded-full.flex.place-items-center.place-content-center",
          empty,
          [h("div#inner-circle.rounded-full.bg-white", empty, [])],
        ),
        h(
          "button.absolute.left-2/4.top-2/4.-translate-x-2/4.-translate-y-2/4.rounded-full.w-[50px].h-[50px]",
          {
            "style": {
              "width": "50px",
              "height": "50px",
            },
            "attrs": {
              "title": "Stop Exercise",
            },
            "on": {
              "click": () => {
                store.dispatch(Stop)
              },
            },
          },
          [Icons.Stop.make(~className="inline-block text-pink-500", ~size=28, ())],
        ),
      ],
    ),
    h(
      "h1.absolute.absolute-middle.text-2xl.top-[87vh]",
      {
        "style": {
          "top": "87vh",
        },
      },
      [formatSeconds(state.timer)->string],
    ),
  ])
}
