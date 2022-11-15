@testable import Bowling
import XCTest

class RollsNewTests: XCTestCase {
        
    func test_RollArrayValueAtIndexIsFalse_WhenRollIndexIsZero() {
        let roll = RollNew()
        
        let rollIndex = 0
        XCTAssertFalse(roll.isValidIndex(rollIndex: rollIndex))
    }
    
    func test_RollArrayValueAtIndexZeroIsTrue_WhenNewPinValueIsAppended() {
        var roll = RollNew()
        
        roll.append(pin: .zero)
        
        let rollIndex = 0
        XCTAssertTrue(roll.isValidIndex(rollIndex: rollIndex))
    }
}
