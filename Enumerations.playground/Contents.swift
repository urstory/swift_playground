/*


열거형(Enumeration)


열거형 (Enumeration) 은 관련있는 값들의 그룹에 대한 일반적인 타입을 정의하며, 이를 이용하여 코드 안에서 타입에 안전한 방법으로 작업할 수 있습니다. C에 익숙한 사용자라면, C 열거형은 관련있는 이름을 정수값의 집합(set)에 할당하는 것을 알고 있을 것입니다. Swift의 열거형은 훨씬 더 유연하며, 열거형의 각 숫자마다 반드시 값을 제공할 필요가 없습니다. 만약 ("원시(raw)" 값으로 알려진) 값이 각 열거형 번호마다 제공될 경우, 그 값들은 문자열, 글자, 어떠한 정수나 부동 소수점 타입이 될 수 있습니다.

또한, 열거형 멤버들은 각각 다른 멤버 값에 대하여 다른 언어의 공용체(union)및 비슷한 기능들이 하듯 연관된 값들을 어떤 타입이든 지정할 수 있습니다. 관련있는 멤버들의 일반적인 집합을 하나의 열거형의 부분으로 정의할 수도 있으며, 각각은 그에 연관된 적당한 타입의 값들의 다양한 집합을 가질 수 있습니다.

Swift의 열거형은 열거형의 현재 값에 대한 추가적인 정보를 제공하기 위한 계산된 프로퍼티나, 열거형이 표현하는 값들과 연관된 기능들을 제공하는 인스턴스 메소드 같이 전통적으로 클래스 등에서만 지원되는 많은 기능들을 차용하였습니다. 또한 열거형은 초기 멤버 값을 제공하는 이니셜라이저(initiailizer)를 제공할 수 있고, 원래 구현을 넘어서 기능을 확장할 수도 있으며, 표준 기능을 제공하기 위한 프로토콜을 따를 수 있습니다.

*/


/*

열거형 문법 (Enumeration Syntax)

열거형은 enum 키워드로 작성하며, 중괄호 안에 모든 정의를 집어넣습니다.

enum SomeEnumeration {
// enumeration definition goes here
}

*/


// 나침반의 동서남북을 열거형으로 표현
enum CompassPoint {
    case North
    case South
    case East
    case West
}

// (North, South, East 및 West 같이) 열거형에 정의된 값들은 이 열거형의 멤버 값들입니다. case 키워드는 멤버 값들의 새 줄이 정의될 것임을 나타냅니다.

/*

중요!

C 및 Objective-C 와는 다르게, Swift의 열거형 멤버들은 생성시 기본 정수값들에 할당되지 않습니다. 위의 CompassPoints 예제에서 보듯, North, South, East 및 West는 명시적으로 0, 1, 2 및 3에 대응되지 않습니다. 대신에, 기본 열거형 멤버들은 CompassPoint의 명시적으로 정의된 타입과 함께 정의된 완벽하게 갖춰진 값입니다.

*/

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

// case다음에 컴마(,)를 이용하여 한줄에 여러개를 선언



// 각 열거형 정의들은 새로운 타입을 정의합니다. Swift의 다른 타입과 마찬가지로, 이름들 ( CompassPoint 및 Planet과 같은) 은 대문자로 시작해야 합니다. 자명하게 읽힐 수 있도록 열거형 타입에게 복수형 대신 단수형 이름을 주세요.
var directionToHead = CompassPoint.West


println(directionToHead)  // "(Enum Value)" 가 출력된다.


// directionToHead 타입은 CompassPoint의 가능한 값들 중 하나가 초기화 될 때 유추됩니다. directionToHead가 CompassPoint로 선언되면, 짧은 닷 구문을 사용하여 그 값을 다른 CompassPoint 값으로 할당할 수 있습니다:

directionToHead = .East

// 이미 directionToHead는 CompassPoint의 enum값을 하나 할당 받았었기 때문에 컴파일러는 . 앞에 CompassPoint를 생략할 수 있다.



