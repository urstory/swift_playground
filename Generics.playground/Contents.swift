/*

제네릭스 (Generics)


제네릭 코드는 정의된 요구사항에 따라 유연하고 재사용 가능한 함수들을 쓸 수 있도록 해줍니다. 반복을 피하고 의도를 명확하고 추상적으로 나타낼 수 있는 코드를 쓸 수 있습니다.

제네릭스는 Swift의 가장 강력한 기능 중 하나이며, Swift 기본 라이브러리의 많은 부분이 제네릭 코드로 만들어져 있습니다. 눈치채지 못했을 수도 있지만, 사실 제네릭스는 이 Language Guide에 이미 전반적으로 사용되고 있습니다. 예를 들어, Swift의 Array와 Dictionary 타입들은 모두 제네릭 타입입니다. Int 값을 담는 배열이나 String 값을 담는 배열을 만들 수 있습니다. 사실 어떤 타입의 배열든지 만들 수 있습니다. 비슷하게, 특정 형식의 값을 담는 사전(dictionary)도 만들 수 있으며, 선택 가능한 타입에는 어떤 제한도 없습니다.


*/




/*

제네릭이 해결하는 문제 (The Problem That Generics Solve)

*/


func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}


var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
println("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// prints "someInt is now 107, and anotherInt is now 3"


/*

해당 swapTwoInts 함수는 유용하지만, 오직 Int 값만 사용할 수 있습니다. 만약 두 개의 String값이나, 두 개의 Double 값을 바꾸려면 swapTwoStrings이나 swapTwoDoubles같은 함수를 더 작성해야 합니다.

*/


func swapTwoStrings(inout a: String, inout b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(inout a: Double, inout b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}





/*

중요

이 모든 세 함수에서 a와 b의 타입은 서로 같도록 정의되어 있습니다. 만약 a와 b의 타입이 같지 않다면 두 값을 바꾸는 것은 불가능할 것입니다. Swift는 타입-안전 언어이기에 (예를 들어) String 타입의 변수와 Double 타입의 변수를 서로 바꾸도록 지원하지 않습니다. 그런 시도는 컴파일-타임 에러를 생성합니다.

*/




/*

제네릭 함수들 (Generic Functions)

제네릭 함수들은 어떤 타입과도 같이 동작합니다

*/



func swapTwoValues<T>(inout a: T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}


var someInt2 = 3
var anotherInt2 = 107
swapTwoValues(&someInt2, &anotherInt2)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"


/*

중요

위에 정의된 swapTwoValues 함수는 Swift 표준 라이브라리에 있는 제네릭 버전 swap 함수에서 비롯되었습니다. 이 함수는 자동으로 앱 코드에 사용 가능합니다. swapTwoValues의 기능이 필요하다면 스스로 이 기능을 작성하기보다는 Swift에 미리 정의된 swap 함수를 쓰기 바랍니다.

*/




/*

타입 패러미터 (Type Parameters)

위의 swapTwoValues 예시에서 placeholder 타입 T는 타입 패러미터의 한 예시입니다. 타입 패러미터는 함수 이름 바로 뒤에 (<T>같이) 꺽쇠 쌍 안에 있으며, 하나의 placeholder 타입을 지정하고 이름을 붙입니다.

일단 한 번 지정되면, 타입 패러미터는 (swapTwoValues 함수의 a나 b 패러미터들같이) 함수의 패러미터나, 리턴 타입 또는 함수 안에서의 타입 표시(annotation)에 사용될 수 있습니다. 타입 패러미터로 표현된 placeholder 타입은 매번 함수가 호출될 때마다 실제 타입으로 바뀌집니다. (위의 swapTwoValues 예시에서는 처음 함수 호출에서는 T가 Int로, 두번째 호출에서는 String으로 바뀌었습니다.

꺽쇠 안에 쉼표로 구분된 여러개의 타입 패러미터를 써서 하나 이상의 타입 패러미터들을 제공할 수 있습니다.

*/



/*

타입 패러미터 이름짓기 (Naming Type Parameters)

제네릭 함수나 제네릭 타입이 하나의 placeholder 타입(위의 swapTwoValues 제네릭 함수나 Array같이 하나의 타입만 저장하는 제네릭 컬렉션)만 참조하는 간단한 경우, 타입 패러미터 이름에는 전통적으로 단일 문자 T를 사용합니다만, 패러미터 이름으로는 어떤 유효한 식별자든지 사용될 수 있습니다.

여러개의 패러미터를 지닌 좀 더 복잡한 제네릭 함수들이나 제네릭 타입들을 정의한다면, 좀 더 설명적인 타입 이름을 제공하는 것이 더 유용할 것입니다. 예를 들어, Swift의 Dictionary 타입은 각각 키와 값을 위한 두 개의 패러미터들을 갖고 있습니다. 만약 Dictionary을 스스로 작성해야 한다면 해당 타입 패러미터의 목적을 기억히기 쉽게 하기 위해 KeyType와 ValueType같은 이름을 사용하고 싶을 것입니다.

중요

값이 아닌 타입을 위한 placeholder임을 표시하기 위해, 타입 패러미터 이름은 항상 UpperCamelCase로 지정하세요. (예: T, KeyType)


*/



/*

제네릭 타입들 (Generic Types)

Swift는 제네릭 함수는 물론, 제네릭 타입도 제공합니다. 이들은 Array나 Dictionary와 비슷하게 어떤 타입과도 동작하는 사용자-지정 클래스, 구조체, 열거형들입니다.


*/


struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings


let fromTheTop = stackOfStrings.pop()
// fromTheTop is equal to "cuatro", and the stack now contains 3 strings




/*

타입 제약 (Type Constraints)

swapTwoValues 함수와 Stack 타입은 어떤 타입과도 같이 작동합니다. 하지만, 어떨 때는 제네릭 함수와 제네릭 타입에 같이 사용될 수 있는 타입을 제약(type constraint)하는 것이 더 유용합니다. 타입 제약은 타입 패러미터가 특정 클래스에서 상속되어야 한다거나 특정 프로토콜 또는 프로토콜 합성을 만족해야 한다거나 하는 것이 될 수 있습니다.

예를 들어, Swift의 Dictionary 타입은 사전 키로 사용될 수 있는 타입을 제한합니다. Dictionaries에 설명된대로, 사전 키의 타입은 반드시 해시-가능(hashable)해야 합니다. 이는 키가 자신을 유일하게 식별할 수 있는 방식을 제공해야 한다는 뜻입니다. Dictionary에서는 특정 키가 이미 등록되어 있는지 여부를 판별하기 위해 해시-가능한 키가 필요합니다. 이 요구사항이 없다면 Dictionary는 특정 키를 삽입해야 하는지 아니면 교체해야 하는지 여부를 알 수 없으며, 사전에서 특정 키로 값을 찾을 수도 없습니다.

이 요구사항은 Dictionary의 키 타입에 있는 타입 제약으로 강제됩니다. 해당 제약은 키가 반드시 Swift 기본 라이브러리에 정의된 특수 프로토콜인 Hashable 프로토콜을 따라야만 하도록 지정합니다. Swift의 모든 기본 타입들(String, Int, Double또는 Bool)은 기본적으로 해시-가능입니다.

사용자 지정 제네릭 타입을 만들 때, 독자적인 타입 제약을 정의할 수 있고, 이 제약들은 제네릭 프로그래밍의 강력함을 제공합니다. Hashable과 같은 추상 개념은 특정 타입 대신 개념적 특징을 제공합니다.

*/


/*

타입 제약 문법 (Type Constraint Syntax)

타입 제약은 타입 패러미터 목록의 일부로 콜론으로 나눠진 클래스나 프로토콜 제약을 타입 패러미터의 이름 뒤에 써서 만듭니다. 타입 제약의 기본적인 문법은 아래에 나타나 있습니다. (제네릭 타입도 문법이 같습니다):

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
// function body goes here
}
위에 있는 가상의 함수는 두 개의 타입 패러미터를 갖고 있습니다. 첫번째 타입 패러미터 T는 T가 SomeClass의 서브클래스가 되도록 요구합니다. 두번째 패러미터 U는 U가 SomeProtocol 프로토콜을 준수(conform)하도록 요구합니다.

*/


func findStringIndex(array: [String], valueToFind: String) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}



let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    println("The index of llama is \(foundIndex)")
}
// prints "The index of llama is 2"


