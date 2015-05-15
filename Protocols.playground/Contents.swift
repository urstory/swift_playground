import Foundation
// @objc 를 사용하기 위하여 필요함

/*

프로토콜
프로토콜은 특정한 일이나 기능의 일부에 대한 메소드나 속성이나 다른 요구사항들의 전체적인 모습을 정의한다. 실제로 이런 요구사항들의 구현을 제공하지는 않고, 그 구현이 어떻게 보일지에 대해 명시한다. 이 요구사항들을 실제로 구현된 클래스, 구조체, 열거형 등에 그 프로토콜이 적용될 수 있다. 프로토콜의 요구사항을 만족하면 어떤 타입이라도 그 프로토콜에 일치한다(conform)라고 말한다.

프로토콜은 특정한 인스턴스 속성들, 인스턴스 메소드들, 타입 메소드들, 연산자들, 인덱스참조(subscript) 등을 갖는 타입을 가져야한다.

*/



/*

프로토콜 문법

프로토콜을 클래스, 구조체, 열거체와 매우 비슷한 방법으로 정의한다.

protocol SomeProtocol {
// 프로토콜 정의가 여기 온다
}
타입을 정의하는 곳에서 타입의 이름 뒤에 콜론(:)으로 구분해서 프로토콜의 이름을 써서 프로토콜을 커스텀 타입에 적용시킨다. 여러 프로토콜을 쉼표(,)로 구분해서 사용할 수 있다.

struct SomeStructure: FirstProtocol, AnotherProtocol {
// 구조체 정의가 여기 온다
}
클래스가 부모를 가질 때는 프로토콜들 앞에 부모 클래스를 명시하고 쉼표로 구분해서 적용한다.

class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
// 클래스 정의가 여기 온다
}

*/


/*

속성 요구사항

프로토콜은 특정한 이름과 속성을 갖는 인스턴스 속성과 타입 속성을 제공하는 타입이 될 수 있다. 프로토콜에는 이 속성이 저장된 속성이어야하는지 계산된 속성이어야 하는지에 대해 명시하지 않는다. 단지 속성의 이름과 타입만 명시할 뿐이다. 또한 각 속성에 대해 읽기(gettable)인지 읽기/쓰기(gettable/settable)가 필요한지 명시할 수 한다.

프로토콜의 속성에 읽기나 읽기/쓰기에 대한 명시가 있다면 그 속성은 저장된 상수값이나 읽기전용(read-only)의 계산된 값을 넣을 수 없다. 만약 읽기가 필요하다고만 명시가 되어있고 어떤 종류의 속성도 가능하며 필요하면 읽기를 만들어도 괜찮다.

속성 요구사항은 항상 var 키워드가 앞에 있는 변수 속성으로 선언된다. 읽기/쓰기 속성은 타입 뒤에 { get set }을 써서 명시하며, 읽기는 { get }으로 명시한다.

protocol SomeProtocol {
var mustBeSettable: Int { get set }
var doesNotNeedToBeSettable: Int { get }
}
타입 속성은 class 키워드를 붙여서 정의할 수 있다. 구조체나 열거형에서 구현할 때는 static을 붙이면 된다.

protocol AnotherProtocol {
class var someTypeProperty: Int { get set }
}
인스턴스 속성 하나만 필요로 하는 프로토콜 예제가 있다.

protocol FullyNamed {
var fullName: String { get }
}
FullyNamed 프로토콜은 이름이 맞으면 종류에 관계없는 속성을 정의한다. 어떤 종류여야하는지 명시하지는 않았고 그저 풀네임을 젱고할 수만 있으면 된다. String 타입의 읽기 가능한 fullName이라는 인스턴스 속성을 가진 FullNamed라는 요구사항만 명시되어있다.

*/

protocol FullyNamed {
    var fullName: String { get }
}



struct Person: FullyNamed {
    var fullName: String
}
// fullName을 가지고 있지 않으면 컴파일 오류가 발생한다.
// error: type 'Person' does not conform to protocol 'FullyNamed'

var john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed’

println(john.fullName)


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"
/*

이 클래스에서는 계산된 읽기전용 속성으로 fullName 속성을 구현했다. 각 Starship 클래스 인스턴스는 name을 필수로 prefix를 옵션으로 갖는다. prefix 값이 존재하면 name의 앞에 붙여서 우주선의 풀네임을 만들어 fullName 속성이 된다
*/



