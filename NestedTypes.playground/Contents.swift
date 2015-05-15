/*

중첩 타입 (Nested Types )

열거형(Enumerations)은 종종 특정 클래스 또는 구조체(structure)의 기능을 지원하기 위해 만들어집니다. 마찬가지로, 복잡한 형태의 맥락에서 사용하기위한 유틸리티 클래스 또는 구조체를 정의하는데 유용합니다. 이를 위해 Swift는 중첩을 지원하는타입의 정의 안에 열거형, 클래스, 구조체를 내장타입으로 사용할 수 있게 함으로써 중첩타입(Nested Types)을 정의 할 수있습니다.

역자 주: 예를 들면, 구조체 안에 클래스를 정의하고 그 클래스 안에 다시 열거형 또는 사용자가 정의한 구조체를 넣을 수있다는 얘기.
기존 타입안에 새로운 타입을 중첩하기 위해서는, 기존 타입이 둘러싸고 있는 중괄호({,}) 안에서 정의를 작성합니다. 이러한 유형은 필요로 하는 만큼 여러 수준으로 중첩 될 수 있습니다.

*/

struct BlackjackCard {
    
    // nested Suit enumeration
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}


let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
println("theAceOfSpades: \(theAceOfSpades.description)")
// prints "theAceOfSpades: suit is ♠, value is 1 or 11"


/*
중첩 타입 참조하기 (Referring to Nested Types)

자신이 정의된 문맥 외부에서 중첩타입을 사용하려면, 자기를 포함하고 있는(중첩하고 있는)타입의 이름을 그 이름앞에 붙입니다.
*/

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
// heartsSymbol is "♡"

