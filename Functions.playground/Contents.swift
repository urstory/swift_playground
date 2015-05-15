/*
함수

함수는 특정 일을 수행하는 자기 완결성(Self-contained)을 가진 코드들의 집합입니다. 함수의 이름을 지으면서 이 함수가 무엇을 하는지 식별하게 할 수 있습니다. 그리고 그 이름으로 함수를 "호출(Call)"하여 필요할때 함수의 일을 수행하게 만들 수 있습니다. 스위프트(Swift)의 함수 문법은 파라메터가 없는 C스타일의 함수에서부터 지역 파라메터와 파라메터 이름 각각에 대한 외부 파라메터를 가지고 있는 복잡한 오브젝티브-C 스타일의 함수까지 전부 표현할 수 있습니다. 파라메터는 기본 값을 가질수 있어 단순한 함수 호출에 쓰일수 있습니다. 또한 In-out 파라메터로서 변수를 넘겨 변수가 함수의 실행후에 파라메터가 변경되게 할 수도 있습니다. 파라메터 타입과 반환(Return) 타입으로 이루어진 모든 스위프트의 함수들은 타입을 가집니다. 스위프트에 있는 다른 타입들과 마찬가지로, 함수의 타입들을 사용할 수 있습니다. 즉 함수를 다른 함수에 파라메터로서 넘겨주거나 함수를 다른 함수에서 반환받을 수 있습니다. 함수들은 유용한 기능 캡슐화를 위해 중첩된 함수안의 범위 내에서 쓰여질수도 있습니다.

*/



/*

함수 정의와 호출

함수를 정의할때 함수의 입력(파라메터)을 하나 이상의 이름이 있고 타입이 정해진 값으로 할 수 있습니다. 또한 값의 타입은 함수의 실행이 끝났을때 함수가 되돌려줄 수 있습니다 (반환 타입). 모든 함수는 함수명을 가지고 있으며, 함수명은 함수가 하는일을 설명해줍니다. 함수를 사용하기위해서 함수를 함수의 이름을 사용하여 "호출"하고 함수의 파라메터 타입들과 일치하는 입력 값들(아규먼트Arguments)을 넘겨줍니다. 함수의 입력값은 함수의 파라메터리스트와 언제나 일치해야합니다. 아래의 함수 예제 이름은 greetingForPerson입니다. 함수가 행하는 일이 바로 그것(사람에게 환영인사Greeting for person)이기 때문입니다. 입력으로 사람의 이름을 받아서 그 사람에 대한 환영 인사를 반환합니다. 이를 달성하기 위해 파라메터를 하나 정의하고 - personName이라는 String 값 - 반환 타입을 String으로 하여 사람에 대한 환영 인사를 하는 것입니다.

*/


func sayHello(personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}
// 문자열을 파라미터로 받아들여 문자여을 리턴하는 함수
// func 함수이름(파라미터목록) -> 리턴type { }


println(sayHello("Anna"))
println(sayHello("Brian"))



func sayHelloAgain(personName: String) -> String {
    return "Helloagain, " + personName + "!"
}
println(sayHelloAgain("Anna"))



// 정수 2개를 받아들이고 정수를 반환하는 함수
func halfOpenRangeLength(start: Int, end: Int) -> Int {
    return end - start
}
println(halfOpenRangeLength(1, 10))


// 파라미터는 없고 문자열을 반환하는 함수
func sayHelloWorld() -> String {
    return "hello, world"
}
println(sayHelloWorld())

// 반환 하는 값이 없는 함수
func sayGoodbye(personName: String) {
    println("Goodbye, ` \(personName)! ")
}
sayGoodbye("Dave")

/*
중요!

엄밀히 말하자면, sayGoodbye 함수는 반환값이 정의되어있지 않아도 여전히 반환값을 가집니다. 반환값이 정의되어있지 않은 함수는 Void타입의 특수값을 반환합니다. ()로 쓰여질수 있는 단순한 빈 튜플(Tuple)이며, 사실상 요소를 갖고있지 않은 튜플입니다.
*/


