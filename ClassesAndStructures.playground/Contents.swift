
/*


클래스와 구조체 (Classes and Structures)

클래스와 구조체는 프로그램의 코드블럭을 정의할때 사용됩니다. 당신의 클래스와 구조체에 기능을 더하기 위해서 상수, 변수, 그리고 함수를 정의할때와 동일한 문법으로 프로퍼티와 메서드를 정의할 수 있습니다.

다른 프로그래밍 언어와는 달리, Swift는 사용자 클래스와 구조체(custom classes and structures)를 위해서 인터페이스 파일과 구현 파일을 나누어서 만들 필요가 없습니다. Swift에서는 한 파일에서 클래스나 구조체를 정의하며, 다른 코드에서 사용하기 위한 그 클래스와 구조체의 외부 인터페이스는 자동적으로 생성됩니다.클래스와 구조체는 프로그램의 코드블럭을 정의할때 사용됩니다. 당신의 클래스와 구조체에 기능을 더하기 위해서 상수, 변수, 그리고 함수를 정의할때와 동일한 문법으로 프로퍼티와 메서드를 정의할 수 있습니다.

다른 프로그래밍 언어와는 달리, Swift는 사용자 클래스와 구조체(custom classes and structures)를 위해서 인터페이스 파일과 구현 파일을 나누어서 만들 필요가 없습니다. Swift에서는 한 파일에서 클래스나 구조체를 정의하며, 다른 코드에서 사용하기 위한 그 클래스와 구조체의 외부 인터페이스는 자동적으로 생성됩니다.

중요!

클래스의 인스턴스는 전통적으로 오브젝트로 알려져 있습니다. 하지만 Swifit의 클래스와 구조체는 다른 언어보다도 기능(functionality)에 가깝고, 이 챕터의 대부분은 클래스나 스트럭쳐 타입의 인스턴스에 적용 가능한 기능을 설명할 것입니다. 이런 이유때문에 일반적인 용어로서의 인스턴스가 사용될 것입니다

*/



/*

클래스와 구조체의 비교 (Comparing Classes and Structures)

Swift에서 클래스와 구조체는 여러 공통점을 가지고 있습니다. 공통적으로 가능한 것으로는:

- 값을 저장하기 위한 프로퍼티를 정의할 수 있습니다.
- 기능을 제공하기 위한 메서드를 정의할 수 있습니다.
- 서브스크립트 문법을 사용하여 그들의 값에 접근하는 것을 제공하는 서브스크립트들을 정의 할 수 있습니다.
- 그들의 초기 상태를 설정하기 위한 Initializer를 정의할 수 있습니다.
- 기본적인 구현을 넘어서 그들의 기능을 확장시키기 위한 확장(expand)이 가능합니다.
- 특정 종류의 표준 기능을 제공하는 것으로 프로토콜을 따를 수 있습니다.

클래스는 구조체는 할 수 없는 다음과 같은 추가적인 기능들을 지원합니다 :

- 상속은 어느 클래스가 다른 클래스의 특성을 상속받을 수 있게합니다.
- 타입 변환(TypeCasting)은 여러분이 작동시(runtime)에 클래스의 타입을 확인하고 변환을 가능하게합니다.
- 해제(Deinitializer)는 클래스의 인스턴스가 할당된 자원을 환원 가능케합니다.
- 참조카운팅(Reference counting)은 하나의 클래스 인스턴스를 한번 이상 참조하는 것을 가능하게 합니다.


중요!
여러분의 코드에서 구조체를 전달할때, 구조체는 언제나 복사가 될뿐, 참조카운팅을 사용하지 못합니다.

*/



/*

정의 문법 (Definition Syntax)

클래스와 구조체는 유사한 문법적 구조를 가지고 있습니다. 클래스는 class 키워드를 구조체는 struct 키워드를 사용합니다. 구조체와 클래스 모두 그들의 모든 정의는 중괄호({})내에 위치시킵니다.

*/


class SomeClass {
    // class definition goes here
}
struct SomeStructure {
    // structure definition goes here
}



/*

중요!

새로운 클래스나 구조체를 정의할때마다 새로운 Swift의 타입을 효과적으로 정의 할 수있다. String, Int, 그리고 Bool와 같은 표준의 Swift타입과 동일한 대문자 사용법과 맞도록 타입들에게 SomeClass나 SomeStructure와 같은 UserCamelCase에 따른 이름을 주십시오. 역으로 프로퍼티와 메서드는 이들과 타입이름으로 구분이 되도록 frameRate나 incrementCount와 같은 lowerCamelCase에 따른 이름을 주십시오.

*/

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


