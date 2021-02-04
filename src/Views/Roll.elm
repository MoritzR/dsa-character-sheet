module Views.Roll exposing (view)

import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)
import Model exposing (Message, Roll)
import SkillCheck exposing (DiceRoll, SkillCheckResult)


view : Roll -> Html Message
view r =
    div [ id "roll" ]
        [ case r of
            Just roll ->
                div []
                    [ text
                        (showDiceRoll roll.dice
                            ++ " gegen "
                            ++ showDiceRoll roll.skillCheck.against
                            ++ " mit Bonus "
                            ++ String.fromInt roll.skillCheck.bonus
                            ++ " => "
                            ++ showSkillCheckResult (SkillCheck.getSkillCheckResult roll.easement roll.skillCheck roll.dice)
                        )
                    , div []
                        [ text "Erleichtert um:"
                        , div [ id "easement" ] [ text (String.fromInt roll.easement) ]
                        , button [ onClick Model.DecreaseEasement ] [ text "-" ]
                        , button [ onClick Model.IncreaseEasement ] [ text "+" ]
                        ]
                    ]

            Nothing ->
                text "Warte auf Wurf..."
        ]


showDiceRoll : DiceRoll -> String
showDiceRoll roll =
    String.fromInt roll.first
        ++ ", "
        ++ String.fromInt roll.second
        ++ ", "
        ++ String.fromInt roll.third


showSkillCheckResult : SkillCheckResult -> String
showSkillCheckResult result =
    case result of
        SkillCheck.Success qualityLevel ->
            "Erfolg (Qualitätsstufe: " ++ String.fromInt qualityLevel ++ ")"

        SkillCheck.Failure diff ->
            "Fehlschlag (" ++ String.fromInt diff ++ ")"