/*

열거형의 값들과 스위치 구문간의 대응 (Matching Enumeration Values with a Switch Statement)

각각의 열거형 값들을 switch 구문과 대응할 수 있습니다.

*/


directionToHead = .South
switch directionToHead {
case .North:
    println("Lots of planets have a north")
case .South:
    println("Watch out for penguins")
case .East:
    println("Where the sun rises")
case .West:
    println("Where the skies are blue")
}

/*
final static int A = 1;
final static int B = 2;

int i = 0;
switch i {
    case A :
    case B :
    case 3 :
}


*/


let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    println("Mostly harmless")
default:
    println("Not a safe place for humans")
}


/*

관련된 값들 (Associated Values)

앞 섹션의 예제는 열거형의 멤버들이 각각의 어떻게 정의되었는지 보여줍니다. 상수 및 변수를 Planet.Earth 에 할당할 수 있으며, 나중에 값들을 확인할 수도 있습니다. 그렇지만, 종종 멤버 값들과 함께 연관된 다른 타입의 값들을 저장하는 것이 유용한 경우들이 있습니다. 이는 추가적인 사용자 지정 정보를 멤버 값들마다 저장할수 있게 하며, 코드 안에서 멤버를 사용할 때 마다 정보가 변경되는 것을 허용합니다.

어떤 특정한 타입의 관련 값을 저장하는 Swift 열거형을 정의 할 수 있으며, 필요한 경우에 열거형의 각 멤버에 따라 값의 형식은 다를 수 있습니다. 이러한 열거형과 유사한 경우들이 다른 언어에서는 차별된 공용체 (discriminated union), 태깅된 공용체 (tagged unions) 및 변형체 (variants) 로 알려져 있습니다.

*/

enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

// (Int, Int, Int) 타입의 UPCA 값 또는 String 타입의 QRCode 값을 가질 수 있는 Barcode라는 열거형 타입을 정의합니다.

// 다음과 같이 열거형을 선언할 수 있다. UPCA타입이지만 3가지 값을 가지고 있다.
var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
var productBarcode2 = Barcode.UPCA(8, 85909_51226, 3)

switch productBarcode {
case .UPCA(let numberSystem, let identifier, let check):
    println("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case .QRCode(let productCode):
    println("QR code with value of \(productCode).")
}

//if productBarcode == productBarcode2 {
//    println("ok!")
//}
// enum 을 가지고 위와 같이 == 를 이용하여 같은지 비교할 수 없다.


// 위의 예제에서는 열거형 맴버들의 연관 값들 앞에 let을 쓴 것을 볼 수 있다.
// let과 var가 혼용되지 않는다면 case뒤에 let이나 var를 써서 모두 동일하게 처리하게 할 수 있다.
switch productBarcode {
case let .UPCA(numberSystem, identifier, check):
    println("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case let .QRCode(productCode):
    println("QR code with value of \(productCode).")
}



/*

원시 값 (Raw Values)

연관값들을 사용한 바코드 예제는 어떻게 열거형의 멤버들이 그들이 저장하는 여러 타입의 관련된 값들을 선언하는지에 대해 보여주었습니다. 연관 값들에 대한 다른 방법으로, 열거형 멤버들은 (원시 값들이라고 부르는) 모두 같은 타입인 기본값들로 미리 채워질 수 있습니다.

*/

enum ASCIIControlCharacter: String {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

println(ASCIIControlCharacter.Tab.rawValue)

enum Planet2: Int {
    case Mercury = 0, Venues, Earth , Mars, Jupiter, Saturn, Uranus, Neptune
}


let earthsOrder = Planet2.Earth.rawValue


let possiblePlanet = Planet2(rawValue: 7)
println(possiblePlanet?.rawValue)

let earthEnum = Planet2.Earth

let positionToFind = 2
if let somePlanet = Planet2(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        println("Mostly harmless")
    default:
        println("Not a safe place for humans")
    }
} else {
    println("There isn't a planet at position \(positionToFind)")
}



