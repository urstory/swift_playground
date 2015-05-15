/*

자동 참조 계수 (Automatic Reference Counting)


스위프트는 앱의 메모리 사용량을 추척, 관리하기 위해 자동 참조 계수(ARC)를 사용합니다. 대부분의 경우, 이러한 메모리 관리는 스위프트에서 "그냥 잘 작동합니다". 개발자가 메모리 관리에 대해서 생각할 필요가 없다는 것이죠. ARC는 인스턴스가 더이상 필요가 없을때 해당 클래스 인스턴스가 쓰는 메모리를 자동으로 해제합니다. 하지만 때때로 ARC는 메모리 관리를 하기 위해서 코드 부분들간의 관계 정보를 알아야 할 때가 있습니다. 이번 장은 그러한 상황을 설명하고, 어떻게 ARC가 앱의 메모리 관리를 가능하게 하는지 보여줍니다.

중요!


참조 계수는 오직 클래스의 인스턴스에만 적용됩니다. 구조체와 열거형은 값(Value) 타입이며, 참조 타입이 아닙니다. 또한 참조형태로 저장되거나 전달되지 않습니다.

*/


/*

ARC는 어떻게 작동하는가

클래스의 새 인스턴스를 만들때마다 인스턴스에 대한 정보를 저장하기 위해 ARC는 메모리 덩어리들을 할당합니다. 이 메모리는 인스턴스 타입에 관련된 정보와, 인스턴스와 관련된 저장 속성의 값들을 저장합니다. 그리고 ARC는 더이상 필요하지 않은 인스턴스의 메모리 할당을 해제하여 메모리가 다른 목적으로 이용될 수 있게 합니다. 이로써 클래스 인스턴스가 필요하지 않은 메모리를 차지하고 있는 것을 방지합니다. 하지만 만약 사용중인 인스턴스를 ARC가 할당 해제하면, 해당 인스턴스의 속성에 접근하거나 메소드를 호출하는 것은 불가능해집니다. 사실, 만약 그 인스턴스에 접근하려하면 앱은 크러시(Crash)가 날것입니다. 사용되고 있는 인스턴스가 사라지지 않게 하기 위해 ARC는 얼마나 많은 속성, 상수, 변수들이 각각의 클래스 인스턴스들을 참조하는지 추적합니다. 최소한 하나의 활성화 참조가 있는 이상, ARC는 해당 인스턴스의 할당을 해제하지 않습니다. 이를 가능하게 하기위해, 클래스 인스턴스를 속성, 상수, 변수에 할당할때 해당 속성, 상수, 변수는 해당 인스턴스에 강한 참조(Strong reference)를 합니다. 이 참조는 "강한" 참조라 불리는데, 해당 인스턴스를 강력하게 유지하기 때문입니다. 그리고 이 강한 참조가 남아있는 이상 해당 인스턴스의 할당 해제는 허용되지 않습니다.

*/

