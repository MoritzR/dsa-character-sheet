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
        ++ " gegen " ++ showDiceRoll roll.skillCheck.against
        ++ " mit Bonus " ++ String.fromInt roll.skillCheck.bonus
        ++ " => " ++ showSkillCheckResult (SkillCheck.getSkillCheckResult roll.skillCheck roll.dice)
        )
      Nothing -> text "Warte auf Wurf..."
    ]

showDiceRoll : DiceRoll -> String
showDiceRoll roll = String.fromInt roll.first
  ++ ", " ++ String.fromInt roll.second
  ++ ", " ++ String.fromInt roll.third

showSkillCheckResult : SkillCheckResult -> String
showSkillCheckResult result =
  case result of
    SkillCheck.Success qualityLevel  -> "Erfolg (Qualitätsstufe: " ++ String.fromInt qualityLevel ++ ")"
    SkillCheck.Failure diff          -> "Fehlschlag (" ++ String.fromInt diff ++ ")"