/*
func findIndex<T>(array: [T], valueToFind: T) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
*/
// 위의 코드에서는 == 부분에서 오류가 발생한다.

func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}


let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
// doubleIndex is an optional Int with no value, because 9.3 is not in the array
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
// stringIndex is an optional Int containing a value of 2






/*


연관 타입 (Associated Types)

프로토콜을 정의할 때, 하나 이상의 연관 타입(associated types)을 정의하는 것이 유용할 때가 있습니다. 연관 타입은 프로토콜의 일부로 사용되는 placeholder 이름(또는 별칭(alias))을 제공합니다. 해당 연관 타입은 프로토콜이 실제로 채용(adopt)될때까지 특정되지 않습니다. 연관 타입은 typealias 키워드로 지정됩니다.

*/


protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}


/*

Container 프로토콜은 모든 컨테이너가 제공해야 하는 세 자기 능력들을 정의합니다.

- append 메서드로 새 아이템을 추가할 수 있어야 한다.
- Int값을 반환하는 count 속성으로 컨테이너에 있는 아이템의 수를 셀 수 있어야 한다.
- Int 인덱스 값을 사용하는 첨자(subscript)로 컨테이너 안의 개별 아이템을 얻을 수 있어야 한다.

*/

struct IntStack2: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack2<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}




