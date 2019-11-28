module Model exposing (..)

import SkillCheck exposing (SkillCheck, DiceRoll)

initialModel = {
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
  }

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