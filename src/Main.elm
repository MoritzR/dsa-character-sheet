module Main exposing (main)

import Browser
import Random
import Html exposing (Html, div)
import SkillCheck exposing (DiceRoll)
import Model exposing (Model, Character, Message)
import Views.BaseStats as BaseStats
import Views.Roll as Roll
import Views.Skills as Skills
import Views.Header as Header
import LocalStorage

main : Program (Maybe Character) Model Message
main =
  Browser.element 
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view 
    }

view : Model -> Html Message
view model = div []
  [ Header.view model
  , BaseStats.view model
  , Skills.view model
  , Roll.view model.roll
  ]

init : Maybe Character -> (Model, Cmd Message)
init maybeCharacter = 
  let initialModel = Model.initialModel in
  case maybeCharacter of
    Just character  -> ({initialModel | character = character}, Cmd.none)
    Nothing         -> (initialModel, Cmd.none)

update : Message -> Model -> (Model, Cmd Message)
update msg model = case msg of
  Model.Roll skillCheck ->
    ( model
    , Random.generate (Model.Rolled skillCheck) (Random.map3 DiceRoll randomDiceRoll randomDiceRoll randomDiceRoll)
    )
  Model.Rolled skillCheck roll -> ({model | roll = Just {dice = roll, skillCheck = skillCheck} }, Cmd.none)
  Model.Save character -> ({ model | editing = False }, LocalStorage.setStorage character)
  Model.Edit -> ({ model | editing = True }, Cmd.none)
  Model.UpdateCharacter updater -> ({model | character = updater model.character}, Cmd.none)

randomDiceRoll : Random.Generator Int
randomDiceRoll = Random.int 1 20
