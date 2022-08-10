open Types
open Store

let make = (store, state) => {
  open Snabbdom

  fragment([
    h(
      "div.absolute.absolute-middle.top-[70vh].flex-row.justify-center.text-center",
      empty,
      [
        h("h1.text-2xl", empty, ["Breathe!"->string]),
        h("h1.text-white/50.mb-4", empty, ["by Tamim Arafat"->string]),
        h(
          "a.self-center",
          {
            "props": {
              "href": "https://github.com/arafatamim/breathe",
              "title": "Git Repository",
              "target": "_blank",
            },
          },
          [Icons.Git.make(~className="m-auto", ~size=30, ())],
        ),
      ],
    ),
    h(
      "div.flex.flex-col.gap-6.justify-center",
      empty,
      [
        h(
          "button.rounded-full.w-[50px].h-[50px]",
          {
            "on": {
              "click": () => {
                store.dispatch(Start)
              },
            },
          },
          [Icons.Play.make(~className="inline-block text-pink-500 ml-2px", ~size=38, ())],
        ),
      ],
    ),
  ])
}
