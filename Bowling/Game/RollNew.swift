struct RollNew {
    
    private var roll = [Pin]()
    
    func isValidIndex(rollIndex: CurrentRollIndex)-> Bool {
        return roll.indices.contains(rollIndex)
    }
    
    mutating func append(pin: Pin) {
        roll.append(pin)
    }
    
    func pinValeAtIndex(index: CurrentRollIndex) -> Pin {
        return roll[index]
    }
    
    func getScoreValueAtIndex(index: CurrentRollIndex)-> Score {
        if isValidIndex(rollIndex: index) {
            return roll[index].rawValue
        }
        return .zero
    }
}
