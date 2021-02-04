module Views.Header exposing (view)

import EditableField exposing (editableField)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Model exposing (Message(..), Model)


view : Model -> Html Message
view model =
    let
        buttonAction =
            if model.editing == True then
                Save model.character

            else
                Edit

        buttonLabel =
            if model.editing == True then
                "Speichern"

            else
                "🖉"
    in
    div [ class "header" ]
        [ div [] [ editableField model (\s c -> { c | name = s }) model.character.name ]
        , button [ onClick buttonAction ] [ text buttonLabel ]
        ]
