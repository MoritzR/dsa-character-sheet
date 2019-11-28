module Views.Skills exposing (view)

import Model exposing (Character, Message)
import SkillCheck exposing (DiceRoll, SkillCheckResult)
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)


view : Character -> Html Message
view character = 
    let base    = character.baseStats
        skills  = character.skills
    in 
        div [class "skills"] 
        [ skill "Climb" skills.climb (DiceRoll base.mu base.ge base.kk)
        , skill "Sing" skills.sing (DiceRoll base.kl base.ch base.ko)
        ]
 
skill : String -> Int -> DiceRoll -> Html Message
skill name bonus against = div [] [
      text (name ++ ": " ++ String.fromInt bonus)
      , button [onClick (Model.Roll { bonus = bonus, against = against})] [text "Roll"]
      ]