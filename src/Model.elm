module Model exposing (..)

import SkillCheck exposing (SkillCheck, DiceRoll)

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
