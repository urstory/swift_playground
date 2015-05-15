/*

클로저(Closures)

클로저는 사용자의 코드 안에서 전달되거나 사용할 수 있는 기능을 포함한 독립적인 블록(block)입니다. Swift에서의 클로저는 C 및 Objective-C 의 blocks와 유사하며, 다른 언어의 람다(lambda)와도 유사합니다. 클로저는 자신이 정의된 컨텍스트 (context) 로부터 임의의 상수 및 변수의 참조(reference) 를 획득 (capture)하고 저장할 수 있습니다. (주: 클로저의 경우 클로저 바로 밖의 scope 의 상수 및 변수에 접근할 수 있다는 이야기입니다) 이렇게 상수 및 변수를 제약하는 특징때문에 클로저라는 이름이 되었습니다. Swift는 획득 과정의 메모리 관리를 모두 제어해줍니다.

*/


/*

함수 에서 소개된 전역 및 중첩 함수들은 사실 클로저의 특수한 경우들입니다. 클로저는 아래의 세가지 중 하나의 형태입니다.

전역 함수는 이름이 있지만 아무 값도 획득하지 않는 클로저입니다.
중첩 함수들은 이름이 있고, 내부의 함수의 값을 획득할 수 있는 클로저입니다.
클로저 표현식은 자신을 둘러싼 컨텍스트에서 값을 획득할 수 있는 가벼운 문법으로 작성된 클로저입니다.
Swift의 클로저 표현식은 일반적인 경우에 대한 간략하고 명확한 구문을 깨끗하고 명확한 스타일로 최적화와 함께 제공합니다. 이러한 최적화는 아래의 항목을 포함합니다.

컨텍스트로부터 인자 및 반환 값을 유추
단일 표현식 클로저로부터 명확한 반환값
단축 인자 이름
클로저 문법 추적

*/


/*
클로저 표현식 (Closure expressions)

중첩 함수에서 소개된 중첩 함수들은 더 큰 함수의 일부로서 동작하는 자체 포함된 코드 블럭을 명명하거나 정의하는 편리한 방법입니다. 그러나, 종종 완전한 선언이나 이름이 없는 더 짧은 버전의 함수같은 구조를 만드는 것이 유용할 때가 있습니다. 이는 다른 함수들을 하나 또는 그 이상의 인자로 받는 함수를 만들때 특히 그렇습니다.

클로저 표현식들은 인라인 클로저를 간단명료하고 집중적인 문법으로 작성하는 방법입니다. 클로저 표현식은 명확성과 의도를 잃지 않는 선에서 가장 간결한 형태로 클로저를 작성하기 위한 몇가지 문법 최적화를 제공합니다. 아래의 클로저 표현식 예에서 sorted 함수를 각 단계마다 동일한 기능을 표현하지만 더 간결해지도록 몇가지 단계를 거쳐 개량하는 최적화를 소개합니다.

*/



/*

정렬 함수

Swift 의 표준 라이브러리는 당신에 제공한 정렬 클로저(sorting closure)의 결과값에 기반하여 알려진 값들의 배열을 정렬하는 sorted 라는 함수를 제공합니다. 정렬 과정이 끝나면, sorted 함수는 원래와 동일한 타입(type) 및 크기를 갖지만 그 요소들은 올바르게 정렬된 새로운 배열을 반환합니다.

*/


let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]


/*

sorted 함수는 두 매개변수를 받습니다.

알려진 타입(type)의 값들로 된 배열
동일한 타입의 두 인자를 받아 첫번째 값이 두번째 값보다 앞에 나와야 할 지의 여부를 알려주는 Bool 값을 돌려주는 클로저. 정렬 클로저는 만약 첫 값이 두번째 값보다 앞에 나와야 할 경우 true를, 나머지 경우에는 false를 반환합니다.

*/

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = sorted(names, backwards)


