module BehaviorSubject = {
  type t<'a>

  @send
  external next: (t<'a>, 'a) => unit = "next"

  @send
  external getValue: (t<'a>, unit) => 'a = "getValue"

  @send
  external subscribe: (t<'a>, 'a => unit) => unit = "subscribe"

  @module("rxjs") @new
  external make: 'a => t<'a> = "BehaviorSubject"
}
