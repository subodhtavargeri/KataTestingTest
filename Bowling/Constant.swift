enum Pin: Int {
    case zero = 0, one, two, three, four, five, six, seven, eight, nine, ten
    
    func pinSymbols()-> String {
        if self == .ten {
            return Constant.SpecialPinSymbols.strike
        }
        if self == .zero {
            return Constant.SpecialPinSymbols.miss
        }
        
        return String(rawValue)
    }
}

struct Constant {
    
    struct Title {
        static let screenTitle = "Bowling"
    }
    struct Message {
        static let gameScore = "Final Game Score: %@"
    }
    
    struct SpecialPinSymbols {
        static let strike = "X"
        static let spare = "/"
        static let miss = "-"
    }
    
}

enum Bonus {
    case strike, spare, none
}

typealias Score = Int
typealias FinishedCalculatingGameScore = (Score) -> Void
typealias CurrentRollIndex = Int
typealias Title = String
typealias FinalGameScore = String
typealias NextRoll = Int
