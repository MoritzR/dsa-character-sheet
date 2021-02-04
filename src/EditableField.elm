module EditableField exposing (editableField)

import Html exposing (Html, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import Model exposing (Character, Message(..), Model)


editableField : Model -> (String -> Character -> Character) -> String -> Html Message
editableField model update =
    if model.editing == True then
        \s -> input [ value s, onInput (\v -> UpdateCharacter (update v)) ] []

    else
        text