func printAndCount(stringToPrint: String) -> Int {
    println(stringToPrint)
    return count(stringToPrint)
}
func printWithoutCounting(stringToPrint: String) {
    printAndCount(stringToPrint)
}
printAndCount("hello, world")

printWithoutCounting("hello, world")


// 여러 개의 반환값을반환하는 함수
func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
    var vowels = 0, consonants = 0, others = 0
    for character in string {
        switch String(character).lowercaseString {
        case "a", "e", "i ", "o", "u":
            ++vowels
        case "b", "c", "d", "f", "g", "h", "j", "k", "l ", "m",
        "n", "p", "q", "r", "s", "t", "v", "w ", "x", "y", "z":
            ++consonants
        default:
            ++others
        }
    }
    return (vowels, consonants, others)
}

let total  = count("some arbitrary string! ")
println("\(total.vowels) vowels and \(total.consonants) consonants")



func someFunction(parameterName: Int) {
    // function body goes here, and can use parameterName
    // to refer to the argument value for that parameter
}


func someFunction(externalParameterName localParameterName: Int) {
    // function body goes here, and can use local ParameterName
    // to refer to the argument value for that parameter
}
// 만약 외부 파라메터 이름이 파라메터에 대해 제공된다면, 외부 파라메터 이름은 언제나 함수 호출시에 사용되어야 합니다.

func join(s1: String,  s2: String,  joiner: String) -> String {
    return s1 + joiner + s2
}

join("hello", "world", ", ")
// 함수를 호출할 때 각각의 파라미터가 무엇을 의미하는 지 알기 어렵다.


func join(string s1: String,  toString s2: String,  withJoiner joiner: String)
    -> String {
        return s1 + joiner + s2
}
join(string: "hello",  toString: "world",  withJoiner: ", ")
// 함수 호출만 봐도 각각의 파라미터가 무슨 목적으로 전달하는지 알 수 있다.

/*
중요!
 누군가가 코드를 처음 보았을때 명확하지 않을 수 있다면 외부 파라메터 이름을 쓰는것을 언제나 고려하십시오. 만약 함수가 호출될때 각각의 파라메터들의 목적이 명확하고 모호하지 않다면 외부 파라메터 이름을 정할 필요는 없습니다.
*/


// 단축 외부 파라미터 이름
func containsCharacter(#string: String,  #characterToFind: Character) -> Bool {
    for character in string {
        if character == characterToFind {
            return true
        }
    }
    return false
}

let containsAVee = containsCharacter(string: "aardvark", characterToFind: "v")
/*
만약 함수의 외부 파라메터 이름을 제공하려 할때 이미 해당 파라메터의 내부 이름(local parameter name)이 이미 적절한 이름을 가지고 있다면, 똑같은 이름을 두번 쓸 필요가 없습니다. 대신 파라메터 이름을 한번 쓰고, 이름의 접두어로 해시 심볼(hash symbol) (#)을 붙입니다. 이렇게 함으로서 스위프트는 해당 이름을 외부 파라메터 이름과 지역 파라메터 이름으로 동시에 쓰게 됩니다. 이 예제는 containsCharacter 함수를 정의하고 호출합니다. 해당 함수는 두 입력 파라메터에 #을 붙여서 같은 이름으로 외부 파라메터 이름과 내부 파라메터 이름으로 쓰이게 했습니다.
*/


// 기본 파라미터 값
func join2(string s1: String, toString s2: String)
    -> String {
        return s1 + s2
}

func join2(string s1: String, toString s2: String, withJoiner joiner: String = " ")
    -> String {
        return s1 + joiner + s2
}

join2(string: "hello", toString: "world", withJoiner: "-")

join2(string: "hello", toString: "world")