/*


연관 타입을 지정하도록 기존 타입을 확장하기 (Extending an Existing Type to Specify an Associated Type)

Adding Protocol Conformance with an Extension에 설명된대로 기존 타입에 특정 프로토콜을 준수(conformance)하도록 추가할 수 있습니다. 이는 연관 타입을 가진 프로토콜도 포함합니다.

Swift의 Array 타입은 이미 append 메서드와 count 속성, 그리고 Int 첨자를 제공합니다. 이 세 가지 능력들(capabilities)은 Container 프로토콜의 요구사항을 만족합니다. 이는 그냥 Array가 Container를 채용(adopt)한다고 선언하는 것만으로도 준수(conform)하게 됨을 의미합니다. 이것은 Declaring Protocol Adoption with an Extension에 설명된대로 빈 확장(extension)을 사용함으로써 가능합니다.

extension Array: Container {}
배열의 기존 append 메서드와 첨자는 Swift가 적절한 ItemType 타입을 추정할 수 있도록 해줍니다. 위에 있는 Stack 타입같이 말이죠. 이 확장을 정의한 후에는 Array를 Container로 사용할 수 있습니다.

*/


extension Array: Container {}


/*

Where절 (Where Clauses)

타입 제약에 설명된 타입 제약은 제네릭 함수나 타입에 사용된 타입 패러미터에 요구사항을 정의하게 해줍니다.

연관 타입에 이런 제약을 정의할 수 있다면 쓸모가 많을겁니다. 이는 타입 패러미터 목록의 일부로 where절(where clauses)을 정의하는 것으로 가능합니다. Where절은 연관 타입이 특정 프로토콜을 준수하거나 해당 특정 타입 패러미터가 연관 타입과 같도록 요구할 수 있게 해줍니다. Where절을 만들기 위해서는, where 키워드를 패러미터 타입 목록 바로 뒤에 쓰고, 하나 이상의 연관 타입 제약을 쓰고, 타입과 연관 타입간의 일치 관계를 하나 이상 쓰면 됩니다.

*/


func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {
        
        // check that both containers contain the same number of items
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // check each pair of items to see if they are equivalent
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // all items match, so return true
        return true
        
}


/*

이 함수는 someContainer와 anotherContainer라 불리는 두 개의 인수를 받습니다. someContainer 인수는 C1의 타입이고, anotherContainer 인수는 C2의 타입입니다. C1과 C2 모두 함수가 호출될때 밝혀질 두 컨테이너 타입을 위한 placeholder 타입 패러미터입니다. 함수의 타입 패러미터 리스트는 두 타입 패러미터 목록에 다음 요구사항들을 추가합니다.

- C1은 반드시 Container 프로토콜을 준수해야 합니다. (예: C1: Container)
- C2도 반드시 Container 프로토콜을 준수해야 합니다. (예: C2: Container)
- C1의 ItemType은 C2의 ItemType과 같아야 합니다. (예: C1.ItemType == C2.ItemType)
- C1의 ItemType은 Equatable 프로토콜을 준수해야 합니다. (예: C1.ItemType: Equatable)

세번째와 네번째 요구사항들은 where절의 일부로 정의되었고, where 키워드 뒤에 함수의 타입 패러미터 목록의 일부로 따라옵니다.

이 요구사항들은:

- someContainer는 C1의 컨테이너 타입입니다.
- anotherContainer는 C2의 컨테이너 타입입니다.
- someContainer와 anotherContainer는 같은 타입의 아이템들을 가집니다.
- someContainer 안에 있는 아이템들은 비등 연산자(!=)를 사용해 서로 다른지 여부를 검사할 수 있습니다.
를 의미합니다. 세번째와 네번째 요구사항의 조합은 anotherContainer의 아이템들 또한 != 연산자로 검사될 수 있음을 의미하는데, 왜냐면 그것들이 someContainer의 아이템 타입과 동일하기 때문입니다.

이 요구사항들은 두 개의 컨테이너 타입이 다른 경우에도 allItemsMatch 함수가 두 컨테이너들을 비교할 수 있게 해줍니다.

*/


var stackOfStrings2 = Stack2<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")

var arrayOfStrings2 = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings2, arrayOfStrings2) {
    println("All items match.")
} else {
    println("Not all items match.")
}
// prints "All items match."


