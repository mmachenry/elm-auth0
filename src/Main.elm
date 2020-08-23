port module Main exposing (main)

import Browser
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Json.Decode as Decode

main : Program () Model Msg
main = Browser.element {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
    }

port login : Bool -> Cmd msg
port logout : Bool -> Cmd msg
port updateLoginData : (Decode.Value -> msg) -> Sub msg

type alias Model = {
    error : String,
    loginData : Maybe (LoginData)
    }

type alias LoginData = {
    user : User,
    token : String
    }

type alias User = Bool

init : () -> (Model, Cmd Msg)
init flags = ({ error = "", loginData = Nothing }, Cmd.none)

type Msg =
    UpdateLoginData Decode.Value
  | Login
  | Logout

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of
    UpdateLoginData value ->
        case Decode.decodeValue loginData value of
          Err e -> ({model | error = Debug.toString e}, Cmd.none)
          Ok ld -> ({model | loginData = Just ld}, Cmd.none)
    Login -> (model, login True)
    Logout -> (model, logout True)


subscriptions : Model -> Sub Msg
subscriptions _ = updateLoginData UpdateLoginData

view : Model -> Html Msg
view model = Html.div [] [
  text ("Hello World" ++ Debug.toString model),
  case model.loginData of
    Nothing -> button [onClick Login] [ text "Login" ]
    Just _ -> button [onClick Logout] [ text "Logout"]
  ]

loginData : Decode.Decoder LoginData
loginData =
    Decode.map2 LoginData
      (Decode.field "user" user)
      (Decode.field "token" Decode.string)

user : Decode.Decoder User
user = Decode.succeed True
