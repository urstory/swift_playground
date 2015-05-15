/*

흐름 제어 (Control Flow)

*/



/*

Swift 언어에서는 C언어 같은 프로그래밍 언어에서 제공하는 것과 비슷한 제어문 관련 구조를 제공합니다. 이러한 구조에는 for나 while이 있으며, 이러한 키워드는 어떤 작업(task)을 여러 번 수행합니다. if와 switch문은 특정 조건이 충족되는지에 따라서 분기시켜서 코드 블럭을 실행시킵니다. 또한 break나 continue 같은 구문은 실행의 흐름을 코드 상의 다른 곳으로 이동시킵니다.

C언어에서는 for-조건부-증가(increment) 순환문(loop) 이런 방식을 전통적으로 사용하는데, Swfit에서는 for-in 순환문(loop)이라는 것이 있어서 배열이나 사전(dictionaries), ranges, 문자열(strings)등 sequence에 대해서iteration하기가 쉽습니다.

C언어의 switch문과 비교했을 때, Swift의 switch문은 훨씬 더 강력합니다. Swift에서는 switch문이 "fall through" 하지 않습니다(역자주: fall through란, switch문에서 한 case에 대해서 처리하고 난 후 다음 case로 넘어가는 것). C언어에서는 실수로 break문을 써주지 않아서 에러가 생기는 경우가 있는데 Swift에서는 fall through 하지 않기 때문에 이런 에러를 방지할 수 있습니다. swich내의 case에 대해서 여러 종류의 pattern-maching을 사용할 수 있습니다. 수의 범위 match, 투플 match, casts to a specific type. switch case에서 match된 값을 임시 상수나 변수에 binding할 수도 있습니다. 이렇게 binding해두면 case의 본문(body) 내에서 이 상수나 변수를 사용할 수 있습니다. 또한 매칭 조건(matching condition)이 복잡한 경우에는, 각 case에 대해서 where절(where clause)을 사용해서 표현할 수 있습니다.

*/


/*

For 순환문(For Loops)

for 순환문(for loop) 사용하면 코드 블럭을 특정 횟수 만큼 수행할 수 있습니다. Swift에는 두 종류의 for 순환문이 있습니다:

for-in : 어떤 범위나 sequence, collection, progression에 대해서, 이 안에 있는 각 항목(item)에 대해서 코드(a set of statement)를 실행합니다.

for-condition-increment : 특정 조건부가 참이 될 때까지 코드를 실행합니다. 보통 루프를 한 번 도는 것이 끝날 때마다 counter를 1씩 증가시킵니다.

*/



/*

For-In

여러 항목이 들어 있는 컬렉션(collection)이나, 어떤 범위, 배열 안에 들어 있는 항목(item)에 대해서, 또는 문자열에 들어 있는 각 문자에 대해서 iteration을 할 때 for-in loop를 사용합니다.

*/

for index in  1...5 {
    println("\(index) times 5 is \(index * 5)")
}

/*

중요!

index 상수는 루프의 스코프(scope)안에서만 존재합니다. 루프문이 끝난 다음에 이 index의 값을 확인하고 싶거나, 이 값을 상수가 아니라 변수로 사용하고 싶으면, 루프 안에서 변수로 직접 선언해 주어야 합니다.
*/

let base  = 3
let power  =  10
var answer  =  1
for _ in  1...power {
    answer *= base
}
println("\(base) to the power  of \(power) is \(answer)")

// 앞의 예제와는 다르게 in앞에 변수가 없고 _ 가 있는 것으 알 수 가 있다. index가 사용될 필요가 없을 경우 _ 를 적어주면 된다.
// 1부터 10까지 폐쇄 구간이다.  1..<power라고 적혀있다면 1부터 9까지이다. 이 경우는 반개 구간이라고 할 것이다.


let  names  = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    println("Hello, \(name)!")
}
// 배열에 있는 값을 꺼낼때도 for ~ in ~ 문장을 사용한다.

let numberOfLegs  = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    println("\(animalName)s have \(legCount) legs")
}

// 딕셔너리 안에 있는 값을 꺼낼 때도 for ~ in 을 사용한다. 모든 key와 value를 출력한다. 여기서 조심해야 할 것은 딕셔너리 안의 값을 꺼낼 때 순서대로 나오는 보장이 없다는 것이다.

/*

For-조건부-증가부 (For-Condition-Increment )

Swift는 for-in루프 말고도 C언어에서 쓰는, 조건부와 증가부가 들어 있는 for 루프를 지원합니다:

*/