/*

위의 예제는 픽셀기반 해상도를 표현하기 위한 Resolution이란 새로운 구조체를 정의합니다. 이 구조체는 width와 height라는 두개의 저장된 프로퍼티(stored property)를 가지고 있습니다. 저장된 프로퍼티는 클래스의 변수나 상수로서 구성되고 저장된 변수나 상수입니다. 이 두 프로퍼티는 정수값 0으로 초기화된 int타입으로 표현됩니다.

위의 예제는 또한 비디오 화면을 위한 특정 비디오 모드를 정의하는 VideoMode라는 클래스를 정의합니다. 이 클래스는 네개의 변수인 저장된 프로퍼티를 가지고 있습니다. 첫번째로 resolution은 새로운 Resolution구조체의 인스턴스로 초기화됩니다. 즉 Resolution의 프로퍼티 타입으로 표현됩니다. 나머지 세개의 프로퍼티들은, 새로운 VideoMode인스턴스들은 각각 interanced는 non-interlaced 비디오라는 의미의 false로 초기화 되고, 재생시 frame Rate는 0.0으로 초기화 된다. 그리고 name이라 불리는 옵셔널 String값이 있다. name 프로퍼티는 옵셔널 타입이기 때문에 자동적으로 "name 프로퍼티에 값이 없다"는 의미인 nil로 기본값이 주어집니다.

*/



/*

클래스와 구조체 인스턴스 (Class and Structure Instances)

Resolution 구조체와 VideoMode 클래스는 오직 Resolution또는 VideoMode가 어떻게 보일지를 정의할뿐, 특정한 해상도나 비디오 모드를 표현하지는 않습니다. 그러기에, 여러분은 구조체나 클래스의 인스턴스를 만들 필요가 있습니다.

*/

let someResolution = Resolution()
let someVideoMode = VideoMode()



/*
구조체와 클래스는 둘 다 새 인스턴스를 생성하기위해 Initializer 문법을 사용합니다. 가장 간단한 형태의 Initializer 문법은 Resolution()이나 VideoMode()와 같이 클래스나 구조체의 타입 이름에 빈 괄호(())를 덧붙인 것을 사용하는 것입니다. 이는 각 프로퍼티가 기본값으로 초기화 되어 있는 클래스나 구조체의 새 인스턴스를 생성합니다.
*/


/*
프로퍼티 접근 (Accessing Properties)

dot(.) 문법을 사용해서 인스턴스의 프로퍼티에 접근할 수 있습니다. dot 문법에서, 인스턴스 이름 뒤에 아무런 공간 없이 바로 dot(.)과 프로퍼티 네임을 적는것입니다.
*/

println("The width of someResolution is \(someResolution.width)")

println("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
println("The width of someVideoMode is now \(someVideoMode.resolution.width)")

/*
중요!

Objective-C와는 달리 Swift는 구조체 프로퍼티의 내부프로퍼티들을 직접적으로 설정하는 것이 가능합니다. 위의 마지막 예제를 보면, someVideoMode의 resulotion 프로퍼티내의 width 프로퍼티의 값을 resolution 프로퍼티의 전체를 새로운 값으로 설정 할 필요없이 직접적으로 설정하고 있습니다.
*/


/*

구조체 타입을 위한 멤버들의 초기화 (Memberwise Initializers for Structure Types)

모든 구조체는 여러분이 새로은 구조체 인스턴스의 멤버 프로퍼티들을 초기화 할수있는 자동 생성된 멤버들의 initializer(memberwise initializer) 가지고 있습니다. 새로운 인스턴스의 프로퍼티들을 위한 초기값들은 이름을 통해서 멤버들의 initializer에게 전달 될 수 있습니다.

*/

let vga = Resolution(width: 640, height: 480)

// 구조체와 다르게, 클래스 인스턴스는 기본 멤버들의 initializer를 받지 않습니다. 

struct Item{
    var id:String
    var price:Int
}

let item1 = Item(id: "id1", price: 50)
let item2 = item1

println(item2.id)




/*

구조체와 열거형은 값 타입 (Structures and Enumerations Are Value Types)

값 타입(value type)은 변수나 상수에게 할당될 때나 함수에게 값이 전달될 때, 복사되는 타입입니다.

여러분은 지금까지 전 챕터까지 내내 값 타입을 광범위하게 사용했습니다. 사실 Swift에서 기본 형- 정수, 부동 소숫점수, 이진형, 문자열, 배열과 딕셔너리-은 전부 값형식이고 보이지 않는 곳에서 구조체로 구현되어 있습니다.

Swift에서 모든 구조체와 열거형은 값 타입입니다. 즉 여러분이 생성하는 모든 구조체와 열거형 인스턴스들, -그리고 프로퍼티로서 그들이 가지고 있는 모든 값 타입-은 여러분의 코드내에서 전달되는 경우에는 언제나 복사됩니다.

*/


let hd = Resolution(width: 1920, height: 1080)
var cinema = hd


cinema.width = 2048

println("cinema is now \(cinema.width) pixels wide")

println("hd is still \(hd.width) pixels wide")
















// 구조체는 값 타입이기때문에 cinema의 값을 변경하였다 하더라도 hd도 변경되는 것은 아니다. 복사가 일어난 것이다.

enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    println("The remembered direction is still .West")
}

