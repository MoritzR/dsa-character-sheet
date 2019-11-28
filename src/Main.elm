module Main exposing (main)

import Browser
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import SkillCheck exposing (SkillCheck, DiceRoll, SkillCheckResult)
import Random
import Model exposing (Model, Message, BaseStats, Roll)
import Views.BaseStats as BaseStats

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
  , let base    = model.character.baseStats
        skills  = model.character.skills
    in 
      div [class "skills"] 
      [ skill "Climb" skills.climb (DiceRoll base.mu base.ge base.kk)
      , skill "Sing" skills.sing (DiceRoll base.kl base.ch base.ko)
      ]
  , displayRoll model.roll
  ]
 
skill : String -> Int -> DiceRoll -> Html Message
skill name bonus against = div [] [
      text (name ++ ": " ++ String.fromInt bonus)
      , button [onClick (Model.Roll { bonus = bonus, against = against})] [text "Roll"]
      ]

displayRoll : Roll -> Html Message
displayRoll r = div [] [ 
    case r of
      Just roll -> 
        text (showRiceRoll roll.dice
        ++ " against " ++ showRiceRoll roll.skillCheck.against
        ++ " with bonus " ++ String.fromInt roll.skillCheck.bonus
        ++ " => " ++ showSkillCheckResult (SkillCheck.getSkillCheckResult roll.skillCheck roll.dice)
        )
      Nothing -> text "Press the button to roll"
    ]

showRiceRoll : DiceRoll -> String
showRiceRoll roll = String.fromInt roll.first
  ++ ", " ++ String.fromInt roll.second
  ++ ", " ++ String.fromInt roll.third

randomDiceRoll = Random.int 1 20

showSkillCheckResult : SkillCheckResult -> String
showSkillCheckResult result =
  case result of
    SkillCheck.Success qualityLevel  -> "Success (Quality Level: " ++ String.fromInt qualityLevel ++ ")"
    SkillCheck.Failure diff          -> "Failure (" ++ String.fromInt diff ++ ")"
