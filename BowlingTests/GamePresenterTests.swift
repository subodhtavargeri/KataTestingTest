import XCTest
@testable import Bowling

class GamePresenterTests: XCTestCase {
    let game = GameSpy()
    let view = BowlingViewControllerSpy()
    var presenter: GamePresenter?
    
    override func setUp() {
        presenter = GamePresenter(game: game, view: view)
    }
    
    func test_PlayerRollScoreIsTwo_WhenPlayerKnocksTwoPin() {
        presenter?.playerRolls(totalNumberOfPinKnocked: 2)
        
        XCTAssertEqual(game.pins, Pin.two)
    }
    
    func test_PlayerRollScoreIsZero_WhenPlayerKnocksZeroPin() {
        presenter?.playerRolls(totalNumberOfPinKnocked: 0)
        
        XCTAssertEqual(game.pins, Pin.zero)
    }
    
    func test_GameFinalScoreIsTwenty_WhenFinalScoreIsDisplayed() {
        presenter?.playerRolls(totalNumberOfPinKnocked: 2)
        
        presenter?.getGameFinalScore()
        
        game.calculateTotalGameScore { score in
            XCTAssertEqual(score, 20)
        }
    }
    
    func test_PinScoreTwoIsDisplayed_WhenPlayerKnocksTwoPin() {
        presenter?.playerRolls(totalNumberOfPinKnocked: 2)
        
        game.rollBalls(pins: .two, checkForAnSpareFrameCompletion: { isSpare in
            XCTAssertEqual(view.title, Pin.two.pinSymbols())
        })
    }
    
    func test_PinScoreXIsDisplayed_WhenPlayerKnocksTenPins_Strike() {
        presenter?.playerRolls(totalNumberOfPinKnocked: 10)
        
        XCTAssertEqual(view.title, "X")
    }
    
    func test_PinScoreSlashIsDisplayed_WhenPlayerKnocksFivePins_Spare() {
        presenter?.playerRolls(totalNumberOfPinKnocked: 5)
        
        XCTAssertEqual(view.title, Pin.five.pinSymbols())
    }
    
    func test_GameFinalScoreTwentyIsDisplayed_WhenAllFramesAreFinished() {
        presenter?.playerRolls(totalNumberOfPinKnocked: 2)
        
        presenter?.getGameFinalScore()
        
        game.calculateTotalGameScore { score in
            XCTAssertEqual(view.score, "20")
        }
    }
    
    func test_DisplayViewTitle_WhenPresenterLoads() {
        presenter?.loadPresenter()
        
        XCTAssertEqual(view.title, Constant.Title.screenTitle)
    }
    
    func test_PinValueIsNil_WhenUserClicksResetButtonFromView() {
        presenter?.resetGame()
        
        XCTAssertNil(game.pins)
    }
    
    func test_ScoreZeroIsDisplayedOnView_WhenResetButtonIsClickedFromView() {
        presenter?.resetGame()
        
        XCTAssertEqual(view.score, "0")
    }
    
    func test_CounterValueIsOne_WhenUserKnocksOnePin() {
        presenter?.playerRolls(totalNumberOfPinKnocked: Pin.one.rawValue)
        
        XCTAssertEqual(view.counter, 1)
    }
    
    func test_CounterValueIsTwo_WhenUserKnocksTenPin_Stike() {
        presenter?.playerRolls(totalNumberOfPinKnocked: Pin.ten.rawValue)
        
        game.rollBalls(pins: .ten, checkForAnSpareFrameCompletion: { isSpare in
            XCTAssertEqual(view.title, Constant.SpecialPinSymbols.strike)
        })
    }
    
    func test_CounterValueIsIncrementByTwo_WhenUserKnocksTenPin_Stike() {
        presenter?.playerRolls(totalNumberOfPinKnocked: Pin.zero.rawValue)
        presenter?.playerRolls(totalNumberOfPinKnocked: Pin.zero.rawValue)
        presenter?.playerRolls(totalNumberOfPinKnocked: Pin.ten.rawValue)
        
        game.rollBalls(pins: .ten, checkForAnSpareFrameCompletion: { isSpare in
            XCTAssertEqual(view.counter, 2)
        })
    }
}
