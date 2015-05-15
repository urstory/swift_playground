/*

확장 (Extensions)

확장(Extensions)은 이미 존재하는 클래스, 구조체, 열거형 타입에 새 기능성을 추가합니다. 이는 원본 소스코드에 접근할 수 없는 타입들도 확장할 수 있습니다. (Retroactive modeling) 확장은 Objective-c 의 카테고리 와 유사합니다.

Swift 의 확장이 할수있는 것:

- computed properties, computed static properties의 추가
- 인스턴스 메소드와 타입 메소드 정의
- 새로운 이니셜라이저 제공
- 서브스크립트 정의
-  기존 타입에 프로토콜 적용시키기


중요!

만약 기존 타입에 새로운 기능성을 추가하기 위해 확장을 정의 한다면, 확장이 정의 되기 이전에 생성된 해당 타입의 모든 인스턴스들도 새 기능성이 적용이 됩니다.


*/


/*

확장 문법

extension 키워드로 확장을 선언합니다:

extension SomeType {
// SomeType에 추가할 새 기능
}

확장은 기존의 타입을 하나 이상의 프로토콜을 적용하기 위해서 확장시킬 수 있습니다. 이 경우 클래스 또는 구조체와 같은 방식으로 적용시킬 프로토콜 이름을 적습니다:

extension SomeType: SomeProtocol, AnotherProtocol {
// 프로토콜의 요구사항을 이곳에 구현
}

*/



/*
연산 속성

확장은 연산 인스턴스 속성과 연산 타입 속성을 기존의 타입에 추가할 수 있습니다. 이 예제는 거리 단위를 제공하기 위해 다섯개의 연산 인스턴스 속성을 Swift의 내장 Double 타입에 추가합니다.

*/

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
println("One inch is \(oneInch) meters")
// prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
println("Three feet is \(threeFeet) meters")
// prints "Three feet is 0.914399970739201 meters"

let aMarathon = 42.km + 195.m
println("A marathon is \(aMarathon) meters long")
// prints "A marathon is 42195.0 meters long"


/*

이니셜라이저

확장은 기존 타입에 새로운 이니셜라이저를 추가할 수 있습니다. 이는 다른 타입들이 여러분의 커스텀 타입을 이니셜라이저의 인자로 받을 수 있도록 하거나 또는 타입의 기본 구현에 포함되어 있지 않은 추가 적인 이니셜라이저 옵션을 제공할 수 있도록 확장하는 것을 가능하게 합니다.

확장은 새 convenience 이니셜라이저를 클래스에 추가할 수 있습니다. 하지만 새 designated 이니셜라이저 또는 디이니셜라이저를 추가할 수는 없습니다. designated 이니셜라이저와 디이니셜라이저는 반드시 본래의 클래스 구현에서 제공되어야 합니다.

중요!

만약 확장을 사용해서 모든 저장 속성의 기본 값을 제공하는 값 타입에 새로운 이니셜라이저를 추가하고, 어떠한 커스텀 이니셜라이저도 정의하지 않았다면, 기본 이니셜라이저와 memberwise 이니셜라이저를 호출 할 수 있습니다. Initializer Delegation for Value Type에서 설명한 것 처럼 이니셜라이저를 값 타입의 본래 구현에 작성을 한 경우에는 해당 되지 않습니다.

*/


struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))

// Rect 구조체에 특정 중심점과 크기를 받기 위한 추가 이니셜라이저를 제공하기 위해 확장할 수 있습니다.

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


/*
이 새 이니셜라이저는 처음에 제공된 center 값과 size값을 기반으로 적절한 origin point를 계산합니다. 그 다음 구조체의 자동 memberwise 이니셜라이저 init(origin:size:)를 호출하여 새 origin 과 size 값을 적절한 속성에 저장합니다.
*/

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

/*
중요!

확장으로 새 이니셜라이저를 제공 할 경우 이니셜라이저가 완료되었을 때 각 인스턴스가 완전히 초기화 되었는지 확인하는 책임은 작성자에게 있습니다.
*/



/*

메소드

확장은 기존 타입에 새 인스턴스 메소드와 타입 메소드를 추가할 수 있습니다.

*/


extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions({
    println("Hello!")
})
// Hello!
// Hello!
// Hello!


3.repetitions {
    println("Goodbye!")
}
// Goodbye!
// Goodbye!
// Goodbye!


/*

Mutating 인스턴스 메소드

확장을 이용해 인스턴스 메소드 추가함으로써 인스턴스 스스로 또한 수정할 수 있습니다. self 또는 자신의 속성을 수정하는 구조체와 enumeration 메소드들은 반드시 인스턴스 메소드를 mutating으로 표시 해야합니다.

*/

extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt is now 9



/*

Subscripts

확장은 기존 타입에 새 subscripts 를 추가할 수 있습니다. 이 예제는 integer subscript 를 Swift 내장 Int 타입에 추가합니다. 이 subscript [n] 는 수의 오른쪽으로 부터 n번째 자리에 있는 10진수 숫자 하나를 반환합니다:

123456789[0] returns 9
123456789[1] returns 8
... 기타 등등:

*/

extension Int {
    subscript(var digitIndex: Int) -> Int {
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            --digitIndex
        }
        return (self / decimalBase) % 10
    }
}

println(746381295[0])
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7

746381295[9]
// returns 0, as if you had requested:
println(0746381295[9])
// 0
println(0_746_381_295[9])
// 0
println(0_746_381_295[8])
// 0


/*

Nested Types

확장은 새 Nested 타입을 기존 클래스, 구조체, enumeration에 추가할 수 있습니다.

*/


extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ")
        case .Zero:
            print("0 ")
        case .Positive:
            print("+ ")
        }
    }
    print("\n")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// prints "+ + - 0 - 0 +"

/*

중요!

character.kind 는 이미 Character.Kind 타입으로 알려져 있기 때문에 모든 Character.Kind 멤버 값들은 switch 문에서 Character.Kind.Vowel보다 .Vowel같이 생략된 형식으로 쓸 수 있습니다.

*/