for var index  = 0; index  < 3; ++index {
    println("index is \(index)")
}
// 위의 index는 for반복문 안에서만 사용할 수 있다.
// 아래와 같이 for 문장 위에 선언을 해야지만 for문 안과 밖에서 다 사용할 수 있다.

var index : Int             // <= 이 부분에서 선언해 주어야..
for index  = 0; index  < 3; ++index {
    println("index is \(index)")
}


/*

While 루프 (While Loops)

while 루프는 조건부가 거짓이 될 때까지 코드 블럭을 실행시킵니다. 이런 종류의 루프는 보통, 이터레이션이 시작하기 전에 이터레이션이 몇 번이나 돌 지 알지 못할 때 자주 사용합니다. Swift는 두 종류의 while루프를 지원합니다. 하나는 while인데, 이 루프는 루프를 돌기 시작할 때 조건부를 검토합니다. 다른 하나는 do-while인데, 이 루프는 루프를 돌고 나서 조건부를 검토합니다.

*/

var total = 0;
var i2 = 1;
while i2 <= 100 {
    total += i2
    i2++
}
println(total)

/*
Do-While

while루프와 비슷하지만 약간 다른 루프도 있습니다. 이름은 do-while루프이며, 이 루프에서는 루프의 조건부가 검토되기 전에 루프 블록이 한 번 실행됩니다. 그런 다음 조건부가 거짓이 될 때까지 루프를 반복합니다.
*/


total = 0;
i2 = 1;
do {
    total += i2
    i2++
}while i2 <= 100
println(total)


/*

조건문 (Conditionals Statements)

특정 조건이 충족하는지에 따라 각각 다른 코드를 실행하는 것이 유용한 경우가 많습니다. 어떤 에러가 발생했을 때 특정 코드를 실행시키고 싶을 수도 있습니다. 또는 어떤 값이 너무 높거나 너무 낮을 때 메시지를 보여주고 싶을 수도 있습니다. 이렇게 하려면 코드를 조건문으로 쓰면 됩니다.

Swift에서 코드에 조건문을 추가하는 방법은 두 가지가 있습니다. 바로 if문과 switch문입니다. 보통 조건의 수가 많지 않을 때에는 보통 if문을 사용합니다. 한편 조건의 종류가 다양하고 복잡할 때에는 switch문이 더욱 적합하니다. 실행시킬 코드 브랜치를 선택하는데 패턴-매칭이 도움이 되는 경우에도 switch문을 사용합니다.
*/


var temperatureInFahrenheit  = 30
if temperatureInFahrenheit  <= 32 {
    println("It's very cold. Consider wearing a scarf.")
}


temperatureInFahrenheit  = 40
if temperatureInFahrenheit  <= 32 {
    println("It's very cold. Consider wearing a scarf.")
} else {
    println("It's not that cold. Wear a t-shirt.")
}


