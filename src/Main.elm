module Main exposing (main)

import Browser
import Random
import Html exposing (Html, div)
import SkillCheck exposing (DiceRoll)
import Model exposing (Model, Message, BaseStats, Roll)
import Views.BaseStats as BaseStats
import Views.Roll as Roll
import Views.Skills as Skills

main =
  Browser.element 
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view 
    }

init : () -> (Model, Cmd Message)
init _ = (Model.initialModel, Cmd.none)

subscriptions : Model -> Sub Message
subscriptions model = Sub.none

update : Message -> Model -> (Model, Cmd Message)
update msg model = case msg of
  Model.Roll skillCheck ->
    ( model
    , Random.generate (Model.Rolled skillCheck) (Random.map3 DiceRoll randomDiceRoll randomDiceRoll randomDiceRoll)
    )
  Model.Rolled skillCheck roll -> ({model | roll = Just {dice = roll, skillCheck = skillCheck} }, Cmd.none)

view : Model -> Html Message
view model = div []
  [ BaseStats.view model.character.baseStats
  , Skills.view model.character
  , Roll.view model.roll
  ]

randomDiceRoll = Random.int 1 20
