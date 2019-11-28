module SkillCheck exposing (..)

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

getSkillCheckResult : SkillCheck -> DiceRoll -> SkillCheckResult
getSkillCheckResult skillCheck actual =
  let expected  = skillCheck.against
      max0      = max 0
      diff      = max0 (expected.first - actual.first)
                + max0 (expected.second - actual.second)
                + max0 (expected.third - actual.third)
                - skillCheck.bonus
  in  if diff <= 0
        then Success (min 6 (abs (diff + 1) // 3 + 1))
        else Failure (diff *(-1))

sumOfDice : DiceRoll -> Int
sumOfDice roll = roll.first + roll.second + roll.third