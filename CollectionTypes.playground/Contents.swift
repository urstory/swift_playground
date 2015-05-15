println("Hello, world")

// JAVA언어의 경우 프로그램이 시작되기 위해서는 public static void main(String args[])와 같은 메소드(프로그램 시작점)이 있어야 한다.
// 그런데 놀랍게도 Swift는 위의 한 문장이 완전한 하나의 프로그램이다. 전역 범위(Global Scope)에 해당하는 코드는 진입점으로 사용될 수 있다.
// JAVA와 다른 점은 뒤에 쎄미콜론(;)이 붙지 않는다는 것이다.



// 변수와 상수의 선언

var myVariable = 42
myVariable = 50
let myConstant = 42

// 변수를 선언할 때는 var를 사용하고 상수를 선언할 경우에는 let을 사용한다.
// JAVA언어와 다른 점은 변수의 type을 선언하지 않았다는 것이다. 변수의 type을 선언할 수도 있다. 만약 변수를 선언하지 않았다면 설정한 값의 type을 추정하게 된다. 즉 mVariable은 정수로 선언된다.

// myConstant = 50;

// 위의 줄은 오류가 발생한다. 왜 오류가 발생하겠는가? 상수는 한 번 값을 대입하면 값을 수정할 수 없기 때문이다.


let inplicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double  = 70


// 위의 첫 번째, 두 번째 줄은 값이 정수와 실수이다. 컴파일러는 inplicitInteger 변수는 정수로 implicitDouble 는 실수로 추정하게 될 것이다. 3번째 줄은 값만 보면 정수이다. 하지만, explicitDouble 변수를 실수로 정의하고 싶다면? 변수면 뒤에 콜론(:)을 적어주고 콜론 뒤에 type을 적어주면 된다.


// 연습
// 명시적으로 Float 타입인 상수를 만들고 4라는 값을 할당해보자.


let label = "The width is "
let width = 94
//let widthLabel = label + width

// 위의 3줄의 코드가 실행되면 3번째 줄에서 오류가 발생한다. JAVA의 경우 문자열과 정수를 + 연산자로 붙일 수 있었다.
// Swift는 결론부터 말하자면 안된다.
// width는 정수형 변수 이기 때문에 문자열과 문자열을 + 연산자로 연결하려면 width를 문자열 형태로 변환시켜야 한다.

let widthLabel = label + String(width)

// 그런데 좀 불편하다. 숫자를 문자열로? 바꿔서 더해야 하다니 Java언어 사용자라면 왠지 Java언어가 그리워질지도 모르겠다.

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

// 위의 코드를 살펴보면 \(변수) 와 같은 형식으로 문자열에 넣어줌으로써 쉽게 변수의 값을 문자열에 어울리게 출력할 수 있다.

// 연습
// 본인의 이름과 나이를 변수로 선언하고 \(변수) 를 이용하여 출력되도록 코드를 작성하시오


// 배열과 딕셔너리
// 배열과 딕셔너리를 선언하는 방법은 다음과 같다.

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"


var occupations = [
    "Malcolm":"Captain",
    "Kaylee":"Mechanic",
]
occupations["Jayne"] = "Public Relations"
//[Kaylee: Mechanic, Jayne: Public Relations, Malcolm: Captain]


println(occupations)

// 위의 코드를 보면 알겠지만 대괄호 [] 를 이용하면 배열을 선언할 수 있다.
// key와 value로 이뤄진 딕셔너리도 선언할 수 있다.

// 만약 빈 배열을 선언한다면 어떻게 해야 할까?

var myArray = [String]()
var myDictionary = Dictionary<String, Float>()

// 빈 배열이나 딕셔너리를 선언하려면 이니셜라이저(initializer)를 사용해야 한다.

// 배열의 길이를 출력하려면 어떻게 해야할까?
println("배열의 길이: \(myArray.count)")


myArray.append("kim")
println("배열의 길이: \(myArray.count)")

var intArray = [Int]()
for i in 0..<45 {
    intArray.append(i+1)
}


// 배열도 객체이다. 배열에 저장된 개수는 count속성으로 알 수가 있고, 새로운 요소를 추가하려면 append메소드를 이용하여 추가할 수 있다.

// 질문. myArray는 무슨 type의 배열인가? 문자열 type을 저장할 수 있는 배열이라는 것을 알 수 있다.
// 그렇다면 아래의 코드가 뜻하는 것은 무엇일까?

myArray = []

//var myArray2 = []

// myArray는 이미 문자열type의 배열인 것을 컴파일러는 알고 있다. 이경우 새롭게 초기화 하기 위하여 [] 를 사용할 수 있다.
// 딕셔너리의 경우에는 [:]를 사용하면 된다.
// var myArray2 = [] 는 오류가 난다. 왜 그럴까?


var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]

// 위의 코드는 count가 3인 배열을 선언하는데 0.0으로 반복하면서 초기화 하라는 것을 의미한다.

// 연습
// "hello"문자열을 가지는 5개 짜리 배열을 선언하시오.
// var stringArray = [String](count: 5, repeatedValue: "hello")


if myArray.isEmpty {
    println("The myArray is empty.")
} else {
    println("The myArray is not empty.")
}

//myArray가 가지고 있는 isEmpty를이용하면 비어있을 경우 참이 반환된다.

//연습
// 위의 코드에서 "The myArray is not empty." 가 출력되도록 하려면 어디를 수정해야 할까?

myArray += ["world"]

// myArray에 새로운 원소를 추가할 때 append메소드를 이용하지 않고 + 연산자를 이용해도 된다.

//추측
shoppingList.insert("Maple Syrup", atIndex: 0)

// 위의 모드는 무엇을 하는 코드인가? 숫자 0을 바꿔보도록 하자.

