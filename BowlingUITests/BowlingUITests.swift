import XCTest

class BowlingUITests: XCTestCase {
    
    var app = XCUIApplication()
    
    override func setUp() {
        XCUIApplication().activate()
        app.buttons["button_Reset"].tap()
    }
    
    func test_GameScoreIsTwelve_WhenPlayerPinsZeroFourOneFiveTwo_AndFinalScoreIsCalculated() {
        for _ in 1...16 {
            app.buttons["button_ZeroPin"].tap()
        }
        app.buttons["button_FourPin"].tap()
        app.buttons["button_OnePin"].tap()
        app.buttons["button_FivePin"].tap()
        app.buttons["button_TwoPin"].tap()
        app.buttons["button_FinalScore"].tap()
        let labelFrameOneRollOne = app.staticTexts["label_FrameOneRollOne"]
        XCTAssertTrue(labelFrameOneRollOne.exists)
        XCTAssertEqual(labelFrameOneRollOne.label, "-")
        
        let labelFinalscoreStaticText = app.staticTexts["label_FinalScore"]
        XCTAssertTrue(labelFinalscoreStaticText.exists)
        XCTAssertEqual(labelFinalscoreStaticText.label, "Final Game Score: 12")
    }
    
    func test_GameScoreIsThreeHundred_WithPerfectScore_StrikeThroughOut() {
        for _ in 1...12 {
            app.buttons["button_TenPin"].tap()
        }
        let labelFrameOneRollOne = app.staticTexts["label_FrameOneRollOne"]
        XCTAssertTrue(labelFrameOneRollOne.exists)
        XCTAssertEqual(labelFrameOneRollOne.label, "X")
        
        app.buttons["button_FinalScore"].tap()
        let labelFinalscoreStaticText = app.staticTexts["label_FinalScore"]
        XCTAssertEqual(labelFinalscoreStaticText.label, "Final Game Score: 300")
    }
    
    func test_ScoreIsResetToZero_WhenResetButtonIsPlayed() {
        for _ in 1...16 {
            app.buttons["button_OnePin"].tap()
        }
        app.buttons["button_Reset"].tap()
        let labelFinalscoreStaticText = app.staticTexts["label_FinalScore"]
        XCTAssertTrue(labelFinalscoreStaticText.exists)
        XCTAssertEqual(labelFinalscoreStaticText.label, "Final Game Score: 0")
    }
    
    func test_GameScoreIsEleven_WhenPlayerPinsSpareThrought_GetsOneAdditionalFrame() {
        for _ in 1...18 {
            app.buttons["button_ZeroPin"].tap()
        }
        app.buttons["button_FourPin"].tap()
        app.buttons["button_SixPin"].tap()
        app.buttons["button_OnePin"].tap()
        
        app.buttons["button_FinalScore"].tap()
        let labelFinalscoreStaticText = app.staticTexts["label_FinalScore"]
        XCTAssertEqual(labelFinalscoreStaticText.label, "Final Game Score: 11")
    }
}
