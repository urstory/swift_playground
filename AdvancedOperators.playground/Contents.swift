/*

고급 연산자 (Advanced Operators)


기본 연산자 항목에서 설명했던 연산자들에 더하여, Swift는 훨씬 다양한 방법으로 값을 다루는 몇 개의 고급 연산자들을 제공합니다. 이들은 당신이 C와 Objective-C에서부터 친근하게 여겼던 비트를 다루는 연산자 모두를 포함합니다.

C에서의 산술 연산자들과는 다르게, Swift에서의 산술 연산자들은 기본적으로 오버플로우(Overflow)가 일어나지 않습니다. 오버플로우 동작(Overflow behavior)은 오류로써 잡히고 보고됩니다. 오버플로우 동작을 허용하기 위해서, 오버플로우를 기본으로 하는 산술 연산들 중에 Swift의 두번째 집합을 사용해야 합니다. 예를 들어, 오버플로우 덧셈(overflow addition, &+)이 그러한 집합에 속합니다. 모든 오버플로우 연산자들은 엠퍼샌드(ampersand, &)를 가지고 시작합니다.

당신이 당신 소유의 구조체들과 클래스, 그리고 열거자들을 선언할때, 이들 사용자 정의 타입들에 대해서 표준 Swift 연산자들의 독자적인 구현들(own implementations)을 제공하는데 유용할 수 있습니다. Swift는 이들 연산자들의 맞춤형(tailored) 구현들을 제공하고 그들의 행동이 당신이 만든 각각의 타입에 대해서 무엇을 해야 할지를 정확하게 결정하기 쉽게 만듭니다.

당신은 연산자들을 재정의하는데 아무런 제한이 없습니다. Swift는 당신에게 당신 자신의 맞춤형 중위(infix), 전위(prefix), 후위(postfix) 그리고 할당 연산자들을 정의하는데 자유를 줍니다. 그리고 그것들의 우선순위와 결합순위 역시 자유롭게 정의가 가능합니다. 이들 연산자들은 마치 이미 선언된 연산자들처럼 당신의 코드 안에서 사용되고 적용될 수 있으며, 당신은 당신이 정의한 맞춤형 연산자들을 지원하도록 이미 존재하는 타입들조차 확장할 수 있습니다.

*/




/*

비트 연산자들

비트 연산자들은 당신에게 하나의 데이터 구조체 안에 있는 개개의 가공되지 않은 데이터 비트들(raw data bits)을 다루는 것을 허용합니다. 그들은 종종 그래픽 프로그래밍과 디바이스 드라이버 제작과 같은 저수준 프로그래밍에 사용됩니다. 또한 비트 연산자들은 당신이 외부의 입력들(external source)로부터 가져오는 가공되지 않은 데이터(raw data)를 가지고 작업할때 유용합니다. 예를 들어, 사용자 정의 프로토콜을 이용한 통신에서 데이터의 부호화(encoding)와 복호화(decoding)과 같은 것들이 그것입니다.

Swift는 C에서 발견되는 모든 비트 연산자들을 지원합니다. 이는 아래에서 좀더 자세히 설명드리겠습니다.

*/




/*

비트 NOT 연산자

비트 NOT 연산자(~)는 다음과 같이 숫자의 모든 비트들을 뒤집습니다.(invert)

*/


let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits  // equals 11110000





/*

비트 AND 연산자

비트 AND 연산자(&)는 두 숫자의 비트들을 결합합니다. 다음과 같이 동일 위치에 있는 비트들이 양쪽 입력 숫자들에 대해서 둘 다 1이면, 결과 값의 동일 위치에 있는 비트 역시 1로 설정되는 새로운 숫자를 돌려받습니다.

*/

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  // equals 00111100




/*

비트 OR 연산자

비트 OR 연산자(|)는 두 수의 비트들을 비교합니다. 만일 다음처럼 입력 수들 중에 어떤 하나가 비트 1이면, 연산자는 해당 위치의 비트가 1로 설정된 새로운 수를 돌려줍니다.

*/

let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits  // equals 11111110


/*
비트 XOR 연산자

비트 XOR 연산자 또는 배타적(exclusive) OR 연산자 (^)는 두 수의 비트들을 비교합니다. 연산자는 다음과 같이 동일 위치에 두 입력 비트들이 서로 다른 값을 가지면 1로 같은 값을 가지면 0으로 설정된 새로운 수를 돌려받습니다.
*/


