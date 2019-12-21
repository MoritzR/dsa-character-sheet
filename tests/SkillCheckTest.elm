module SkillCheckTest exposing (..)

import Expect
import Test exposing (..)
import SkillCheck exposing (..)


suite : Test
suite =
    describe "doing a skill check"
        [ describe "without a bonus"
            [ test "fails when all results are above the expectation" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 2 2 2) 0 
                        diceRoll    = DiceRoll 3 3 3
                    in  Expect.equal 
                            (getSkillCheckResult skillCheck diceRoll) 
                            (Failure (-3))
            , test "fails when one result is above the expectation" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 2 2 2) 0 
                        diceRoll    = DiceRoll 3 2 2
                    in  Expect.equal 
                            (getSkillCheckResult skillCheck diceRoll) 
                            (Failure (-1))
            , test "succeeds when all results are equal to the expectation" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 2 2 2) 0 
                        diceRoll    = DiceRoll 2 2 2
                    in  isSuccess (getSkillCheckResult skillCheck diceRoll)
                        |> Expect.true "Dice roll failed"
            , test "succeeds when all results are below to the expectation" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 2 2 2) 0 
                        diceRoll    = DiceRoll 1 1 1
                    in  isSuccess (getSkillCheckResult skillCheck diceRoll)
                        |> Expect.true "Dice roll failed"
            , test "a below result does not cancel out an above result" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 2 2 2) 0 
                        diceRoll    = DiceRoll 1 2 3
                    in  Expect.equal 
                            (getSkillCheckResult skillCheck diceRoll) 
                            (Failure (-1))
            ]
        , describe "with a bonus of 5"
            [ test "succeeds even when one result is above the expectation by 5" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 10 10 10) 5 
                        diceRoll    = DiceRoll 15 10 10
                    in  isSuccess (getSkillCheckResult skillCheck diceRoll)
                        |> Expect.true "Dice roll failed"
            , test "succeeds when all are above the expected with a summed difference of 5" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 10 10 10) 5 
                        diceRoll    = DiceRoll 12 12 11
                    in  isSuccess (getSkillCheckResult skillCheck diceRoll)
                        |> Expect.true "Dice roll failed"
            , test "fails when all are above the expected with a summed difference of 6" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 10 10 10) 5 
                        diceRoll    = DiceRoll 13 12 11
                    in  Expect.equal 
                            (getSkillCheckResult skillCheck diceRoll) 
                            (Failure (-1))
            , test "fails when one is above the expected with a difference of 6" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 10 10 10) 5 
                        diceRoll    = DiceRoll 16 10 10
                    in  Expect.equal 
                            (getSkillCheckResult skillCheck diceRoll) 
                            (Failure (-1))
            , test "fails when one is above the expected with a difference of 6, even when the other two are below the expectation" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 10 10 10) 5 
                        diceRoll    = DiceRoll 16 1 1
                    in  Expect.equal 
                            (getSkillCheckResult skillCheck diceRoll) 
                            (Failure (-1))
            , test "shows by how much the dice roll missed on a failure" <|
                \_ -> 
                    let skillCheck  = SkillCheck (DiceRoll 10 10 10) 5 
                        diceRoll    = DiceRoll 18 11 1
                    in  Expect.equal 
                            (getSkillCheckResult skillCheck diceRoll) 
                            (Failure (-4))
            ]
        , describe "succeding with a quality level"
            (let testQualityLevel (bonusRemaining, expectedQualityLevel)
                    = test ( "of " ++ String.fromInt expectedQualityLevel
                            ++ " when there is a bonus of " ++ String.fromInt bonusRemaining
                            ++ " remaining") <|
                        \_ ->
                            let skillCheck  = SkillCheck (DiceRoll 10 10 10) (5 + bonusRemaining) 
                                diceRoll    = DiceRoll 15 10 10
                            in  Expect.equal 
                                    (getSkillCheckResult skillCheck diceRoll) 
                                    (Success expectedQualityLevel)
             in List.map testQualityLevel
                    [ (0, 1)
                    , (3, 1)
                    , (4, 2)
                    , (6, 2)
                    , (7, 3)
                    , (9, 3)
                    , (10, 4)
                    , (12, 4)
                    , (13, 5)
                    , (15, 5)
                    , (16, 6)
                    , (17, 6)
                    , (20, 6)
                    , (50, 6) -- 6 is maximum quality level
                    ]
            )
        ]

isSuccess : SkillCheckResult -> Bool
isSuccess result =
    case result of
        Success _ -> True
        Failure _ -> False