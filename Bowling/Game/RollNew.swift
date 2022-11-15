struct RollNew {
    
    private var roll = [Pin]()
    
    func isValidIndex(rollIndex: CurrentRollIndex)-> Bool {
        return roll.indices.contains(rollIndex)
    }
    
    mutating func append(pin: Pin) {
        roll.append(pin)
    }
    
}