/*

클로저 표현식 문법 (Closure Expression Syntax)

{ ( parameters ) -> return type in
statements
}


클로저 표현식 문법은 상수 인자, 변수 인자 및 inout 인자를 사용할 수 있습니다. 기본 값은 주어지지 않습니다. 만약 당신이 가변 인자에 이름을 주고 마지막 매개 변수에 위치할 경우 가변 인자도 사용할 수 있습니다. 튜플 또한 인자 타입 및 반환 타입으로 사용할 수 있습니다.
*/


reversed = sorted(names, { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// 위의 backwords메소드를 클로저 표현식으로 변경하였다.

reversed = sorted(names, { (s1: String, s2: String) -> Bool in return s1 > s2 } )

// 한줄로도 표현 가능



/*

컨텍스트로부터 타입 유추하기 (Inferring Type From Context)

정렬 클로저가 함수의 인자로 전달되기 때문에, Swift는 클로저의 인자 타입과 sorted 함수의 두번째 인자의 타입으로부터 반환되는 값의 타입을 유추할 수 있습니다. 이 인자는 (String, String) -> Bool 타입의 함수를 기대합니다. 이는 String, String 및 Bool 타입이 클로저 표현형의 정의의 일부로 쓰일 필요가 없음을 의미합니다. 모든 타입이 유추 가능하기 때문에, 반환 화살표 (->) 와 인자 이름을 감싼 괄호 또한 제외할 수 있습니다.

*/


reversed = sorted(names, { s1, s2 in return s1 > s2 } )

// 쉽게 설명하자면 names는 문자열 배열이기 때문에, 당연히 문자열들을 비교한다고 알고 있다. 그런 이유로 문자열을 유추할 수 있다는 것이다.



/*

단일 표현식 클로저로부터의 암시적 반환 ( Implicit Returns from Single-Expression Closures)

단일 표현식 클로저는 앞의 예에서 정의할 때 return 키워드를 생략하여 단일 표현식의 결과를 암시적으로 반환할 수 있습니다.

*/

reversed = sorted(names, { s1, s2 in s1 > s2 } )

// in 다음에 한줄만 사용할 때 return 이 생략할 수 있다.



/*

단축 인자 이름들 ( Shorthand Argument Names)

Swift는 자동으로 단축 인자 이름을 인라인 클로저에 제공하며, 클로저의 인자들을 $0, $1, $2 등등의 방식으로 참조할 수 있습니다.

만약 이러한 단축 인자 이름들을 클로저 표현식에서 사용할 경우, 클로저 인자 리스트를 클로저의 정의에서 생략할 수 있으며, 단축 인자들의 번호 및 타입은 기대되는 함수 타입으로부터 추정될 것입니다. 클로저 표현식이 클로저 내용에 완전히 표현될 수 있으므로 in 키워드 또한 생략할 수 있습니다:

*/

reversed = sorted(names, { $0 > $1 } )

// 여기서 $0 와 $1 은 클로저의 첫번째와 두번째 String 매개변수를 가리킨다. 말그대로 2개의 파라미터를 받고, 각각의 파라미터는 $0, $1로 표현한다는 것을 의미한다.


/*

연산자 함수들 ( Operator Functions )

사실 위의 클로저 표현식은 더 짧아질 수도 있습니다. Swift 의 String 타입은 String에 특화된 크기 비교 연산자 (>) 를 두 String 인자를 갖는 함수로 정의하고 있으며, Bool 타입을 반환합니다. 이 연산자는 sorted 함수의 두번째 인자를 위해 필요한 함수형과 정확히 일치합니다. 그러므로, 이 크기 비교 연산자를 바로 전달하면 Swift 는 사용자가 String 전용의 구현체를 사용하려고 한다고 유추합니다.

*/

// 앞에서 보면 s1 > s2 와 같은 코드를 보면서 문자열을 크다(>), 작다(<)로 표현할 수 있구나? 신기한 걸 이란 생각을 하는 분이 있을 수도 있을 것 같다.
// JAVA는 연산자 오버라이딩을 지원하지 않기 때문이다.

reversed = sorted(names, > )

// 최종 요약! 이라고 말할 수 있다. names가 문자열 배열이기 때문에 각 원소를 당연히 비교한다고 생각. 스틀링이 가지고 있는 > 를 사용하여 정렬하게 된다.



/*

후행 클로저 ( Trailing Closures )

만약 클로저 표현식을 함수에 함수의 마지막 인자로 전달할 때 클로저 표현식이 긴 경우, 대신에 후행 클로저 (Trailing closure) 를 작성하는 것이 유용할 수 있습니다. 후행 클로저는 함수 호출 괄호의 밖 (또는 뒤) 에 쓰여져서 함수를 지원하는 클로저 표현식입니다.

*/

func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
}
// here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure({
    // closure's body goes here
})