let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits  // equals 00010001




/*

비트 왼쪽 및 오른쪽 쉬프트 연산자들

비트 왼쪽 이동 연산자(<<)와 비트 오른쪽 이동 연산자(>>)는 아래 정의된 규칙에 따라서, 특정 수의 위치(a certain number of places)로 모든 비트들을 왼쪽 또는 오른쪽으로 이동시킵니다.

비트 왼쪽 그리고 오른쪽 쉬프트는 2의 인수로 정수에 곱한 것과 나눈 것의 효과를 가집니다. 왼쪽으로 한 자리만큼 정수의 비트들을 이동하는 것은 값을 두 배로 하는 것과 같은 효과를 나타냅니다. 마찬가지로 오른쪽으로 이동하는 것은 2로 나누는 것과 동일한 효과를 가집니다.

부호 없는 정수들에 대한 쉬프트 방법

부호 없는 정수의 비트 쉬프트는 다음처럼 합니다.

- 존재하는 비트들은 요청된 수의 위치로(the requested number of places) 왼쪽 또는 오른쪽으로 쉬프트됩니다.
- 정수 공간의 크기를 넘어 이동된 비트들은 버려집니다.
- 원래의 비트들이 이동되고 남은 자리에 0이 삽입됩니다.


이 접근은 논리적 쉬프트로써 알려져 있습니다.


*/


let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000
shiftBits >> 2             // 00000001




let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153




/*

부호 있는 정수에서의 쉬프트 동작(behavior)

부호 있는 정수에 대해서 쉬프트를 하는 것은 부호 없는 정수 때보다 더 복잡합니다. 이는 부호 있는 정수를 이진수로 표현하는 방식 때문입니다. (아래 예들은 간단함을 위해 8비트 부호 있는 정수들을 기본으로 하여 진행됩니다. 그러나 어떠한 크기의 부호 있는 정수에도 앞으로 나올 원칙을 적용할 수 있습니다.)

부호 있는 정수들의 (부호 비트로 알려진) 첫 번째 비트는 그 정수가 양의 정수인지 음의 정수인지를 나타내는데 사용합니다. 부호비트가 0이면 양수를, 부호비트가 1이면 음수를 의미합니다.

*/




/*

오버플로우 연산자들

만일 당신이 해당 타입의 변수가 가질 수 없는 값을 정수 상수 또는 변수에 숫자의 대입을 시도한다면, 기본적으로 Swift는 유효하지 않은 값이 생성되기를 허락하기 보다는 오류를 보고 합니다. 이 행동은 당신이 너무 크거나 너무 작은 숫자들을 가지고 작업할 때 추가적인 안전함(extra safety)을 당신에게 제공합니다.


*/


var potentialOverflow = Int16.max
// potentialOverflow는 3276과 동일합니다. 이것은 Int16이 가질 수 있는 가장 큰 값입니다.
//potentialOverflow += 1
// 이것은 오류를 발생합니다.


/*

값이 너무 크거나 너무 작을 때 에러 핸들링을 제공하는 것은 경계 값 조건과 관련된 코딩을 할 때 훨씬 더 많은 유연성을 당신에게 줍니다.

그렇지만, 당신이 사용 가능한 비트들의 수를 일부로 줄이기 위해서 오버플로우 조건을 특별히 원할 때, 당신은 오류를 일으키는 것보다 다음의 행동으로 이를 수행할 수 있습니다. Swift는 정수 계산에 대해서 오버플로우 동작을 수행할 수 있는 다섯 가지의 오버플로우 연산자들을 제공합니다. 이들 연산자들 모두는 앰퍼센트(&)를 가지고 시작합니다.

- Overflow addition (&+)
- Overflow subtraction (&-)
- Overflow multiplication (&*)
- Overflow division (&/)
- Overflow remainder (&%)

*/



/*
값 오버플로우
*/


var willOverflow = UInt8.max
// willOverflow는 255와 동일합니다. 이것은 UInt8이 가질 수 있는 최대 값입니다.
willOverflow = willOverflow &+ 1
// willOverflow는 지금부터 0과 동일합니다.

