module Views.Roll exposing (view)

import Model exposing (Message, Roll)
import SkillCheck exposing ( DiceRoll, SkillCheckResult)
import Html exposing (Html, div, text)
import Html.Attributes exposing (id)

view : Roll -> Html Message
view r = div [ id "roll" ] [ 
    case r of
      Just roll -> 
        text (showDiceRoll roll.dice
        ++ " against " ++ showDiceRoll roll.skillCheck.against
        ++ " with bonus " ++ String.fromInt roll.skillCheck.bonus
        ++ " => " ++ showSkillCheckResult (SkillCheck.getSkillCheckResult roll.skillCheck roll.dice)
        )
      Nothing -> text "Press the button to roll"
    ]

showDiceRoll : DiceRoll -> String
showDiceRoll roll = String.fromInt roll.first
  ++ ", " ++ String.fromInt roll.second
  ++ ", " ++ String.fromInt roll.third

showSkillCheckResult : SkillCheckResult -> String
showSkillCheckResult result =
  case result of
    SkillCheck.Success qualityLevel  -> "Success (Quality Level: " ++ String.fromInt qualityLevel ++ ")"
    SkillCheck.Failure diff          -> "Failure (" ++ String.fromInt diff ++ ")"