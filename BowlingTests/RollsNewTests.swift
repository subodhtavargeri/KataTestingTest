@testable import Bowling
import XCTest

class RollsNewTests: XCTestCase {
    
    func test_RollArrayValueAtIndexIsFalse_WhenRollIndexIsZero() {
        let roll = RollNew()
        
        let rollIndex = 0
        XCTAssertFalse(roll.isValidIndex(rollIndex: rollIndex))
    }
    
    func test_RollArrayValueAtIndexZeroIsTrue_WhenNewPinValueIsAppendedInRollArray() {
        var roll = RollNew()
        
        roll.append(pin: .zero)
        
        let rollIndex = 0
        XCTAssertTrue(roll.isValidIndex(rollIndex: rollIndex))
    }
    
    func test_RollArrayValueAtIndexOneIsTrue_WhenTwoPinValuesAreAppendedInRollArray() {
        var roll = RollNew()
        
        roll.append(pin: .zero)
        roll.append(pin: .ten)
        
        let rollIndex = 1
        XCTAssertTrue(roll.isValidIndex(rollIndex: rollIndex))
    }
    
    func test_GetValueAsPinTenFromRollArray_WhenRollArrayHasValuePinTenAtIndexZero() {
        var roll = RollNew()
        
        roll.append(pin: .ten)
        
        let originalValue = roll.pinValeAtIndex(index:0)
        XCTAssertEqual(originalValue, Pin.ten)
    }
}
