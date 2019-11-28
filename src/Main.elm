module Main exposing (main)

import Browser
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import SkillCheck exposing (SkillCheck, DiceRoll, SkillCheckResult)
import Random

type Message = Roll SkillCheck
              | Rolled SkillCheck DiceRoll

type alias Character = {
  baseStats: BaseStats,
  skills: Skills
  }

type alias BaseStats = {
  mu: Int,
  kl: Int,
  int: Int,
  ch: Int,
  ff: Int,
  ge: Int,
  ko: Int,
  kk: Int
  }

type alias Skills = {
  climb: Int,
  sing: Int
  }

type alias Model = {
  roll: Maybe {
    dice: DiceRoll,
    skillCheck: SkillCheck
    },
  character: Character
  }

main =
  Browser.element 
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view 
    }

init : () -> (Model, Cmd Message)
init _ = ( {
  roll = Nothing,
  character = {
    baseStats= {
      mu = 8,
      kl = 12,
      int = 14,
      ch = 13,
      ff = 16,
      ge = 15,
      ko = 9,
      kk = 11
      },
    skills= {
      climb = 8,
      sing = 5
      }
    }
  }, Cmd.none)

subscriptions : Model -> Sub Message
subscriptions model = Sub.none

update : Message -> Model -> (Model, Cmd Message)
update msg model = case msg of
  Roll skillCheck ->
    ( model
    , Random.generate (Rolled skillCheck) (Random.map3 DiceRoll randomDiceRoll randomDiceRoll randomDiceRoll)
    )
  Rolled skillCheck roll -> ({model | roll = Just {dice = roll, skillCheck = skillCheck} }, Cmd.none)

view : Model -> Html Message
view model = div []
  [ div [class "base-stats"] [
    text ("MU, GE, KK: " 
    ++ String.fromInt model.character.baseStats.mu
    ++ ", "
    ++ String.fromInt model.character.baseStats.ge
    ++ ", "
    ++ String.fromInt model.character.baseStats.kk
    )]
  , div [class "skills"]
    [ div [] [
      text ("Climb: " ++ String.fromInt model.character.skills.climb)
      , let base = model.character.baseStats
        in button [onClick (Roll { bonus = model.character.skills.climb, against = (DiceRoll base.mu base.ge base.kk)})] [text "Roll"]
      ]
    , div [] [
      text ("Sing: " ++ String.fromInt model.character.skills.sing)
      , let base = model.character.baseStats
        in button [onClick (Roll { bonus = model.character.skills.sing, against = (DiceRoll base.kl base.ch base.ko)})] [text "Roll"]
      ]
    ]
  , div [] [ 
    case model.roll of
      Just roll -> 
        text (showRiceRoll roll.dice
        ++ " against " ++ showRiceRoll roll.skillCheck.against
        ++ " with bonus " ++ String.fromInt roll.skillCheck.bonus
        ++ " => " ++ showSkillCheckResult (SkillCheck.getSkillCheckResult roll.skillCheck roll.dice)
        )
      Nothing -> text "Press the button to roll"
    ]
  ]

showRiceRoll : DiceRoll -> String
showRiceRoll roll = String.fromInt roll.first
  ++ ", " ++ String.fromInt roll.second
  ++ ", " ++ String.fromInt roll.third

randomDiceRoll = Random.int 1 20

showSkillCheckResult : SkillCheckResult -> String
showSkillCheckResult result =
  case result of
    SkillCheck.Success qualityLevel  -> "Success (Quality Level: " ++ String.fromInt qualityLevel ++ ")"
    SkillCheck.Failure diff          -> "Failure (" ++ String.fromInt diff ++ ")"