/*

메소드 요구사항

프로토콜은 일치하는 타입을 구현하기 위해 인스턴스 메소드들과 타입 메소드들을 요구사항으로 명시할 수 있다. 중괄호나 메소드 구현체(body)만 없을 뿐, 일반적인 인스턴스 메소드나 타입 메소드를 정의하는 것과 정확히 같은 방법으로 정의된다. 일반적인 메소드와 같은 규칙으로 가변길이의 변수도 가능하다.

중요!

프로토콜은 일반적인 메소드들과 같은 문법을 사용하지만 인자로 기본값을 명시할 수 없다.


protocol SomeProtocol {
class func someTypeMethod()
}

*/


protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
println("Here's a random number: \(generator.random())")
// prints "Here's a random number: 0.37464991998171"
println("And another one: \(generator.random())")
// prints "And another one: 0.729023776863283"




/*

변이(mutating) 메소드

가끔 메소드에서 자신의 인스턴스를 수정(혹은 변이)할 필요가 있다. 밸류 타입(즉, 구조체와 열거형)의 인스턴스 메소드에서 메소드의 func 앞에 mutating 키워드를 써서 소속된 인스턴스를 바꾸거나 인스턴스의 속성을 수정할 수 있게 명시한다. 이 과정은 인스턴스 메소드 내에서 밸류 타입의 수정에서 설졍되어있다.

프로토콜이 적용된 타입의 인스턴스를 변이할 수 있다고 인스턴스 메소드에 명시하려면 프로토콜 정의세ㅓ mutating 키워드를 추가하면 된다. 이 프로토콜이 적용된 구조체와 열거형은 요구사항을 만족한다.

중요!

프로토콜을 mutating이라고 명시하면 클래스에서 메소드를 구현할 때는 mutating 키워드를 쓰지 않아도 된다. mutating 키워드는 구조체와 열거형에서만 쓰인다.

*/


protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
// lightSwitch은 이제 .On과 같다.




/*


타입으로서의 프로토콜

프로토콜은 그 자체로 어떤 기능도 갖고 있지 않다. 하지만 어떤 프로토콜도 코드에서 다른 타입처럼 쓰일 수 있다.

왜냐하면 프로토콜도 타입이므로 다른 타입들이 쓰이는 곳에서 사용될 수 있다.

함수, 메소드, 생성자에서 인자의 타입 혹은 리턴 타입으로
상수, 변수, 속성의 타입으로
배열, 사전, 다른 컨테이너에서 요소의 타입으로 사용될 수 있다.
노트

프로토콜이 타입이므로 스위프트의 다른 타입(Int, String, Double같은)처럼 이름을 대문자(FullyNamed나 RandomNumberGenerator처럼)로 사용할 수 있다.


*/


class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}


var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    println("랜덤한 주사위값은 \(d6.roll())")
}
// 랜덤한 주사위값은 3
// 랜덤한 주사위값은 5
// 랜덤한 주사위값은 4
// 랜덤한 주사위값은 5
// 랜덤한 주사위값은 4




/*

위임 (Delegation)

위임은 클래스나 구조체가 다른 타입의 인스턴스에게 책임의 일부를 넘길(혹은 위임할) 수 있는 디자인 패턴이다. 이 디자인 패턴에서는 위임된 책임을 캡슐화하는 프로토콜을 정의하는데, 거기에 일치하는 타입(대리자delegate로 알려진)은 위임받은 기능이 있다고 보장된다. 위임은 특정 액션에 대해 응답하거나, 외부에서 온 정보가 어떤 타입인지에 관계없이 데이터를 처리할 때 사용할 수 있다.

*/


protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}


class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            println("Started a new game of Snakes and Ladders")
        }
        println("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        ++numberOfTurns
        println("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        println("The game lasted for \(numberOfTurns) turns")
    }
}


let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a new game of Snakes and Ladders
// The game is using a 6-sided dice
// Rolled a 3
// Rolled a 5
// Rolled a 4
// Rolled a 5
// The game lasted for 4 turns




/*

확장을 프로토콜 일치에 추가

이미 존재하는 타입의 소스에 접근할 수 없어도 그 타입에 프로토콜을 적용하고 일치하도록 확장할 수 있다. 확장은 새 속성들, 메소드들, 인덱스 참조 등을 이미 존재하는 타입에 추가할 수 있고, 프로토콜에서 필요로 하는 요구사항들을 추가할 수도 있다. 확장에 대해 더 많은 정보는 확장 챕터에 있다.

중요!

확장을 타입에 추가하는 순간 이미 만들어놓은 인스턴스들에서도 프로토콜이 적용되고 일치하게 된다.

*/

