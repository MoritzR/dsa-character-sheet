module Main exposing (main)

import Browser
import Random
import Html exposing (Html, div)
import SkillCheck exposing (DiceRoll)
import Model exposing (Model, Message, BaseStats, Roll)
import Views.BaseStats as BaseStats
import Views.Roll as Roll
import Views.Skills as Skills

main : Program () Model Message
main =
  Browser.element 
    { init = \_ -> (Model.initialModel, Cmd.none)
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view 
    }

view : Model -> Html Message
view model = div []
  [ BaseStats.view model.character.baseStats
  , Skills.view model.character
  , Roll.view model.roll
  ]


update : Message -> Model -> (Model, Cmd Message)
update msg model = case msg of
  Model.Roll skillCheck ->
    ( model
    , Random.generate (Model.Rolled skillCheck) (Random.map3 DiceRoll randomDiceRoll randomDiceRoll randomDiceRoll)
    )
  Model.Rolled skillCheck roll -> ({model | roll = Just {dice = roll, skillCheck = skillCheck} }, Cmd.none)

randomDiceRoll = Random.int 1 20
