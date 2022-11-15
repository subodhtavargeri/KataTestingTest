import XCTest
@testable import Bowling

class GameTests: XCTestCase {
    
    var game: Game?
    let rolls = RollsSpy()
    
    override func setUp() {
        game = Game(roll: rolls)
    }
    
    func test_GameScoreIsZero_WhenGameBegins() {
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 0)
        })
    }
    
    private func rollBalls(knockedPins: Pin, roll: Int) {
        for _ in 1...roll {
            game?.rollBalls(pins: knockedPins, checkForAnSpareFrameCompletion: { isSpare in
                
            })
        }
    }
    
    private func loopThroughGameRollBalls(Pins: [Pin]) {
        for pin in Pins {
            game?.rollBalls(pins: pin, checkForAnSpareFrameCompletion: { isSpare in
                
            })
        }
    }
    
    func test_GameScoreIsZero_WhenPlayerScoresZero_InAllTwentyRolls() {
        rollBalls(knockedPins: .zero, roll: 20)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 0)
        })
    }
    
    func test_GameScoreIsTwenty_WhenPlayerScoresOnePin_InAllTwentyRolls() {
        rollBalls(knockedPins: .one, roll: 20)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 20)
        })
    }
    
    func test_GameScoreIsTwelve_WhenPlayerScoresZeroInSixteenRolls_ThenFourPinsThenOnePinThenFivePinsThenTwoPins_InLastFourRolls() {
        rollBalls(knockedPins: .zero, roll: 16)
        
        let pinArray = [Pin.four,Pin.one,Pin.five,Pin.two]
        loopThroughGameRollBalls(Pins: pinArray)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 12)
        })
    }
    
    func test_GameScoreIsSixteen_WhenPlayerScoresFivePinsThenFivePinsThenThreePins_ZeroInNextSeventeenRolls_SpareConditionInBeginning() {
        let pinArray = [Pin.five,Pin.five,Pin.three]
        loopThroughGameRollBalls(Pins: pinArray)
        
        rollBalls(knockedPins: .zero, roll: 17)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 16)
        })
    }
    
    func test_GameScoreIsOneHundredAndFifty_WhenPlayerScoresFivePinsInAllTwentyOneRolls_SpareConditionThroughtOutRolls() {
        rollBalls(knockedPins: .five, roll: 21)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 150)
        })
    }
    
    func test_GameScoreIsThirtyThree_WhenPlayerScoresOnePinInFirstEighteenRolls_FiveInNextThreeRolls_GetsOneAdditionRoll_SpareConditionAtEnd() {
        rollBalls(knockedPins: .one, roll: 18)
        
        let pinArray = [Pin.five,Pin.five,Pin.five]
        loopThroughGameRollBalls(Pins: pinArray)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 33)
        })
    }
    
    func test_GameScoreIsTwentyNine_WhenPlayerScoresFivePinsThenFivePins_OneInLastEighteenRolls_SpareConditionInBeginning() {
        let pinArray = [Pin.five,Pin.five]
        loopThroughGameRollBalls(Pins: pinArray)
        
        rollBalls(knockedPins: .one, roll: 18)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 29)
        })
    }
    
    func test_GameScoreIsFourtyEight_WhenPlayerScoresThreePinsInFirstFourRolls_ThenOnePinInNextFourRolls_ThenFivePinsInNextTwoRolls_TwoPinsInLastTenRolls_SpareConditionInMiddle() {
        rollBalls(knockedPins: .three, roll: 4)
        rollBalls(knockedPins: .one, roll: 4)
        let pinArray = [Pin.five,Pin.five]
        loopThroughGameRollBalls(Pins: pinArray)
        
        rollBalls(knockedPins: .two, roll: 10)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 48)
        })
    }
    
    func test_GameScoreIsTwentySeven_WhenPlayerScoresFivePinsThenFivePinsThenFivePinsThenFivePinsThenOnePins_ZeroInLastFifteenRolls_TwoSpareCondition() {
        let pinArray = [Pin.five,Pin.five,Pin.five,Pin.five,Pin.one]
        loopThroughGameRollBalls(Pins: pinArray)
        
        rollBalls(knockedPins: .zero, roll: 15)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 27)
        })
    }
    
    func test_GameScoreIsThreeHundred_WhenPlayerScoresTenPinsInAllTwelveRolls_GetsTwoAdditionalRolls_StrikeThroughtOut() {
        rollBalls(knockedPins: .ten, roll: 12)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore,300)
        })
    }
    
    func test_GameScoreIsThirty_WhenPlayerScoresTenPinsInFirstRoll_ThenAllOnesInNextRoll_StrikeInBeginning() {
        rollBalls(knockedPins: .ten, roll: 1)
        
        rollBalls(knockedPins: .one, roll: 18)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 30)
        })
    }
    
    func test_GameScoreIsTwentySix_WhenPlayerScoresTenPinsInFirstRoll_ThenSevenAndOneInNextTwoRolls_ZeroInNextSixteenRolls_StrikeInBeginning() {
        rollBalls(knockedPins: .ten, roll: 1)
        rollBalls(knockedPins: .seven, roll: 1)
        rollBalls(knockedPins: .one, roll: 1)
        
        rollBalls(knockedPins: .zero, roll: 16)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 26)
        })
    }
    
    func test_GameScoreIsSixteen_WhenPlayerScoresZeroInFirstTenRoll_ThenTenPinsInNextRoll_ThenOnePinInNextRoll_ThenTwoPinInNextRoll_ZeroInNextSixRoll_StrikeInMiddle() {
        rollBalls(knockedPins: .zero, roll: 10)
        rollBalls(knockedPins: .ten, roll: 1)
        rollBalls(knockedPins: .one, roll: 1)
        rollBalls(knockedPins: .two, roll: 1)
        
        rollBalls(knockedPins: .zero, roll: 6)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 16)
        })
    }
    
    func test_GameScoreIsFourteen_WhenPlayerScoresZeroPinsInFirstEighteenRoll_ThenScoresTenPinsInNextRoll_TwoPinsInAdditionalPins_StrikeAtEnd() {
        rollBalls(knockedPins: .zero, roll: 18)
        
        let pinArray = [Pin.ten,Pin.two,Pin.two]
        loopThroughGameRollBalls(Pins: pinArray)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 14)
        })
    }
    
    func test_GameScoreIsNinety_WhenPlayerScoresNinePinsAndZeroPins_InSamePatternInAllTenFrames() {
        let pinArray = [Pin.nine,Pin.zero,Pin.nine,Pin.zero,Pin.nine,Pin.zero,Pin.nine,Pin.zero
                        ,Pin.nine,Pin.zero,Pin.nine,Pin.zero,Pin.nine,Pin.zero,Pin.nine,Pin.zero
                        ,Pin.nine,Pin.zero,Pin.nine,Pin.zero]
        loopThroughGameRollBalls(Pins: pinArray)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 90)
        })
    }
    
    func test_GameScoreIsZero_WhenGameIsReset() {
        game?.resetGame()
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 0)
        })
    }
    
    func test_GameScoreIsZero_WhenPlayerScoresTenPinsInFirstRoll_ThenSevenPinsAndOnePinInNextTwoRolls_ZeroInNextSixteenRolls_GameIsReset() {
        rollBalls(knockedPins: .ten, roll: 1)
        rollBalls(knockedPins: .seven, roll: 1)
        rollBalls(knockedPins: .one, roll: 1)
        rollBalls(knockedPins: .zero, roll: 16)
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 26)
        })
        game?.resetGame()
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 0)
        })
    }
    
    func test_GameScoreIsTen_WhenPlayerStrikesInFirstRole_ThenPlayerHasNotFinishedPlayingAllFrames_IncompleteGame() {
        rollBalls(knockedPins: .ten, roll: 1)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 10)
        })
    }
    
    func test_GameScoreIsThree_WhenPlayerScoresOnePinInFirstRoll_TwoPinsInSecondRoll_ThenPlayerHasNotFinishedPlayingAllFrames_IncompleteGame() {
        rollBalls(knockedPins: .one, roll: 1)
        rollBalls(knockedPins: .two, roll: 1)
        
        game?.calculateTotalGameScore(scoreCalculationCompletion: { originalScore in
            XCTAssertEqual(originalScore, 3)
        })
    }
    
}