class Person {
    let name: String
    init(name: String) {
        self.name = name
        println("\(name) is being initialized")
    }
    deinit {
        println("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
// prints "John Appleseed is being initialized"

/*

"John Appleseed is being initialized"라는 메시지가 Person 클래스의 이니셜라이져가 호출될 때 출력된다는 점에 주의합니다. 이것으로 초기화가 제대로 됐음을 확인할 수 있습니다. reference1 변수에 Person의 새 인스턴스가 할당 되었기 때문에, reference1과 Person 인스턴스 사이에 강한 참조가 생깁니다. 그리고 최소한 하나의 강한 참조가 있어서 ARC는 Person이 메모리에 유지되는 것과, 할당 해제 되지 않음을 확인 합니다. 만약 같은 Person 인스턴스를 두개 변수에 더 할당하면, 두개의 강한 참조가 더 생깁니다.
*/


reference2 = reference1
reference3 = reference1

/*

이제 하나의 Person 인스턴스에 대한 강한 참조는 3개입니다. 원래의 참조를 포함한 변수들 중에 nil을 2개 할당함으로써 2개의 강한 참조를 부순다면, 하나의 강한 참조가 남게 되며, 여전히 Person 인스턴스는 할당해제 되지 않습니다.

*/

reference1 = nil
reference2 = nil

/*
세번째 강한 참조가 사라져 명확하게 Person 인스턴스가 더 이상 사용되지 않기 전까지 ARC는 Person 인스턴스를 할당 해제 하지 않습니다.
*/

reference3 = nil
// prints "John Appleseed is being deinitialized"

/*

클래스 인스턴스간의 강한 참조 순환

위 예제에서 ARC는 생성된 Person 인스턴스의 참조 갯수를 추적하고 해당 Person 인스턴스가 더이상 필요하지 않을때 할당 해제를 합니다. 하지만 절대로 강한 참조의 갯수가 0으로 떨어지지 않게 코드를 작성하는 것이 가능합니다. 두개의 클래스 인스턴스가 서로를 강하게 잡고 있을때 그 현상이 발생합니다. 인스턴스 서로가 서로를 살게끔 유지하는 것이죠. 이를 강한 참조 순환(strong referecne cycle)이라고 합니다. 강한 참조 순환을 풀려면 클래스간의 관계를 강한 참조 대신 약한(weak) 참조나 미소유 참조(unowned references)로 대체해야 합니다. 이 과정은 Resolving Strong Reference Cycles 에 설명이 되어있습니다. 하지만 강한 참조 순환을 푸는걸 배우기 전에, 어떻게 순환이 생기는지 이해하는것이 좋습니다. 이 예제는 강한 참조 순환이 어떻게 의도치 않게 생기는지 보여줍니다. 이 예제는 아파트 블록과 거기에 사는 사람을 모델링하는 Person과 Apartment 두개의 클래스를 정의합니다.

*/

class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { println("\(name) is being deinitialized") }
}

class Apartment {
    let number: Int
    init(number: Int) { self.number = number }
    var tenant: Person2?
    deinit { println("Apartment #\(number) is being deinitialized") }
}

/*

모든 Person 인스턴스는 String타입의 name 속성을 가지고 있고, 추가적으로 apartment 속성을 최초에 nil 값이 할당된 채로 가집니다. apartment 속성은 옵셔널입니다. 어떤 사람은 아파트에 살지 않을 수도 있기 때문입니다. 비슷하게, 모든 Apartment 인스턴스는 Int 타입의 number 속성을 가지고 있고, 추가적으로 최초에 nil이 할당된 tenant 속성을 가지고 있습니다. tenant 속성은 옵셔널입니다. 어떤 아파트는 사람이 살지 않을 수도 있기 때문입니다. 두 클래스 전부 디이니셜라이저를 정의하여 클래스 인스턴스가 디이니셜라이(역주: 혹은 할당 해제) 된다는 사실을 출력하고있습니다. 이로 인해 Person과 Apartment 인스턴스가 기대한대로 할당 해제가 되는걸 볼 수 있습니다. 다음 코드 조각은 john과 number73이라는 변수를 정의하고 있습니다. 이 변수들에 밑의 Apartment와 Person 인스턴스를 설정할겁니다. 두 변수는 옵셔널이기에 초기값으로 nil을 가집니다.
*/

var john: Person2?
var number73: Apartment?

// 이제 Person과 Apartment의 인스턴스를 생성해서 john과 number73 변수에 할당 할 수 있습니다.


john = Person2(name: "John Appleseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

john = nil
number73 = nil

/*
Person과 Apartment간의 강한 참조는 여전히 남아있으며, 깨어질 수 없게 되었습니다.
*/



/*

클래스 인스턴스간의 강한 참조 순환 해결하기

스위프트는 약한 참조와 미소유 참조라는 2가지 방법 제공하여 클래스 속성에서 일어나는 강한 참조 순환을 해결할 수 있게합니다. 약한 참조나 미소유 참조는 참조 순환의 안에 있는 인스턴스가 다른 인스턴스에 대해 강한 참조를 유지할 필요 없이 참조할 수 있게 합니다. 인스턴스는 서로를 강한 참조 없이 참조 할 수 있게 됩니다. 약한 참조는 해당 참조가 살아있는 동안 잠시라도 nil이 될때 사용하게 됩니다. 그와 반대로 미소유 참조는 참조가 초기화 과정 중 설정 되고 이후에 절대로 nil이 되지 않음을 알고 있을 때 사용합니다.

*/


/*

약한 참조

약한 참조는 인스턴스가 다른 인스턴스를 참조하는데 강하게 유지하지 않는 참조이며, 그렇기에 ARC가 참조된 인스턴스를 버리는 것을 멈추게 하지 않습니다. 이로 인해 참조가 강한 참조 순환의 일부가 되는 것을 방지합니다. weak 키워드를 선언의 앞에 위치시키는 것으로 속성이나 변수 선언이 약한 참조라고 알릴 수 있습니다. 약한 참조는 참조가 어느 순간 "값 없음"을 참조하게 될때 사용되어 참조 순환을 피하는데 이용 됩니다. 만약 참조가 언제나 값을 가진다면 미소유 참조에 설명된 것처럼 미소유 참조를 대신 사용하면 됩니다. 위의 Apartment 예제에서는 아파트가 "거주자 없음" 상태를 가지는 것이 자연스럽기에 약한 참조를 사용하여 참조 순환을 부술 수 있습니다.

중요@

약한 참조는 실행 시간중에 값이 바뀔 수 있기 때문에 반드시 변수로서 선언되어야 합니다. 약한 참조는 상수로 선언될 수 없습니다.
약한 참조는 "값 없음"을 가지는게 허용되기에, 약한 참조는 언제나 옵셔널 타입으로 선언되어야 합니다. 옵셔널 타입은 스위프트에서 "값 없음"을 표현하는데 선호되는 방식입니다. 약한 참조는 인스턴스를 강하게 참조 하고 있지 않기 때문에 약한 참조를 통해 참조를 하고 있는 동안 할당 해제가 될 가능성이 있습니다. 때문에 ARC는 약한 참조가 참조하고 있던 인스턴스가 할당 해제 되면 참조를 자동으로 nil로 설정합니다. 다른 옵셔널 값들처럼, 약한 참조의 값이 존재하는지를 체크할 수 있습니다. 그렇기 때문에 존재하지 않는 잘못된 인스턴스를 참조하는 일은 일어나지 않습니다. (역주: 아예 nil을 참조하는 것과, 있어야 할 자리에 엉뚱한게 있는 것을 참조 하는 것이 다르기에 위의 문장이 나온듯 싶습니다. C에서 포인터를 이용해 강제로 다른 부분을 읽는 것을 생각하면 될것 같습니다.) 밑의 예제는 위의 예제와 똑같지만 중요한 한가지가 다른 Person과 Apartment입니다. 이번에는 Apartment 타입의 tenant 속성이 약한 참조로 선언되어 있습니다.

*/


class Person3 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment3?
    deinit { println("\(name) is being deinitialized") }
}

class Apartment3 {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: Person3?
    deinit { println("Apartment #\(number) is being deinitialized") }
}

var john3: Person3?
var number733: Apartment3?

john3 = Person3(name: "John Appleseed")
number733 = Apartment3(number: 73)

john3!.apartment = number733
number733!.tenant = john3

john3 = nil
// prints "John Appleseed is being deinitialized"

number733 = nil
// prints "Apartment #73 is being deinitialized"



/*

미소유 참조

약한 참조처럼 미소유 참조 또한 인스턴스에 대한 참조를 강하게 하지 않습니다. 약한 참조와는 다르게, 미소유 참조는 언제나 값을 가지고 있다고 간주합니다. 이 때문에 미소유 참조는 옵셔널 타입이 아닙니다(non-optional). 미소유 참조는 unowned 키워드를 속성이나 변수 선언 앞에 위치 시킴으로써 할 수 있습니다. 미소유 참조는 옵셔널이 아니기 때문에 미소유 참조를 쓸 때마다 드러내야 할 필요가 없습니다. 미소유 참조는 언제나 직접 접근이 가능합니다. 하지만 ARC가 인스턴스의 참조를 할당 해제 할 때 nil로 설정 할 수는 없습니다. 옵셔널이 아닌 타입은 nil로 설정 될 수 없기 때문입니다.

중요!

    만약 미소유 참조가 참조하는 인스턴스가 할당 해제된 후에 접근하려 한다면 런타임 에러를 발생 시킬것입니다. 미소유 참조는 언제나 인스턴스를 참조하는 게 확실할 때에만 사용해야 합니다. 스위프트는 미소유 참조가 할당 해제된 인스턴스에 접근하려 할때 언제나 크래시를 낸다는 것에 주의하십시오. 앱은 언제나 안정적으로 크래시할 것입니다. 물론, 당연히 그런 일이 일어나지 않게 해야할테지만 말이죠.

*/
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { println("\(name) is being deinitialized") }
}

class CreditCard {
    let number: Int
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { println("Card #\(number) is being deinitialized") }
}

var john4: Customer?

john4 = Customer(name: "John Appleseed")
john4!.card = CreditCard(number: 1234_5678_9012_3456, customer: john4!)

john4 = nil
// prints "John Appleseed is being deinitialized"
// prints "Card #1234567890123456 is being deinitialized"



/*

클로저를 위한 강한 참조 순환

위에서 어떻게 두 클래스 인스턴스의 속성들이 서로 강한 참조를 하면서 강한 참조 순환을 만드는지 보았습니다. 또한 약한 참조와 미소유 참조를 이용해 어떻게 강한 참조 순환을 부수는지도 보았습니다. 클로저를 클래스 인스턴스의 속성에 할당할때도 강한 참조 순환이 발생할 수 있습니다. 해당 클로저의 몸체는 인스턴스를 획득(capture)합니다. 이 획득은 클로저의 몸체가 self.someProperty와 같은인스턴스의 속성에 접근하려 할 때 발생합니다. 혹은 클로저가 self.someMethod()와 같은 인스턴스의 메소드를 호출 할 때도 발생합니다. 어느 경우든간에 그러한 접근에서 클로저는 self를 획득하게 되며, 강한 참조 순환을 만들어냅니다. 이 강한 참조 순환은 클로저가 클래스와 같이 참조 타입 이기 떄문에 일어납니다. 클로저를 속성에 할당하면, 참조를 클로저에 할당하는 것이 됩니다. 본질적으로, 이는 위에서 말한 문제와 같은 문제입니다. 두개의 강한 참조가 서로를 살아있게 만듭니다. 하지만 이번엔 두개의 클래스 인스턴스가 아니라, 하나의 클래스 인스턴스와 클로저가 서로를 살아있게 합니다. 스위프트는 이 문제에 대해 클로저 획득 목록이라는 우아한 방법을 제공합니다. 하지만 클로저 획득 목록을 이용하여 강한 참조 순환을 부수는 방법을 배우기 전에, 어떻게 순환이 야기되는지 이해하는 것이 좋습니다.
*/

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        println("\(name) is being deinitialized")
    }
    
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
println(paragraph!.asHTML())
// prints "<p>hello, world</p>"

