let someString = "Some string literal value"

// let은 상수를 정의할 때 사용한다. someString을 선언하였다.
// 비어있는 문자열은 다음과 같이 선언한다.




var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax

if emptyString.isEmpty {
    println("Nothing to see here")
}


var variableString = "Horse"
variableString += " and carriage"


//let constantString = "Highlander"
//constantString += " and another Highlander"
//위의 2줄은 컴파일 오류가 난다. 왜 그럴까?
// let은 상수를 정의하기 때문이다.


// String은 value type이다.

for character in "Dog!🐶" {
    println(character)
}
// 문자열을 구성하고 있는 문자를 하나씩 출력한다.
//D
//o
//g
//!
//🐶

let exclamationMark: Character = "!"
// Java의 경우는 문자를 선언할 때 작은따옴표를 이용항 '!' 라고 선언한다. Swift는 문자의 경우도 큰따옴표를 이용한다.

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
println(catString)

// 문자 배열을 String initializer의 파라미터로 전달하여 문자열을 만들었다.

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// 문자열과 문자열은 + 연산자를 이용하여 연결할 수 있다.

var instruction = "look over"
instruction += string2
// instruction = instruction + string2 와 같은 코드이다.

welcome.append(exclamationMark)
println(welcome)
// welcome문자열에 "!"가 추가되었다. Java를 예로 들자면 StringBuffer와 유사하다는 것을 알 있다.

var str50 = "hello"
str50.append(exclamationMark)
println("str50 \(str50)")

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// \(변수) 형식을 문자열 안에서 사용하면 변수의 값을 문자열에서 사용할 수 있다.


// 유니코드의 사용.
//문자열 리터럴은 다음과 같은 형식으로 선언할 수 있다.
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496


let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́

let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ

let enclosed: Character = "\u{20DD}"
let enclosedEAcute: Character = "\u{E9}\u{20DD}"


let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// REGIONAL INDICATOR SYMBOL LETTER U (U+1F1FA) and REGIONAL INDICATOR SYMBOL LETTER S (U+1F1F8)
// 참고 : http://en.wikipedia.org/wiki/Regional_Indicator_Symbol
// 참고 : http://www.unicode.org/charts/PDF/U1F100.pdf

let regionalIndicatorForKR: Character = "\u{1F1F0}\u{1F1F7}"


// 문자열의 길이
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
println("unusualMenagerie has \(count(unusualMenagerie)) characters")

// count함수에 문자열을 넣으면 구할 수 있다.
println(count("hello"))



var word = "cafe"
println("the number of characters in \(word) is \(count(word))")

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
println("the number of characters in \(word) is \(count(word))")
// e뒤에 엑센트를 추가하였다. 글자가 길어진 것이 아니기 때문에 카운트는 4가 나온다.


// 문자열 index
let greeting = "Guten Tag"
println(greeting.startIndex)
println(greeting.endIndex)
// 문자열의 시작index와 끝 index


greeting[greeting.startIndex]

greeting[greeting.startIndex.successor()]
// 0 + 1

greeting[greeting.endIndex.predecessor()]
// 마지막 문자

let index = advance(greeting.startIndex, 7)
greeting[index]
// a


//greeting.endIndex.successor()
// 위의 줄은 fatal error가 난다.

for index in indices(greeting) {
    print("\(greeting[index]) ")
}
println("\n")


// 추가 & 삭제
// Swift의 문자열은 임의의 숫자를 직접 입력하여 문자열을 자를 수가 없다.
// advance 함수를 이용해서 일정 거리(distance)만큼 밀어버린 인덱스(String.Index)를 생성해서 잘라내야 한다.
var welcome2 = "hello"
welcome2.insert("!", atIndex: welcome2.endIndex)
//마지막 index에 "!"를 추가한다.

welcome2.splice(" there", atIndex: welcome2.endIndex.predecessor())
// hello와 !사이에 ther가 추가된다.


welcome2.removeAtIndex(welcome2.endIndex.predecessor())
// 맨 마지막 문자 이하로부터 자른 값을 반환한다. welcome2는 !앞의 문자열을 가지게 된다.
println(welcome2)

var str = "Hello, Swift Language"

//Swift에서 문자열을 자르는 함수 - substring은 String.Index 를 사용하는데, 이게 임의의 값을 설정할 수가 없다!
//advance 함수를 이용해서 일정 거리(distance)만큼 밀어버린 인덱스(String.Index)를 생성해서 잘라내야 한다.

let startIndex = advance(str.startIndex, 5)
let endIndex = str.endIndex


//다음은 범위(Range)로 문자열을 자르는 코드다.

let range = startIndex..<endIndex
str.removeRange(range)
println(str)

// 문자열과 문자열의 비교는 == 로 할 수 있다.

let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    println("These two strings are considered equal")
}

// 보기엔 달라보여도 문자열 자체는 같다.
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    println("These two strings are considered equal")
}



// 문자열 배열을 선언한 후, for .. in .. 구문을 이용하여
// 배열에서 값을 하나씩 꺼낸 후 문자열이 "Act 1 "으로 시작하는 것이 몇개 인지 구하는 코드.
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        ++act1SceneCount
    }
}
println("There are \(act1SceneCount) scenes in Act 1")


// 문자열이 특정 문자열로 끝나는지를 확인하여 카운트.
var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        ++mansionCount
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        ++cellCount
    }
}
println("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

println("----------!!")

// 문자열을 구성하는 문자의 유니코드값 구하기
let dogString = "Dog‼🐶"
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ")
}
print("\n")

// 위의 경우는 utf8로 아래는 utf16으로 구함.
for codeUnit in dogString.utf16 {
    println("\(codeUnit) ")
}
print("\n")

import Foundation


