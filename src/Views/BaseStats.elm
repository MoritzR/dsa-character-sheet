module Views.BaseStats exposing (view)

import Model exposing (Model, BaseStats, Character, Message)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import EditableField exposing (editableField)

view : Model -> Html Message
view model = 
  let stats = model.character.baseStats
      baseStat updater name value = div []
        [ div [] [text name]
        , div [] [editableField model updater (String.fromInt value)]
        ]
  in
    div [class "base-stats"]
      [ baseStat updateMu "MU" stats.mu
      , baseStat updateKl "KL" stats.kl
      , baseStat updateIn "IN" stats.int
      , baseStat updateCh "CH" stats.ch
      , baseStat updateFf "FF" stats.ff
      , baseStat updateGe "GE" stats.ge
      , baseStat updateKo "KO" stats.ko
      , baseStat updateKk "KK" stats.kk
      ]


updateMu : String -> Character -> Character
updateMu = update .mu (\b v -> {b | mu = v})

updateKl : String -> Character -> Character
updateKl = update .kl (\b v -> {b | kl = v})

updateIn : String -> Character -> Character
updateIn = update .int (\b v -> {b | int = v})

updateCh : String -> Character -> Character
updateCh = update .ch (\b v -> {b | ch = v})

updateFf : String -> Character -> Character
updateFf = update .ff (\b v -> {b | ff = v})

updateGe : String -> Character -> Character
updateGe = update .ge (\b v -> {b | ge = v})

updateKo : String -> Character -> Character
updateKo = update .ko (\b v -> {b | ko = v})

updateKk : String -> Character -> Character
updateKk = update .kk (\b v -> {b | kk = v})
 

update : (BaseStats -> Int) -> (BaseStats -> Int -> BaseStats) -> String -> Character -> Character
update defaultGetter setter value character = 
  let baseStats = character.baseStats
  in  {character | baseStats = setter baseStats (Maybe.withDefault (defaultGetter baseStats) (String.toInt value))}