paragraph = nil

// HTMLElement의 디이니셜라이저가 아무런 메시지도 출력하지 않았음에 주의하세요. 이는 곧 HTMLElement 인스턴스가 할당 해제 되지 않았음을 의미합니다.


/*

클로저의 강한 참조 순환 해결하기.

클로저와 클래스의 강한 참조 순환은 클로저 정의의 일부로서 획득 목록을 정의하는 것으로 해결 할 수 있습니다. 획득 목록은 하나 이상의 참조 타입이 클로저의 몸체에 있을때 사용할 규칙을 정의합니다. 두 클래스 인스턴스 간의 강한 참조 순환 처럼, 획득한 참조를 강한 참조대신 약한 참조나 미소유 참조로 선언할 수 있습니다. 약한 참조나 미소유 참조중 어느 것이 더 적절한지는 코드의 다른 부분에 따라 다릅니다.

중요!

스위프트는 self의 멤버를 클로저 안에서 참조할때 someProperty나 someMethod 대신에 self.someProperty나 self.someMethod로 표기할 것을 요구합니다. 이렇게 함으로써 self가 의도치 않게 획득 될 수 있음을 기억하는데 도움이 됩니다.

*/


/*

획득 목록 정의하기 (Defining a Capture List)

획득 목록의 각각의 아이템은 self나 someInstance같은 클래스 인스턴스와 참조간의 약한 참조 또는 미소유 참조의 쌍입니다. 각 쌍들은 대괄호안에 쓰여지며, 콤마로 구분됩니다.

획득 목록은 클로저에 파라메터 목록이나 반환 타입이 있다면 그 앞에 위치시킵니다.

@lazy var someClosure: (Int, String) -> String = {
[unowned self] (index: Int, stringToProcess: String) -> String in
// closure body goes here
}
만약 클로저의 파라메터 목록이나 반환 타입이 문맥에서 암시되어 특별히 정해지지 않았다면, 획득 목록은 클로저의 시작 부분인 in 바로 앞에 둡니다.

@lazy var someClosure: () -> String = {
[unowned self] in
// closure body goes here
}


*/


/*

약한 참조와 미소유 참조 (Weak and Unowned References)

클로저와 클로저가 획득한 인스턴스가 언제나 서로를 참조할때, 획득을 미소유 참조로 정의합니다. 그렇게 되면 같은 시점에 서로 할당 해제가 될것입니다. 그와 반대로, 클로저가 획득한 참조가 언젠가는 nil이 될때, 획득을 약한 참조로 정의합니다. 약한 참조는 언제나 옵셔널 타입이며, 참조중인 인스턴스가 할당 해제가 되면 자동적으로 nil이 됩니다. 이로 인해 클로저 몸체에서 인스턴스의 존재를 확인할 수 있습니다.

중요!

만약 획득된 참조가 절대로 nil이 되지 않는다면, 그 참조는 약한 참조보다 미소유 참조로 해야할것입니다.


*/


class HTMLElement2 {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        println("\(name) is being deinitialized")
    }
    
}

var paragraph2: HTMLElement2? = HTMLElement2(name: "p", text: "hello, world")
println(paragraph2!.asHTML())
// prints "<p>hello, world</p>"

paragraph2 = nil

// deinit이 호출되는 것을 확인할 수 있다.

