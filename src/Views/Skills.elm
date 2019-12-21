module Views.Skills exposing (view)

import Model exposing (Character, Message)
import SkillCheck exposing (DiceRoll)
import Html exposing (Html, div, span, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)


view : Character -> Html Message
view character = 
    let base    = character.baseStats
        skills  = character.skills
    in 
        div [class "skills"] 
        [ skill "Klettern" skills.climb (DiceRoll base.mu base.ge base.kk)
        , skill "Körperbeherrschung" skills.bodyControl (DiceRoll base.ge base.ge base.ko)
        , skill "Selbstbeherrschung" skills.composure (DiceRoll base.mu base.mu base.ko)
        , skill "Sinnesschärfe" skills.acuity (DiceRoll base.kl base.int base.int)
        , skill "Taschendiebstahl" skills.pickpocket (DiceRoll base.mu base.ff base.ge)
        , skill "Verbergen" skills.hide (DiceRoll base.mu base.int base.ge)
        , skill "Gassenwissen" skills.alleyLore (DiceRoll base.kl base.int base.ch)
        , skill "Menschenkenntnis" skills.insight (DiceRoll base.kl base.int base.ch)
        , skill "Überreden" skills.persuade (DiceRoll base.mu base.int base.ch)
        , skill "Schlösserknacken" skills.lockpicking (DiceRoll base.int base.ff base.ff)
        ]
 
skill : String -> Int -> DiceRoll -> Html Message
skill name bonus against = div []
    [ span []
        [ text (name ++ ": " ++ String.fromInt bonus)
        ]
    , button [onClick (Model.Roll { bonus = bonus, against = against})] [text "Roll"]
    ]