let mapleSyrup = shoppingList.removeAtIndex(0)

// shoppingList를 출력하면 어떤 결과가 나올까?

println(shoppingList)

// 연습
// 그냥 0번째 것을 출력하려면 어떻게 해야할까?

let element0 = shoppingList[0]
println(element0)

var elementCount = shoppingList.count;
elementCount--
let elementLast = shoppingList.removeAtIndex(elementCount)
println(elementLast)

// 연습
// 마지막 요소를 삭제하고 가지고 오시오.






for item in shoppingList {
    println(item)
}

// 배열의 모든 값을 출력

for (index, value) in enumerate(shoppingList) {
    println("Item \(index): \(value)")
}

// 배열의 인덱스와 값을 함께 출력



// 중복된 값을 허용하지 않는 Set의 선언
var letters = Set<Character>()

// Set역시 저장된 수를 다음과 같이 출력할 수 있다.
println("letters is of type Set<Character> with \(letters.count) items.")

letters.insert("a")

letters = []

// 위의 코드는 한건의 요소를 추가하고, 빈 Set으로 초기화하는 것이다.

letters.insert("a")
letters.insert("a")

// 위의 두줄이 실행되었어도 letters에는 "a"만 저장되어 있는 것을 확인할 수 있다.

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

// Set형태로 선언과 동시에 초기화 하기

var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop"]

// type추정을 이용하여 초기화 하기


if favoriteGenres.isEmpty {
    println("As far as music goes, I'm not picky.")
} else {
    println("I have particular music preferences.")
}

favoriteGenres.insert("Jazz")

if true {
    println("it's ok")
}

let letValue1 = "hello";
let letValue2 = "hello";


if letValue1 == letValue2 {
    println(" I'm over it.")
} else {
    println("I never much cared for that.")
}


//if favoriteGenres.remove("Rock") == "Rock" {
//    println(" I'm over it.")
//} else {
//    println("I never much cared for that.")
//}


if let removedGenre = favoriteGenres.remove("Rock") {
    println("\(removedGenre)? I'm over it.")
} else {
    println("I never much cared for that.")
}
// remve메소드는 "Rock"이라는 값이 있으면 삭제한 후 "Rock"을 반환한다.
// 만약 "Rock"이라는 값이 없다면 nil 으 반환한다.


if favoriteGenres.contains("Funk") {
    println("I get up on the good foot.")
} else {
    println("It's too funky in here.")
}
// contains메소드는 값이 있는지를 확인한다.


let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

sorted(oddDigits.union(evenDigits))  // 합집합
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
sorted(oddDigits.intersect(evenDigits))  // 교집합
// []
sorted(oddDigits.subtract(singleDigitPrimeNumbers)) // 차집합
// [1, 9]
sorted(oddDigits.exclusiveOr(singleDigitPrimeNumbers)) // 상호배타적. 합집합 - 교집합 [1,2,3,5,7,9] - [3,5,7] = [1,2,9]
// [1, 2, 9]


let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubsetOf(farmAnimals) // houseAnimals는 farmAnimals에 모두 포함되어 있느냐?
farmAnimals.isSupersetOf(houseAnimals) // houseAnimals는 houseAnimals를 모두 포함하고 있느냐?
farmAnimals.isDisjointWith(cityAnimals) // farmAnimals에 cityAnimals가 포함된 것이 없는가?

// 연습
// 위의 3문장이 모두 true가 반환되도록 하려면 어떻게 해야하는가?


// 비어 있는 딕셔너리 선언
var namesOfIntegers = [Int: String]()

namesOfIntegers[16] = "sixteen"

namesOfIntegers = [:]


// 딕셔너리를 선언과 동시에 초기화 한다.

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// type추정을 이용하여 아래와 같이 선언할 수 있다.
var airports2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// 딕셔너리에 저장된 요소 개수 출력
println("The airports dictionary contains \(airports.count) items.")


if airports.isEmpty {
    println("The airports dictionary is empty.")
} else {
    println("The airports dictionary is not empty.")
}

airports["LHR"] = "London"

airports["LHR"] = "London Heathrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    println("The old value for DUB was \(oldValue).")
}
// "DUB"를 키로 가지는 값을 반환한 후, 원래 값을 "Dublin Airport"로 수정을 한다.

if let airportName = airports["DUB"] {
    println("The name of the airport is \(airportName).")
} else {
    println("That airport is not in the airports dictionary.")
}

airports["APL"] = "Apple International"
airports["APL"] = nil

if let removedValue = airports.removeValueForKey("DUB") {
    println("The removed airport's name is \(removedValue).")
} else {
    println("The airports dictionary does not contain a value for DUB.")
}


for (airportCode, airportName) in airports {
    println("\(airportCode): \(airportName)")
}
// 딕셔너리의 모든 키와 값을 출력한다.

for airportCode in airports.keys {
    println("Airport code: \(airportCode)")
}
// 딕셔너리의 모든 키들을 출력한다.

for airportName in airports.values {
    println("Airport name: \(airportName)")
}
// 딕셔너리의 모든 값들만 출력한다.

let airportCodes = [String](airports.keys)

let airportNames = [String](airports.values)

// 딕셔너리의 키와 값들을 별도의 변수에 저장한다.

// airports에 새로운 값을 저장하였다. 그렇다면 airportCodes는 어떻게 될까? 같은 레퍼런스일까? 같은 값일까?
// 아래의 코드를 직접 입력해보라.
airports["KR"] = "인천공항" // 값을 추가
println(airportCodes.count)
println(airports.count)


var array10 = [1,2,3,4,5]

println(array10)

var array11 = array10

println(array11)

array10.append(6)

println(array11)


// 배열 참고 : https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html