temperatureInFahrenheit  = 90
if temperatureInFahrenheit  <= 32 {
    println("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit  >= 86 {
    println("It's really warm. Don't forget to wear sunscreen.")
} else {
    println("It's not that cold. Wear a t-shirt.")
}


temperatureInFahrenheit  = 72
if temperatureInFahrenheit  <= 32 {
    println("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit  >= 86 {
    println("It's really warm. Don't forget to wear sunscreen.")
}



/*
Switch

switch문은 값을 검토해서 몇 가지 패턴과 비교합니다. 그런 다음, 처음 매칭되는 패턴이 있는 코드 블록을 실행시킵니다. if문을 사용할 때보다 switch문을 사용했을 때의 장점은, 여러 가지 경우에 대해서 처리할 수 있게 된다는 점입니다.

*/

let someCharacter: Character  = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    println("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
"n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    println("\(someCharacter) is a consonant")
default :
    println("\(someCharacter) is not a vowel or a consonant")
}

/*

let anotherCharacter: Character  = "a"
switch anotherCharacter {
case "a":
case "A":
    println("T he letter A")
default :
    println("Not the letter A")
}
*/

// c언어와 JAVA처럼 case 뒤에 아무내용이 없을 경우 다음 case문을 실행하는 것이 아니라 컴파일 오류가 난다.
// 위의 코드는 다음과 같이 수정되어야 한다.
let anotherCharacter: Character  = "a"
switch anotherCharacter {
case "a","A":
    println("T he letter A")
default :
    println("Not the letter A")
}

// 범위로 매치하기
let count  = 99
let countedThings  = "stars in the Milky Way"
var naturalCount : String
switch count {
case 0:
    naturalCount  = "no"
case  1...3:
    naturalCount  = "a few"
case 4...9:
    naturalCount  = "several"
case 10...99:
    naturalCount  = "tens of"
case 100...999:
    naturalCount  = "hundreds of"
case 1000...999_999:
    naturalCount  = "thousands of"
default:
    naturalCount  = "millions and millions of"
    println("There are \(naturalCount) \(countedThings).")
}


// 튜플을 switch문에서 사용하기

let somePoint  = (1,  1)
switch somePoint {
case (0, 0):
    println("(0, 0) 은 원점에 있습니다")
case (_, 0):
    println("(\(somePoint.0), 0)은 x축 상에 있습니다. ")
case (0, _):
    println("(0, \(somePoint.1))은 y축 상에 있습니다.")
case (-2...2, -2...2):
    println("(\(somePoint.0), \(somePoint.1))은 상자 안에 있습니다.")
default :
    println("(\(somePoint.0), \(somePoint.1))은 상자 밖에 있습니다.")
}



let anotherPoint  = (2, 0)
switch anotherPoint {
case (let x, 0):
    println("x축 상에 있으며 x의 값은 \(x)값입니다.")
case (0, let y):
    println("y축 상에 있으며 y의 값은 \(y)입니다.")
case let (x, y):
    println("(\(x), \(y))에 있습니다.")
}

/*
값을 상수와 묶기, 상수에 바인딩하기 (Value Bindings)

switch문에서 경우는 매치된 값이나 값들을 임시 상수나 변수에 바인딩할 수 있습니다. 이렇게 바인딩한 상수나 변수는 그 경우의 본문에서 사용할 수 있습니다. 이렇게 하는 것을 보고 값을 묶는다, 바인딩(value binding)한다고 합니다. 왜냐하면 해당 경우의 본문 내에서 값이 특정 상수나 변수에 “묶여” 있기 때문이다.
*/


// switch문장에 where를 넣어서 조건절 사용하기
let yetAnotherPoint  = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x  == y :
    println("(\(x), \(y)) 는 x==y인 곳에 있습니다.")
case let (x, y) where x  == -y :
    println("(\(x), \(y)) 는 x==-y인 곳에 있습니다.")
case let (x, y):
    println("(\(x), \(y)) 는 기타 구역에 있습니다.")
}

/*


흐름제어 이동문(Control Transfer Statements)

Control Transfer Statements 는 control을 특정 코드로부터 다른 코드로 이동시키는 방법으로 코드가 실행되는 순서를 바꿉니다. Swift에는 네 가지 흐름제어 이동문이 있습니다:

continue
break
fallthrough
return

*/


let puzzleInput  = "great minds think alike"
var puzzleOutput  = ""
for character in puzzleInput {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default :
        puzzleOutput += String(character)
    }
    println(puzzleOutput)
}

/*
중요!

for-조건부-증가부 루프에서 continue 문을 호출한 이후에도, 증가자(incrementer)의 참 거짓 여부를 검토합니다. 루프 자체는 계속됩니다. 다만 루프 내 본문에 있는 코드가 건너뛰어질 뿐입니다.

*/

let numberSymbol: Character = "三"  // Simplified Chinese for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    println("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    println("An integer value could not be found for \(numberSymbol).")
}



// Swift는 c언어나 JAVA처럼 case가 실행되고 다음 case로 건너가서 실행되지 않는다.
// 만약 c언어나 JAVA처럼 그 다음을 실행하고 싶다면 fallthrough 를 써줘야 한다.
let integerToDescribe  = 5
var description  = "수 \(integerToDescribe) 는"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += "소수이며, 또한"
    fallthrough
default :
    description += " 정수입니다."
}
println (description)


/*
중요!

키워드 fallthrough를 사용할 때, 조건을 걸어서 다음으로 넘어갈 case를 지정할 수는 없습니다. C언어에서 처럼, fallthrough 키워드를 사용하면 단지, 다음에 나오는 case로 넘어갈 수 있을 뿐입니다.
*/

loopExit :
for k3 in 1...9 {
    for i3 in 1...9 {
        println("\(k3) , \(i3)");
        if i3 == 3 {
            break loopExit;
        }
    }
}
println("exit")
// loopExit는 이름표(Label)이다. 다중 루프를 벗어나거나 할 경우 사용한다. loopExit는 변수명처럼 임의의 이름이 될 수 있다.


// 질문
// 위의 코드에서 break를 continue로 변경하면 어떻게 될까?