// here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}


/*

중요!
클로저 표현식이 함수의 하나뿐인 인자이며 이 표현식을 후행 클로저로 작성할 경우, 함수를 호출할때 함수 이름의 뒤에 괄호쌍 () 을 쓸 필요는 없습니다.

*/

reversed = sorted(names) { $0 > $1 }
//  reversed = sorted(names, { $0 > $1 } ) 를 후행 클로저로 작성한 내용이다.

/*

Swift의 Array 타입은 클로저 표현식을 하나의 인자로 받는 map 메소드를 제공합니다. 클로저는 행렬 안의 각 아이템마다 한 번씩 호출되고, 그 아이템의 (다른 타입일 수도 있는) 새롭게 매핑된 값을 반환합니다. 매핑의 동작과 반환값의 타입은 클로저에 의하여 지정됩니다.

map 메소드는 제공된 클로저를 각 행렬 항목마다 적용한 후, 새롭게 매핑된 값들이 원래 행렬의 해당 값들의 순서와 같도록 배치된 새 행렬을 반환합니다.
*/


let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}



/*
중요!
digitNames 사전의 첨자 (subscript) (주: 적당한 표현이 없어서 의미적으로 가까운 '첨자'로 번역)에 접근할 때 느낌표 (!) 가 붙는데, 이 이유는 사전의 첨자 반환값은 사전 안에 해당되는 키값이 없어서 열람이 실패했을 경우 반환하는 선택적인 값이 있기 때문입니다. 위의 예에서, number % 10 은 digitNames 사전을 위해 언제나 유효한 첨자 키값을 제공하는 것이 보장되어 있으므로, 느낌표는 첨자의 선택적인 반환 값에 보관된 값을 강제로 풀어 String 값을 알기 위해 사용합니다.
*/

var dic1 = [0:"hello", 1:"world", 2:"!!!"]

println(dic1[0]); // 느낌표가 없으면 Optional("hello")
println(dic1[0]!); // "hello"

// 느낌표를 붙이지 않으면 Optional 한 문자열이 반환된다. 만약 3에 해당하는 값을 달라고 하면 어떻게 될까?
println(dic1[3]);  // 값이 없기 때문에 nil이 출력된다.
//println(dic1[3]!); // ! 를 붙였다는 것은 값이 반드시 출력된다는 것을 보장하겠다는 의미이다. 보장할 수 있는가? 이 줄은 실행시 오류가 발생한다.


// 아래의 코드는 후행 클로저를 사용하지 않은 예제이다. 어떤 부분에 차이가 있는가?
let strings3 = numbers.map ({
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
})



// 문제!
// 위의 코드를 클로저를 사용하지 않고 표현한다면 어떻게 표현해야 할까?