protocol TextRepresentable {
    func asText() -> String
}

extension Dice: TextRepresentable {
    func asText() -> String {
        return "\(sides)면체 주사위"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
println(d12.asText())
// "12면체 주사위" 출력



extension SnakesAndLadders: TextRepresentable {
    func asText() -> String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
println(game.asText())
// prints "A game of Snakes and Ladders with 25 squares"


/*

확장과 동시에 프로토콜 적용 선언

타입이 이미 프로토콜의 모든 요구사항에 일치하고 있지만 프로토콜을 적용한다고 명시하지 않았을 때, 빈 확장과 함께 프로토콜을 적용시킬 수 있다.

*/

struct Hamster {
    var name: String
    func asText() -> String {
        return "햄스터 이름은 \(name)"
    }
}
extension Hamster: TextRepresentable {}


let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
println(somethingTextRepresentable.asText())
// "햄스터 이름은 Simon" 출력


/*

중요

타입에서 요구사항을 만족했다고 자동으로 프토토콜이 적용되지는 않는다. 항상 명시적으로 프로토콜의 적용을 선언해줘야 한다.

*/



/*

프로토콜 타입의 콜렉션(Collection)들

프로토콜은 타입으로서의 프로토콜에서 이야기한 것처럼 배열이나 사전같은 콜렉션에 저장되는 타입으로 사용할 수 있다.

*/


let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {
    println(thing.asText())
}
// 뱀과 사다리 게임은 25칸
// 12면체 주사위
// 햄스터 이름은 Simon




/*

프로토콜 상속

프로토콜은 하나 이상의 프로토콜을 상속받을 수 있고, 그 요구사항들 위에 다른 요구사항을 추가할 수도 있다. 프로토콜 상속 문법은 클래스 상속의 문법과 비슷하지만 쉼표를 구분해서 여러 프로토콜을 나열할 수 있다.

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
// 프로토콜 정의가 여기 온다
}

*/


protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}


extension SnakesAndLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

println(game.asPrettyText())
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○




/*

프로토콜 합성

한번에 여러 프로토콜에 일치하는 타입이 필요할 때 유용하게 쓸 수 있다. 프로토콜 합성으로 여러 프로토콜을 하나의 요구사항으로 합칠 수 있다. 프로토콜 합성은 protocol<SomeProtocol, AnotherProtocol>같은 형태를 가진다. 꺾쇠(<>) 안에 쉼표로 구분해서 원하는만큼 프로토콜을 명시할 수 있다.

*/

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person2: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    println("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = Person2(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)
// prints "Happy birthday Malcolm - you're 21!"


/*

노트

프로토콜 합성은 새로 영구적으로 프토토콜 타입을 만드는 것이 아니다. 합성에 있는 모든 프로토콜의 요구사항을 합친 하나의 프로토콜을 임시로 만드는 것이다.

*/




/*

프로토콜 일치를 확인하기

타입 캐스팅에서 설명했던 것처럼 특정 프로토콜로 캐스팅하기 위해서 프로토콜 일치를 확인하는데 is와 as 연산자를 사용할 수 있다. 타입을 확인하고 캐스팅하는 것과 정확히 같은 방법으로 프로토콜을 확인하고 캐스팅할 수 있다.

- is 연산자에서는 인스턴스가 프로토콜과 일치하면 true, 아니면 false를 리턴
- 'as?' 다운캐스팅 연산자는 프로토콜 타입의 옵션값을 리턴하는데 인스턴스가 프로토콜과 일치하지 않으면 nil이 된다
- as 연산자는 강제로 다운캐스팅하고 실패하면 런타임 에러가 난다.

*/


@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

/*

노트

CounterDataSource 프로토콜 앞에 보이듯 프로토콜 일치를 확인하기 위해서는 @objc 속성(attribute)을 명시해줘야한다. 이 속성은 Objective-C 코드에서 인식할 수 있을 것이라는 것을 명시한다. Objective-C를 함께 쓰지 않더라도 프로토콜 일치를 확인하고 싶다면 objc를 프로토콜에 명시해줘야한다.

@objc 프로토콜은 구조체나 열거형은 불가능하고 클래스에만 적용할 수 있다.

*/


@objc class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

@objc class ThreeSource: CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    println(counter.count)
}
// 3
// 6
// 9
// 12

@objc class TowardsZeroSource: CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}


counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    println(counter.count)
}
// -3
// -2
// -1
// 0
// 0