// enum도 값 타입이다.


/*

클래스는 참조 타입 (Classes Are Reference Types)

값 타입과 달리 참조 타입(reference type)은 함수로 전달되때나 상수나 변수에 할당될때 복사가 이루어지지 않습니다. 복사본 대신, 동일한 인스턴스의 레퍼런스(reference)가 사용됩니다.

*/

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0


println("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// alsoTenEighty를 변경하였는데 tenEighty도 변경된 것을 확인할 수 있다.




/*

식별연산자(Identity Operators)

클래스는 참조타입이기때문에 여러 상수나 변수가 동일한 클래스의 인스턴스를 참조하는게 가능합니다.(구조체와 열거형은 할당되거나 함수에 매개변수로 전달될때 복사가 이루어지기때문에 동일한 인스턴스의 참조는 불가능합니다.)

이러한 이유로 두 상수나 변수가 정확하게 동일한 클래스의 인스턴스를 참조하고 있는지 알아내는것은 종종 유용하게 사용됩니다. 그러한 경우를 알아내기 위해서 Swift는 아래의 두가지 식별연산자를 제공합니다

동일한(Identical to) (===)
동일하지 않은(Not identical to) (!==)
두 상수나 변수가 동일한 인스턴스를 가리키는지 검사하기 위해 위의 두 연산자를 사용하십시오.

*/


if tenEighty === alsoTenEighty {
    println("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}

// JAVA언어에서는 == 이 이러한 역할을 수행한다. 



/*
포인터 (Pointers)

만약 여러분이 C나 C++ 또는 Objective-C를 사용해본 경험이 있으시다면 이 언어들이 메모리주소를 참조하기 위해 포인터를 사용한다는 것을 아실겁니다. 어떤 참조형식 인스턴스를 참조하는 Swift 상수나 변수는 C에서의 포인터와 유사합니다. 하지만 이것은 메모리상의 주소를 직접적으로 가르키는 것은 아니고 또한 여러분이 생성한 인스턴스를 가르키기 위해 asterisk(*)를 필요로 하지도 않습니다. 대신 Swift에서는 이러한 레퍼런스들은 다른 상수나 변수처럼 정의할수 있습니다.

*/


/*

클래스와 구조체중에 선택하기 (Choosing Between Classes and Structures)

여러분 프로그램 코드의 특정 분리된 블록을 사용자 데이터 형으로 정의하기위해 여러분은 클래스나 구조체를 사용할수 있습니다.

하지만 구조체 인스턴스는 언제나 값을 전달하고 클래스 인스턴스는 참조변수를 전달합니다. 즉 이것은 이들이 서로 다른 종류의 작업에 적합하다는것을 뜻합니다. 여러분은 프로젝트에 필요한 데이터 집합이나 기능을 정의할때 그것들이 클래스로 정의되어야 할지 구조체로 정의되어야 할지 결정해야 한다는걸 생각하십시오.

일반적인 가이드로는 아래의 조건중에 한가지또는 그 이상일 경우에는 구조체를 생각하십시오.

- 구조체의 주목적이 몇몇 연관성있는 간단한 데이터 값의 캡슐화일 경우
- 캡술화된 값들이 그 구조체의 인스턴스가 할당될때나 전달될때 참조보다는 복사가 예상될 경우
- 구조체에 저장되는 모든 프로퍼티들이 참조보다는 복사가 예상되는 값형식일 경우
- 구조체가 다른 형(type)에서부터 프로퍼티나 기능이 상속될 필요가 없을 경우


구조체를 사용하는 좋은 예:

- Double형을 갖는 width와 height 프로퍼티의 캡슐화를 하는 기하학적 모형의 사이즈.
- Int형을 갖는 start와 length 프로퍼티의 캡슐화를 하는 시리즈의 범위에 접근하는 방법.
- Double형을 갖는 x,y와 z 프로퍼티의 캡슈화를 하는 3차원 좌표시스템의 포인터.

이외의 경우에는 클래스로 정의하고 레퍼런스로 전달되고 관리되는 클래스의 인스턴스를 생성하십시오. 실질적으로는 대부분의 사용자 데이터 형은 구조체가 아닌 클래스로 정의되어야 합니다.

*/



/*

컬렉션 형의 할당과 복사 (Assignment and Copy Behavior for Collection Types)

Swift의 Array와 Dictionary 형은 구조체로 구현되어 있습니다. 하지만 배열의 경우에는 다른 구조체가 함수나 메소드에 전달될때나 상수나 변수에 할당될때와는 약간 다르게 복사가 작동합니다.

이후에 설명할 Array와 Dictionary의 복사는 구조체가 아닌 클래스로 구현된 NSArray와 NSDictionary의 복사와도 또한 다르게 작동합니다. NSArray와 NSDictionary인스턴스는 언제나 복사가 아니라 인스턴스의 레퍼런스가 전달되거나 할당됩니다.
*/


/*
중요!
밑에 설명은 배열, 딕셔너리, 문자열 그리고 다른 값의 "복제"를 설명합니다. 복제가 언급된곳에서 여러분은 여러분의 코드가 언제나 복사처럼 작동하는것을 보게 될것입니다. 하지만 Swift는 절대적으로 필요할 경우에만 실제 값의 복사가 일어납니다. Swift는 추가적인 성능적 향상을 위해서 모든 값의 복사를 관리합니다. 그리고 이러한 최적화를 선점하기위해서 대체적인 할당문의 사용을 해서는 안됩니다.

*/



/*
딕셔너리의 할당과 복사 (Assignment and Copy Behavior for Dictionaries)

여러분이 Dictionary 인스턴스를 상수 또는 변수에 할당할때나 함수또는 메서드에 매개변수로 전달할때 딕셔너리는 할당이되거나 함수가 호츨되는 그 시점에 복제가 됩니다. 이 과정의 자세한 사항은 Structures and Enumerations Are Value Types 항목을 참조하십시오.

만약 딕셔너리 인스턴스에 저장되어있는 키 또는 값이 값형식(구조체이거나 열거형)일 경우 그들 역시 할당될시나 함수의 호출시에 복제가 일어납니다. 이와는 다르게 만약 키 또는 값이 참조형식(클래스이거나 함수)일 경우에는 레퍼런스의 복제가 일어납니다. 하지만 이것은 그들이 참조하고 있는 클래스 인스턴스나 함수가 아닙니다. 이러한 딕셔너리의 키또는 값의 복제 방식은 구조체가 복사될때 구조체의 저장속성의 복제방식과 같습니다.
*/

var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
var copiedAges = ages


copiedAges["Peter"] = 24
println(ages["Peter"])

// 복사가 되었기 때문에 copiedAges를 수정하였어도 ages는 변경되지 않았음을 알 수 있다.



/*

배열의 할당과 복제 (Assignment and Copy Behavior for Arrays)

Dictionary형과 Array형은 복사하지만, Objective-C에 사용된 NSDictionary와 NSArray는 참조입니다.

*/


var a = [1, 2, 3]
var b = a
var c = a


println(a[0]) // 1
println(b[0]) // 1
println(c[0]) // 1

a[0] = 42
println(a[0]) // 42
println(b[0]) // 1
println(c[0]) // 1



var names = ["Stuffy", "Chilly", "Hallie"]
var copiedNames = names

names[0] = "Lambie"
println(copiedNames) // ["Stuffy", "Chilly", "Hallie"]

copiedNames[2] = "kim"
println(names[2]) // "Hallie"



var dic1 = [1:1, 2:4, 3:9, 4:16]

var dic2 = dic1

println(dic1)

println(dic2)

dic2[3] = nil //dic2 요소 제거

println(dic1)

println(dic2)

var arr1 = [1,2,3,4,5]
var arr2 = arr1
println(arr1)
println(arr2)
// arr1과 arr2가 출력한 내용은 같습니다.
// arr2 0번 요소 제거
arr2.removeAtIndex(0)
println(arr1)
println(arr2)
// arr1과 arr2는 다른 결과를 출력하기 때문에 Array형도 Dictionary형처럼 복사된다.


/*

복수의 배열이 동일한 요소들을 공유하는지 검사 (Checking Whether Two Arrays Share the Same Elements)

식별 연산자(==와 !=)를 통해 하나 이상의 배열 또는 subarray들이 동일한 저장소와 요소들을 공유하는지를 확인할수 있습니다.

*/

if b == c {
    println("b and c still share the same array elements.")
} else {
    println("b and c now refer to two independent sets of array elements.")
}


if b[0...1] == c[0...1] {
    println("These two subarrays share the same elements.")
} else {
    println("These two subarrays do not share the same elements.")
}