func convert(var number:Int) -> String {
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

let strings2 = numbers.map(convert);

func printTotal(totalfunc:(start:Int, end:Int)->Int){
    var total:Int = totalfunc(start:1,end:100)
    println(total)
}

func total(start:Int, end:Int) -> Int{
    var total:Int = 0
    for i in start...end {
        total = total + i
    }
    return total
}

printTotal(total)

// 후행 클로저
// 클로저
printTotal({(start:Int, end:Int) -> Int in
    var total:Int = 0
    for i in start...end {
        total = total + i
    }
    return total
    })

printTotal({(start, end) in
    var total:Int = 0
    for i in start...end {
        total = total + i
    }
    return total
})

printTotal {(start, end) in
    var total:Int = 0
    for i in start...end {
        total = total + i
    }
    return total
}

/*

값 획득하기 (Capturing Values)

클로저는 자신이 정의된 주변 컨텍스트로부터 상수 및 변수의 값을 획득할 수 있습니다. 클로저는 이러한 상수와 변수들을 원래 상수와 변수들이 정의된 범위 (scope) 가 더이상 존재하지 않는 경우에조차도 값을 참조하거나 수정할 수 있습니다.

Swift에서 클로저의 가장 간단한 형태는 다른 함수의 본문 안에 작성된 중첩 함수입니다. 중첩 함수는 바깥 함수의 모든 인자를 획득할 수 있으며, 또한 바깥 함수 내에서 정의된 모든 상수 및 변수를 획득할 수 있습니다.

*/

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
let value3 = incrementByTen() // 10
let value4 = incrementByTen() // 20
let value5 = incrementByTen() // 30
let incrementByTen2 = makeIncrementer(forIncrement: 10)
let value6 = incrementByTen2()

// 위의 코드를 보면 좀 해깔릴 수 있을 것 같다. makeIncrementor(forIncrement amount: Int) 이 반환하는 값이 () -> Int 라는 것을 의미한다.
// 맨 아래의 return incrementor 는 함수를 반환하고 있다. 해당 함수는 파라미터가 없고 반환되는 값은 정수인 함수를 말한다.
// incrementor() 함수 안에서 함수 밖의 선언된 runningTotal을 사용하고 있다.
// incrementer() 함수는 밖에서 사용할 때도 계속하여 runningTotal을 유지하게 된다.
// makeIncrementer메소드가 종료되고 나서도 해당 메소드 안의 지역변수로 선언된 runningTotal이 제거되지 않습니다.

/*

incrementor 함수는 아무 인자도 갖고 있지 않으며, runningTotal 및 amount 를 함수 내에서 참조합니다. 이 함수는 자신을 둘러싼 함수로부터 runningTotal 및 amount를 획득하고 함수 안에서 그 값들을 사용합니다.

이 함수는 amount 값을 수정하지 않기 때문에, incrementor는 amount 안에 보관된 값을 획득하고 그 복사판을 보관합니다. 이 값은 새로운 incrementor 함수에서도 계속 이어져 보관됩니다.

그러나, 이 함수가 runningTotal 변수를 호출시마다 변경하기 때문에, incrementor는 현재 runningTotal의 복사본 대신 값의 참조를 획득합니다. 참조 획득은 runningTotal 이 makeIncrementor 가 끝난 이후에도 사라지지 않음을 보증하며, incrementor 함수가 이후 호출될 때도 연속적으로 사용될 수 있음을 보증합니다.

*/

/*
중요!
 Swift는 어떤 변수가 참조 로 획득되고 어떤 변수가 복사값으로 획득될지 판단합니다. 사용자는 amount 및 runningTotal 이 incrementor 중첩 함수에서 쓰일지의 여부를 명기할 필요가 없습니다. Swift는 또한 runningTotal 이 더이상 incrementor 함수로부터 필요로하지 않을 때 폐기하는 모든 메모리 관리 과정을 담당합니다.
*/





/*

클로저는 참조 타입 (Closures Are Reference Types)

위의 예에서, incrementBySeven 및 incrementByTen은 상수입니다. 그러나 클로저로써 이러한 상수들은 여전히 그들이 획득한 runningTotal 변수를 증가시킬 수 있습니다. 이는 함수와 클로저가 참조 타입이기 때문입니다.

함수나 클로저를 상수에 할당하는 것은, 실제로는 그 상수에 함수나 클로저를 가리키는 참조를 할당하는 것입니다. 위의 예에서, incrementByTen이 참조하는 것은 클로저를 가리키는 상수이며, 클로저 그 자체의 내용은 아닙니다.

이는 또한 클로저를 두 개의 다른 상수나 변수에 할당하면, 두 상수나 변수들이 동일한 클로저를 참조하게 되는 것을 의미합니다.

*/
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() // 40 이 된다