/*
기본값을 가지는 외부 파라메터 이름

대부분의 경우 외부 파라메터 이름에 기본값을 제공(외부 파라메터이기에 요구되기도 하는)하는 것은 유용하다. 그렇게 함으로써 함수가 호출될때 인수가 파라메터에 대해 가지는 목적이 명확해집니다. 이 과정을 쉽게 하기위해, 외부 이름을 부여하지 않은 파라메터에 대해 스위프트는 자동 외부 이름을 기본값이 정의되어 있는 파라메터에 대해 제공합니다. 자동 외부 이름은 앞서 본 해시 심볼(#)을 사용한 것처럼, 지역 이름과 똑같은 이름이 됩니다. 여기에 joiner 문자열 값에 기본값을 부여하였지만, 파라메터 일체에 외부 파라메터 이름은 주지 않은 버전의 join함수가 있습니다.
*/

func join(s1: String, s2: String, joiner: String = " ") -> String {
    return s1 + joiner + s2
}

// 스위프트는 자동적으로 외부 파라메터 이름을 기본값이 있는 파라메터 joiner에 대해 부여합니다. 그러므로 외부 이름은 반드시 함수가 호출 될 때에 제공되어야 하며, 파라메터의 목적을 명확하고 모호하지 않게 합니다.

join("hello", "world", joiner: "-")



/*
가변 갯수(Variadic) 파라메터

가변 갯수 파라메터는 특정 타입의 값을 0개 이상 받을 수 있습니다. 가변 갯수 파라메터를 사용함으로써 함수 호출시 입력 값들이 임의의 갯수가 될수 있다고 정할 수 있습니다. 파라메터의 타입 이름의 뒤에 마침표 세개(...)를 삽입하는 것으로 가변 갯수 파라메터를 작성할 수 있습니다. 가변 갯수 파라메터로 함수의 내부에 전달된 값들은 적절한 타입의 배열(array)로 만들어집니다. 예를 들어 numbers라는 이름의 가변 갯수 파라메터의 타입이 Double...이라면 함수의 내부에서는 Double[]타입의 numbers 이름을 가진 배열로 만들어집니다. 밑의 예제는 평균이라 불리는 산술 평균(arithmetic mean)을 임의의 갯수를 가진 숫자의 목록에서 구합니다.
*/

func arithmeticMean(numbers: Double...) -> Double {
    var total : Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8, 19)

/*
함수는 최대 한개의 가변 갯수 파라메터를 가질 수 있습니다. 그리고 가변 갯수 파라메터는 언제나 파라메터 목록의 마지막에 배치되어야 합니다. 이렇게 함으로써 복수의 파라메터를 가진 함수를 호출할때 생기는 모호함을 피할 수 있습니다. 만약 함수의 파라메터중 하나 이상의 파라메터가 기본값을 가지고, 그와 동시에 가변 갯수 파라메터를 가진다면 가변 갯수 파라메터는 기본 값을 가지는 파라메터의 맨 마지막에 두어야합니다.
*/



/*
상수(Constant)와 가변(Variable) 파라메터

함수의 파라메터들은 기본적으로 상수들입니다. 함수의 내부에서 파라메터의 값을 바꾸려 시도하는 것은 컴파일 에러를 냅니다. 이렇게 함으로써 실수로 파라메터가 바뀌지 않게 합니다. 하지만 때로는 함수가 파라메터의 값을 복사하여 다양하게 사용하는 것이 유용할때가 있습니다. 새로운 변수(variable)를 정의하지 않고 대신 가변 파라메터를 하나 이상 지정하여 함수 내부에서 사용할 수 있습니다. 가변 파라메터는 상수보다는 변수처럼 사용 가능하며, 함수가 이용하는 파라메터의 변경 가능한 사본을 제공합니다. 가변 파라메터를 정의하려면 파라메터의 이름 앞에 var 키워드를 접두어로 사용합니다.
*/
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - count(string)
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, 10, "-")

