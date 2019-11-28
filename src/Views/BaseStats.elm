module Views.BaseStats exposing (view)

import Model exposing (BaseStats, Message)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)

view : BaseStats -> Html Message
view stats = div [class "base-stats"]
    [ baseStat ("MU", stats.mu)
    , baseStat ("KL", stats.kl)
    , baseStat ("IN", stats.int)
    , baseStat ("CH", stats.ch)
    , baseStat ("FF", stats.ff)
    , baseStat ("GE", stats.ge)
    , baseStat ("KO", stats.ko)
    , baseStat ("KK", stats.kk)
    ]

baseStat : (String, Int) -> Html Message
baseStat (name, value) = div []
  [ div [] [text name]
  , div [] [text (String.fromInt value)]
  ]