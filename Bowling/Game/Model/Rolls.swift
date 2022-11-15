
protocol RollProtocol {
    func getRawValue(index: CurrentRollIndex)-> Score
    func pinValueAtIndex(index: CurrentRollIndex)-> Pin
    func isValidIndex(rollIndex: CurrentRollIndex)-> Bool
    mutating func append(pin: Pin)
    mutating func resetRoll()
    func isBonusForFrame()-> Bonus
}

struct Rolls : RollProtocol {
    
    private var roll = [Pin]()
    
    func getRawValue(index: CurrentRollIndex)-> Score {
        
        if isValidIndex(rollIndex: index) {
            return roll[index].rawValue
        }
        return .zero
    }
    
    func pinValueAtIndex(index: CurrentRollIndex)-> Pin {
        return roll[index]
    }
    
    func isValidIndex(rollIndex: CurrentRollIndex)-> Bool {
        return roll.indices.contains(rollIndex)
    }
    
    mutating func append(pin: Pin) {
        roll.append(pin)
    }
    
    mutating func resetRoll() {
        roll.removeAll()
    }
    
    func isBonusForFrame()-> Bonus {
        
        if isSpareForAnFrame() {
            return .spare
        }
        return .none
    }
    
    private func isSpareForAnFrame()-> Bool {
        
        if isRollCountMoreThanOne() {
            let currentRollValueForCurrentFrame = roll[roll.count-1].rawValue
            let previousRollValueForCurrentFrame = roll[roll.count-2].rawValue
            
            if currentRollValueForCurrentFrame + previousRollValueForCurrentFrame == Pin.ten.rawValue {
                return true
            }
        }
        return false
    }
    
    private func isRollCountMoreThanOne()-> Bool {
        return roll.count > 1
    }
}