/*

변수 willOverflow는 UInt8이 가질 수 있는 최대 값(즉, 255 또는 이진수로 11111111)으로 초기화되어 있습니다. 그때 오버플로우 덧셈 연산자(&+)를 사용하여 1을 증가시킵니다. 이것은 그것들의 이진 표현을 UInt8의 크기를 넘도록 밀어내는데, 이것은 아래 그림에서 보여지듯이 UInt8이 가질 수 있는 값의 범위를 넘어서게 되고 오버플로우를 발생시킵니다. 오버플로우 덧셈 이후로 UInt8의 범위 안에 남아있는 값은 00000000 또는 0입니다.

*/




/*
값 언더플로
*/

var willUnderflow = UInt8.min
// willUnderflow는 UInt8이 유지할 수 있는 가장 작은 값인 0이 됩니다.
willUnderflow = willUnderflow &- 1
// 현재 willUnderflow는 255와 동일합니다.




var signedUnderflow = Int8.min
// signedUnderflow는 -128과 같습니다. 이는 Int8이 가질 수 있는 가장 작은 값입니다.
signedUnderflow = signedUnderflow &- 1
// signedUnderflow는 지금 127과 같습니다.






/*

0으로 나누기

0으로 숫자를 나는 것(i/0) 또는 0으로 나머지를 계산하기(i%0)를 시도하는 것은 오류를 발생시킵니다.

1:let x = 1 2:let y = x / 0

그렇지만 이들 연산자들(&/와 &%)의 오버플로우 버전들은 당신이 만일 0으로 나누면 0의 값을 돌려줍니다.

1:let x = 1 2:let y = x &/ 0 3:// y는 0입니다.

*/



/*
우선순위와 결합순위

연산자 우선순위는 다른 것보다 더 높은 우선 순위를 몇몇 연산자에게 줍니다: 이들 연산자들은 첫 번째로 계산됩니다.

연산자 결합순위는 같은 우선순위의 연산자들이 어떻게 함께 그룹화되는지 또는 왼쪽으로부터 그룹화되는지, 아니면 오른쪽으로부터 그룹화되는지를 정의합니다. "그들이 그들의 오른쪽으로 그 표현(expression)과 관련 있다는 의미 또는 "그들은 그들의 오른쪽으로 그 표현과 관련 있다는 의미로써 그것을 생각해보세요

*/


2 + 3 * 4 % 5
// 이것은 4와 동일합니다.


/*

중요!

Swift의 연산자 우선순위와 결합순위 규칙은 C와 Objective-C에서 발견되는 것보다 더 간단하고 더 쉽게 예측될 수 있습니다. 하지만, 이것은 그것들이 C를 기본으로 하는 언어들에서와 완전히 같지 않다는 것을 의미합니다. 여전히 연산자들 간의 상호작용이 이미 존재하는 코드를 Swift코드로 포팅할때 당신이 의도하는 방식으로 동작하는지에 대해서 확신을 가지고 주의 깊게 적용해야 합니다.

*/





/*

연산자 함수들

클래스와 구조체는 이미 존재하는 연산자들에 대해서 그들 자신의 구현을 제공할 수 있습니다. 이것은 이미 존재하는 연산자들을 오버로딩하는 것으로 알려져 있습니다.

아래의 예는 사용자 정의 구조에 대해서 산술 덧셈 연산자(+)를 어떻게 구현할 수 있는지를 보여줍니다. 산술 덧셈 연산자는 두 개의 대상에서 동작하기 때문에 2항 연산자이며, 그것이 이들 두 개의 대상 사이에서 나타나기 때문에 중간연산자라고 불릴 수 있습니다.

*/


struct Vector2D {
    var x = 0.0, y = 0.0
}

func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}


let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector is a Vector2D instance with values of (5.0, 5.0)





/*

전위 연산자와 후위 연산자들

위에서 보여준 예는 2항 중간 연산자의 사용자 정의 구현을 설명한 것 입니다. 클래스와 구조체들은 표준 단항 연산자들의 구현을 제공해줄 수 있습니다. 단항 연산자들은 단일 타깃에 대해서 동작합니다. 만일 그것들이 그들의 타깃보다 앞서서 나타난다면(예를 들어 -a와 같은) 전위 연산자이고, 반대로 그들의 타깃 뒤에서 나타난다면(i++과 같은) 후위 연산자라고 말합니다.

*/

prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}



let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative is a Vector2D instance with values of (-3.0, -4.0)
let alsoPositive = -negative
// alsoPositive is a Vector2D instance with values of (3.0, 4.0)


/*

복합 할당 연산자

복합 할당 연산자들은 다른 동작에 할당(=) 연산자를 결합한 것 입니다. 예를 들어, 덧셈 할당 연산자(+=)는 하나의 동작 안에 덧셈과 할당 연산을 합친 것 입니다.당신은 또한 복합 할당 연산자들의 왼쪽 입력 파라메터들을 'inout'으로써 표시해야만 합니다. 이것은 파라메터의 값이 연산자 함수 안에서 직접적으로 수정될 것이기 때문입니다.

*/

func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original now has values of (4.0, 6.0)


prefix func ++ (inout vector: Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement
// toIncrement now has values of (4.0, 5.0)
// afterIncrement also has values of (4.0, 5.0)

/*

중요

주목 기본 할당 연산자(=)를 오버로드하는 것은 불가능합니다. 단지 복합 할당 연산자들만이 오버로드됩니다. 비슷하게 3항 조건 연산자(a ? b : c)는 오버로드될 수 없습니다.

*/





/*

동등 연산자들

사용자 정의 클래스와 구조체들은 동등 연산자들, 즉 "같음(equal to)" 연산자 (==)와 "다름" 연산자(!=)로써 알려져 있는 연산자들의 기본 구현들을 받지 못 합니다. Swift에서는 당신 자신의 사용자 정의 타입에 대해서 "같음"으로 인정될 수 있는 것에 대한 추측하는 것이 불가능합니다. 이것은 "같음"의 정의가 당신의 코드에서 이들 타입들이 수행하는 역할에 의존하기 때문입니다.

사용자가 만든 타입의 동등성 검사를 위한 동등성 연산자를 사용하기 위해서는 다른 중위 연산자들에 대해서와 같이 연산자들의 구현을 제공해야 합니다.

*/


func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}
func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}



let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    println("These two vectors are equivalent.")
}
// prints "These two vectors are equivalent."






/*

사용자 정의 연산자들

당신은 Swift에 의해서 제공되는 표준 연산자들뿐만이 아니라 당신 소유의 사용자 정의 연산자들을 선언하고 구현할 수 있습니다. 사용자 정의 연산자들은 문자들 / = - + * % < > ! & | ^ . ~.를 가지고 단지 정의될 수 있습니다.

*/


// 새로운 연산자들은 연산자 키워드를 사용하여 전역 수준에서 정의되고, 전위, 중위 또는 후위로써 정의될 수 있습니다.
prefix operator +++ {}



prefix func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}



var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled는 지금 (2.0, 8.0)의 값들을 가집니다.
// afterDoubling은 또한 (2.0, 8.0)의 값들을 가집니다.





/*

사용자 정의 중간 연산자들에 대한 우선순위와 결합순위

사용자 정의 중위 연산자들 또한 우선순위와 결합순위를 나열할 수 있습니다.

*/

infix operator +- { associativity left precedence 140 }
func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector is a Vector2D instance with values of (4.0, -2.0)


/*
결합순위에 대해서 가능한 조건들은 왼쪽, 오른쪽, 그리고 아무것도 아닌 쪽이 있습니다. 왼쪽 결합 연산자들은 만일 같은 우선순위를 가진 다른 왼쪽 결합 연산자들 옆에 쓰여져 있다면 왼쪽으로 결합합니다. 유사하게, 오른쪽 결합 연산자들은 같은 우선순위의 다른 오른쪽 결합 연산자들이 옆에 쓰여져 있을 경우 오른쪽으로 결합니다. 아무 쪽도 아닌 결합 연산자들은 같은 우선 순위를 가진 다른 연산자들 옆에 쓰여질 수 없습니다.

결합 방법에 대한 조건은 특별히 이야기되지 않는다면 아무 쪽도 아닌 게 기본입니다. 우선순위의 경우 특별히 이야기되지 않는다면 100이 기본입니다.

위의 예제는 '+-'라고 불리는 새로운 사용자 정의 중위 연산자를 정의합니다. 이때 이 연산자는 왼쪽 결합이며 140의 우선순위를 가집니다.
*/






