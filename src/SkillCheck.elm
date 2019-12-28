module SkillCheck exposing (SkillCheck, DiceRoll, SkillCheckResult(..), QualityLevel, getSkillCheckResult)

type alias SkillCheck = {
  against: DiceRoll,
  bonus: Int
  }

type alias DiceRoll = {
  first: Int,
  second: Int,
  third: Int
  }

type SkillCheckResult
  = Success QualityLevel
  | Failure Int
type alias QualityLevel = Int
type alias Easement = Int

getSkillCheckResult : Easement -> SkillCheck -> DiceRoll -> SkillCheckResult
getSkillCheckResult easement skillCheck actual =
  let expected  = skillCheck.against
      max0      = max 0
      diff      = max0 (actual.first - (expected.first + easement))
                + max0 (actual.second - (expected.second + easement))
                + max0 (actual.third - (expected.third + easement))
                - skillCheck.bonus
  in  if diff <= 0
        then Success (min 6 (abs (diff + 1) // 3 + 1))
        else Failure (diff * -1)
