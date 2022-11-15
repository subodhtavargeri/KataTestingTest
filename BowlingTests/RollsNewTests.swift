@testable import Bowling
import XCTest

class RollsNewTests: XCTestCase {
    
    var roll: RollNew?
    
    override func setUp() {
        roll = RollNew()
    }
    
    func test_RollArrayValueAtIndexIsFalse_WhenRollIndexIsZero() {
        let rollIndex = 0
        if let originalValue = roll?.isValidIndex(rollIndex: rollIndex) {
            XCTAssertFalse(originalValue)
        }
    }
    
    func test_RollArrayValueAtIndexZeroIsTrue_WhenNewPinValueIsAppendedInRollArray() {
        roll?.append(pin: .zero)
        
        let rollIndex = 0
        if let originalValue = roll?.isValidIndex(rollIndex: rollIndex) {
            XCTAssertTrue(originalValue)
        }
    }
    
    func test_RollArrayValueAtIndexOneIsTrue_WhenTwoPinValuesAreAppendedInRollArray() {
        roll?.append(pin: .zero)
        
        roll?.append(pin: .ten)
        
        let rollIndex = 1
        if let originalValue = roll?.isValidIndex(rollIndex: rollIndex) {
            XCTAssertTrue(originalValue)
        }
    }
    
    func test_GetValueAsPinTenFromRollArray_WhenRollArrayHasValuePinTenAtIndexZero() {
        roll?.append(pin: .ten)
        
        let originalValue = roll?.pinValeAtIndex(index:0)
        XCTAssertEqual(originalValue, Pin.ten)
    }
    
    func test_ScoreReturnedIsThree_WhenRollArrayHasPinThree() {
        roll?.append(pin: .three)
        
        let originalValue = roll?.getScoreValueAtIndex(index:0)
        XCTAssertEqual(originalValue, Pin.three.rawValue)
    }
}
