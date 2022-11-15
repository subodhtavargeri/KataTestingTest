@testable import Bowling
import XCTest

class RollsNewTests: XCTestCase {
    
    func test_RollArrayValueAtIndexIsTrue_WhenRollIndexIsZero() {
        let roll = RollNew()
        
        let rollIndex = 0
        
        XCTAssertTrue(roll.isValidIndex(rollIndex: rollIndex))
    }
}