/*
이 예제는 alignRight라는 함수를 새로 정의하고 있습니다. 이 함수는 입력 문자열을 오른쪽 가장자리로 정렬하고 더 긴 출력 문자열을 만듭니다. 문자열의 왼쪽에 생긴 공간에는 정해진 채움 문자로 채워집니다. 이 예제에서는 "hello"라는 문자열이 "-----hello"로 변환되었습니다. alignRight함수는 입력 파라메터 string을 가변 파라메터로 정의하고, string이 지역 변수(variable)로서 사용될 수 있는 문자열 값으로 초기화 되며, 함수 내부에서 변경될 수 있습니다. 이 함수는 우측 정렬된 전체 문자열 안에 얼마나 많은 채움 문자가 string의 왼쪽에 들어가야 할지 계산하는 것으로 시작합니다. 이 값은 지역 상수인 amountToPad에 저장됩니다. 그리고 함수는 amountToPad만큼 pad문자를 기존 문자열의 왼쪽에 붙여넣고 그 값을 반환합니다. 이러한 문자열 변경 과정에서 string 가변 파라메터가 사용됩니다.

중요!
가변 파라메터에 생긴 변화는 각각의 함수 호출이 끝난 뒤에는 남아있지 않습니다. 또한 함수의 외부에서는 보이지(visible)않습니다. 가변 파라메터는 함수 호출이 되는 동안만 유지됩니다.
*/



/*
입출력(In-Out)파라메터

위에 설명 된 것과 같이 가변 파라메터는 오직 함수 자신의 내부에서만 변경 될 수 있습니다. 만약 함수가 파라메터의 값을 변경하고 그 변경이 함수 호출이 종료된 후에도 계속되길 원한다면, 파라메터를 입출력 파라메터로 정의하면 됩니다. 입출력파라메터를 정의하기 위해서는 inout 키워드를 파라메터 정의의 시작점에 작성하면 됩니다. 입출력 파라메터의 값은 함수의 안으로 전달 되어, 함수에 의해 변경되고, 함수에서 다시 나와서 원래의 값을 대체합니다. 입출력 파라메터로 넘길 수 있는 값은 인수(argument)뿐입니다. 상수나 문자 값은 입출력 파라메터로 넘겨질 수 없습니다. 상수나 문자값은 변경될 수 없기 때문입니다. 인수를 입출력 파라메터로 넘길때 변수의 이름 바로 앞에 앰퍼샌드(&)를 붙여서 이 파라메터가 함수에 의해 변경될 수 있음을 표시합니다.
*/



func func400(var i:Int){
    i = 400
}

var i400:Int = 300
println(i400)
func400(i400)
println(i400)




















func func50(inout i:Int){
    i = 50
    println(i)
}

var i50:Int = 60
println(i50)
func50(&i50)
println(i50)


func myswap(inout k:Int, inout m:Int){
    var tmp:Int = k
    k = m
    m = tmp
}


var k50:Int = 60
var m50:Int = 100

println(k50)
println(m50)

myswap(&k50, &m50) // 어떻게 myswap을 호출해야 값이 바뀔까?

println(k50)
println(m50)








func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
println("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

/*
중요!
입출력 파라메터는 함수가 값을 반환하는 것이 아닙니다. 위의 swapTwoInts 예제는 반환 타입이나 반환값을 정의하고 있지 않습니다. 하지만 someInt와 anotherInt의 값을 변경하죠. 입출력 파라메터는 함수가 함수 밖의 범위(scope)에 영향을 끼칠 수 있는 또다른 방법입니다.
*/



/*
함수 타입

모든 함수들은 특유의 함수 타입을 가지고 있습니다. 함수 타입은 함수의 파라메터 타입들과 반환 타입으로 구성됩니다. 예를 들면 이렇습니다.
*/


func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, b: Int) -> Int {
    return a * b
}

/*
이 예제는 addTwoInts와 multiplyTwoInts, 두개의 단순한 수학 함수를 정의합니다. 함수들은 각각 두개의 Int값을 취하고 Int값을 계산의 적절한 결과로서 반환합니다. 위 두 함수의 타입은 (Int, Int) -> Int입니다. 이것을 "함수 타입은 Int타입의 파라메터가 두개며 반환값의 타입은 Int다." 라고 말할 수 있습니다. 여기의 또다른 예제는 파라메터나 반환값이 없는 함수입니다.
*/

