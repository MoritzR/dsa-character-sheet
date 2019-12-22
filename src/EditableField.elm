module EditableField exposing (editableField)

import Html exposing (Html, text, input)
import Html.Events exposing (onInput)
import Html.Attributes exposing (value)
import Model exposing (Message(..), Model, Character)


editableField : Model -> (String -> Character -> Character) -> String -> Html Message
editableField model update
    = if model.editing == True
        then \s -> input [ value s, onInput (\v -> UpdateCharacter (update v))] []
        else text
