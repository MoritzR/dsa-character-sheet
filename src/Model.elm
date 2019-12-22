module Model exposing (..)

import SkillCheck exposing (SkillCheck, DiceRoll)

initialModel : Model
initialModel = {
  editing = False,
  roll = Nothing,
  character = {
    name = "<Dein Charaktername>",
    baseStats= {
      mu = 12,
      kl = 10,
      int = 13,
      ch = 13,
      ff = 15,
      ge = 14,
      ko = 11,
      kk = 12
      },
    skills= {
      fly = 0,
      juggleries = 0,
      climb = 12,
      bodyControl = 12,
      showOfStrength = 0,
      ride = 0,
      swim = 0,
      composure = 2,
      sing = 0,
      acuity = 4,
      dance = 1,
      pickpocket = 4,
      hide = 8,
      quaff = 4,

      convert = 0,
      bewitch = 5,
      intimidate = 0,
      etiquette = 2,
      alleyLore = 9,
      insight = 7,
      persuade = 8,
      disguise = 2,
      willpower = 4,

      tracking = 0,
      shackle = 0,
      fishing = 0,
      navigation = 4,
      botany = 0,
      zoology = 0,
      survival = 0,

      gambling = 2,
      geography = 1,
      history = 1,
      godsAndCults = 2,
      warfare = 0,
      magic = 0,
      mechanics = 1,
      calculate = 6,
      legal = 5,
      sagasAndLegends = 3,
      spheres = 0,
      stars = 0,

      lockpicking = 9
      }
    }
  }

type Message = Roll SkillCheck
              | Rolled SkillCheck DiceRoll
              | Save Character
              | Edit
              | UpdateCharacter (Character -> Character)

type alias Model = {
  editing: Bool,
  roll: Roll,
  character: Character
  }

type alias Character = {
  name: String,
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
      fly: Int,
      juggleries: Int,
      climb: Int,
      bodyControl: Int,
      showOfStrength: Int,
      ride: Int,
      swim: Int,
      composure: Int,
      sing: Int,
      acuity: Int,
      dance: Int,
      pickpocket: Int,
      hide: Int,
      quaff: Int,

      convert: Int,
      bewitch: Int,
      intimidate: Int,
      etiquette: Int,
      alleyLore: Int,
      insight: Int,
      persuade: Int,
      disguise: Int,
      willpower: Int,

      tracking: Int,
      shackle: Int,
      fishing: Int,
      navigation: Int,
      botany: Int,
      zoology: Int,
      survival: Int,

      gambling: Int,
      geography: Int,
      history: Int,
      godsAndCults: Int,
      warfare: Int,
      magic: Int,
      mechanics: Int,
      calculate: Int,
      legal: Int,
      sagasAndLegends: Int,
      spheres: Int,
      stars: Int,

      lockpicking: Int
  }

type alias Roll = Maybe {
  dice: DiceRoll,
  skillCheck: SkillCheck
  }
