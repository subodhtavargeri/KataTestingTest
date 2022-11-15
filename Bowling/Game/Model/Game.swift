protocol GameProtocol {
    func rollBalls(pins: Pin, checkForAnSpareFrameCompletion: (Bonus) -> Void)
    func calculateTotalGameScore(scoreCalculationCompletion: FinishedCalculatingGameScore)
    func resetGame()
}

class Game: GameProtocol {
    
    private var roll: RollProtocol
    private var secondRollForSameFrame = 1
    private var firstRollForNextFrameWhenItsAnStrike = 1
    private var secondRollForNextFrame = 2
    private var firstRollForNextFrameWhenItsAnSpare = 2
    
    private struct GameRules {
        static let maximumFrames = 10
        static let incrementCounterToGetNextRollWhenItsAnSpare = 2
        static let incrementCounterToGetNextRollWhenItsAnStrike = 1
        static let incrementCounterToGetNextRollWhenItsAnNormalRoll = 2
    }
    
    init(roll: RollProtocol) {
        self.roll = roll
    }
    
    func rollBalls(pins: Pin, checkForAnSpareFrameCompletion: (Bonus) -> Void) {
        roll.append(pin: pins)
        checkForAnSpareFrameCompletion(roll.isBonusForFrame())
    }
    
    func calculateTotalGameScore(scoreCalculationCompletion: FinishedCalculatingGameScore) {
        var rollIndex = 0
        var score = 0
        
        for _ in 1...GameRules.maximumFrames {
            
            if !isValidIndex(rollIndex: rollIndex) {
                scoreCalculationCompletion(score)
                return
            }
            
            let rollScore = roll.pinValueAtIndex(index: rollIndex)
            
            if isStrike(score: rollScore) {
                score += strikeBonusScore(rollIndex: rollIndex)
                rollIndex += GameRules.incrementCounterToGetNextRollWhenItsAnStrike
                continue
            }
            
            if isSpare(rollIndex: rollIndex) {
                score += spareBonusScore(rollIndex: rollIndex)
                rollIndex += GameRules.incrementCounterToGetNextRollWhenItsAnSpare
                continue
            }
            
            score += normalScore(rollIndex: rollIndex)
            rollIndex += GameRules.incrementCounterToGetNextRollWhenItsAnNormalRoll
        }
        
        scoreCalculationCompletion(score)
    }
    
    func resetGame() {
        roll.resetRoll()
    }
        
    private func isValidIndex(rollIndex: CurrentRollIndex)-> Bool {
        return roll.isValidIndex(rollIndex: rollIndex)
    }
    
    private func normalScore(rollIndex: CurrentRollIndex)-> Score {
        return roll.getRawValue(index: rollIndex) + roll.getRawValue(index: rollIndex + secondRollForSameFrame)
    }
    
    private func isSpare(rollIndex: CurrentRollIndex)-> Bool {
        return roll.getRawValue(index: rollIndex) +
        roll.getRawValue(index: rollIndex + secondRollForSameFrame) == Pin.ten.rawValue
    }
    
    private func spareBonusScore(rollIndex: CurrentRollIndex)-> Score {
        return roll.getRawValue(index: rollIndex)
        + roll.getRawValue(index: rollIndex + secondRollForSameFrame)
        + roll.getRawValue(index: rollIndex + firstRollForNextFrameWhenItsAnSpare)
    }
    
    private func isStrike(score: Pin)-> Bool {
        return score == Pin.ten
    }
    
    private func strikeBonusScore(rollIndex: CurrentRollIndex)-> Score {
        return roll.getRawValue(index: rollIndex) +
        roll.getRawValue(index: rollIndex + firstRollForNextFrameWhenItsAnStrike) +
        roll.getRawValue(index: rollIndex + secondRollForNextFrame)
    }
    
}
