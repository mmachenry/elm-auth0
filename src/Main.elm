port module Main exposing (main)

import Browser
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)

main : Program () Model Msg
main = Browser.element {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
    }

port login : Bool -> Cmd msg
port logout : Bool -> Cmd msg
port updateUserAndToken : (String -> msg) -> Sub msg

type alias Model = {
    token : Maybe String
    }

init : () -> (Model, Cmd Msg)
init flags = ({ token = Nothing }, Cmd.none)

type Msg =
    UpdateUserAndToken String
  | Login
  | Logout

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of
    UpdateUserAndToken token -> ({model | token = Just token}, Cmd.none)
    Login -> (model, login True)
    Logout -> (model, logout True)


subscriptions : Model -> Sub Msg
subscriptions _ = updateUserAndToken UpdateUserAndToken

view : Model -> Html Msg
view model = Html.div [] [
  text ("Hello World" ++ Debug.toString model),
  button [onClick Login] [ text "Login" ],
  button [onClick Logout] [ text "Logout"]
  ]