func printHelloWorld() {
    println("hello, world")
}
/*
이 함수의 타입은 ()->()이며, "함수는 파라메터가 없고 Void를 반환한다."고 할 수 있습니다. 반환값이 정해지지 않은 함수는 언제나 Void를 반환하며, 이는 빈 튜플인 ()로 표시될 수 있습니다.
*/


/*
함수 타입을 사용하기

함수 타입 역시 스위프트의 다른 타입들처럼 사용될 수 있습니다. 예를들어 함수 타입의 상수나 변수를 만들어서 적절한 함수를 할당할 수 있습니다.
*/

var mathFunction: (Int, Int) -> Int = addTwoInts
println("Result: \(mathFunction(2, 3))")


mathFunction = multiplyTwoInts
println("Result: \(mathFunction(2, 3))")


let anotherMathFunction = addTwoInts


/*
파라메터 타입으로서의 함수 타입

(Int, Int) -> Int와 같은 함수 타입을 파라메터 타입으로 함수에 이용할 수 있다. 이로서 함수 구현의 일부를 함수가 호출 될때 함수를 호출하는 쪽에 맡기는 것이 가능하게 된다. 이 예제는 위에서 가져온 수학 함수의 결과를 출력한다.
*/

func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
    println("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)


/*
함수 타입과 반환 타입

함수 타입을 다른 함수의 반환 타입으로 사용할 수 있습니다. 이는 완전한 함수 타입을 반환할 함수 정의의 반환 화살표 (->)바로 뒤에 작성함으로서 할 수 있습니다. 다음 예제는 두개의 간단한 함수인 stepForward와 stepBackward를 정의하고 있습니다. stepForward함수는 입력값보다 1이 더 큰 값을 반환하고 stepBackward함수는 입력 값보다 1이 작은 값을 반환합니다. 두 함수의 타입은 모두 (Int) -> Int입니다.
*/

func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

/*
여기 chooseStepFunction 함수가 있습니다. 이 함수의 반환 타입은 "(Int) -> Int를 반환하는 함수"입니다. chooseStepFunction은 backwards 불리언 파라메터에 따라 stepForward함수와 stepBackward함수중 하나를 반환합니다.
*/


func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

// chooseStepFunction를 이용하여 어느 한쪽 방향으로 나아가는(증가 또는 감소하는) 함수를 얻을 수 있다.
var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)

/*
앞서 한 예제들은 currentValue변수에 따라 점진적으로 0이 되기 위해 필요한 증가나 감소 방향을 산출한다.currentValue의 초기값은 3이며, 이는 곧 currentValue > 0은 true를 반환하게 합니다. 그리고 chooseStepFunction이 stepBackward함수를 반환하게 합니다. 반환된 함수에 대한 참조(reference)는 moveNearerToZero 상수에 저장됩니다. 이제 moveNearerToZero가 올바른 함수를 참조하게 되었기에, 0까지 세는데 이용할 수 있습니다.
*/

println("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    println("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
println("zero!")



/*
중첩된 함수들

여기까지 이 챕터에서 마주친 모든 함수들은 모두 전역 범위(global scope)에 정의된 전역 함수의 예제였습니다. 또한 중첩된 함수라 불리는, 함수 내부에 다른 함수를 정의할 수 있습니다. 중첩 함수는 범위 밖의 세계에서 기본적으로 숨겨져 있습니다. 하지만 감싸고 있는 함수에 의해 여전히 이용될 수 있습니다. 감싸고 있는 함수는 중첩된 함수들을 반환하여 다른 범위에서 함수가 사용될 수 있게 할 수 있습니다. 위 예제의 chooseStepFunction을 다음과 같이 중첩된 함수를 이용하여 재작성 할 수 있습니다.
*/


func chooseStepFunction2(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}
var currentValue2 = -4
let moveNearerToZero2 = chooseStepFunction2(currentValue2 > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue2 != 0 {
    println("\(currentValue2)... ")
    currentValue2 = moveNearerToZero2(currentValue2)
}
println("zero!")






