module Main exposing (main)

import Browser
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import SkillCheck exposing (SkillCheck, DiceRoll, SkillCheckResult)
import Random

type Message = Roll SkillCheck
              | Rolled SkillCheck DiceRoll

type alias Model = {
  roll: Roll,
  character: Character
  }

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

type alias Roll = Maybe {
  dice: DiceRoll,
  skillCheck: SkillCheck
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
  [ baseStats model.character.baseStats
  , let base    = model.character.baseStats
        skills  = model.character.skills
    in 
      div [class "skills"] 
      [ skill "Climb" skills.climb (DiceRoll base.mu base.ge base.kk)
      , skill "Sing" skills.sing (DiceRoll base.kl base.ch base.ko)
      ]
  , displayRoll model.roll
  ]

baseStats : BaseStats -> Html Message
baseStats stats = div [class "base-stats"]
    [ baseStat ("MU", stats.mu)
    , baseStat ("KL", stats.kl)
    , baseStat ("IN", stats.int)
    , baseStat ("CH", stats.ch)
    , baseStat ("FF", stats.ff)
    , baseStat ("GE", stats.ge)
    , baseStat ("KO", stats.ko)
    , baseStat ("KK", stats.kk)
    ]

baseStat : (String, Int) -> Html Message
baseStat (name, value) = div []
  [ div [] [text name]
  , div [] [text (String.fromInt value)]
  ]
  
skill : String -> Int -> DiceRoll -> Html Message
skill name bonus against = div [] [
      text (name ++ ": " ++ String.fromInt bonus)
      , button [onClick (Roll { bonus = bonus, against = against})] [text "Roll"]
      ]

displayRoll : Roll -> Html Message
displayRoll r = div [] [ 
    case r of
      Just roll -> 
        text (showRiceRoll roll.dice
        ++ " against " ++ showRiceRoll roll.skillCheck.against
        ++ " with bonus " ++ String.fromInt roll.skillCheck.bonus
        ++ " => " ++ showSkillCheckResult (SkillCheck.getSkillCheckResult roll.skillCheck roll.dice)
        )
      Nothing -> text "Press the button to roll"
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
