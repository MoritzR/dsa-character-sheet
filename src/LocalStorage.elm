port module LocalStorage exposing (setStorage)

import Model exposing (Character)


port setStorage : Character -> Cmd msg
