/*

속성 (Properties)

속성은 특정 클래스, 구조체(structure), 혹은 열거형(Enumeration)과 값들을 연결해준다. 저장속성(Stored property)는 상수나 변수값을 인스턴스의 일부로 저장한다. 계산속성(Computed property)는 값을 그냥 저장하는 것이 아니라 계산한다. 계산속성은 클래스나 구조체 그리고 열거형에서 사용할 수 있다. 저장속성은 클래스와 구조체에서만 사용할 수 있다.

저장속성과 계산속성은 일반적으로 특정 타입의 인스턴스와 연결된다. 하지만, 속성이 타입 자체와 연결될수도 있는데, 이런 속성을 타입 속성(type property)라고 한다.

덧붙여, 프로그래머는 속성값의 변경을 모니터링하기 위해 속성 관찰/감시자(property observer)를 정의할 수 있다. 이것은 프로그래머가 속성값의 변경에 직접 정의한 동작들로 대응할 수 있게 해준다. 속성감시자는 프로그래머가 직접 정의한 저장속성이나 상위클래스에서 상속받은 속성들에 추가할 수 있다.



*/


/*
저장속성 (Stored Property)

저장 속성은 가장 단순한 형태일때 특정 클래스와 구조체의 인스턴스에 저장되는 상수나 변수다. var 키워드로 선언(introduced)되면, 변수저장속성(variable stored property). let 키워드로 선언되면 상수저장속성(constant stored property)이라 한다.
    
프로그래머는 저장 속성을 정의할 때 초기값을 지정할 수 있다. 이에 대해서는 "초기속성값" 챕터에서 설명되어있다. 저장된 속성의 초기값을 수정할 수도 있는데, 심지어 상수 저장속성마저도 수정이 가능하다.
*/


struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0,  length: 3)
// 구조체는 생성자가 기본제공된다.

rangeOfThreeItems.firstValue = 6


/*
상수 구조체 인스턴스의 저장속성 (Stored Properties of Constant Structure Instances)

상수로 선언된 구조체 인스턴스의 속성들은 변수속성이더라도 수정되지 않는다.

*/


let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6
// let으로 rangeOfFourItems로 선언하였기 때문에 값을 할당 할 수 없다.
// 구조체는 값 타입이기 때문이다.



/*

지연 저장속성(Lazy Stored Property)

지연 저장속성은 그 초기값이 최초로 사용되기전까지는 계산되지 않는다. 프로그래머는 선언시에 lazy attribute라고 써줌으로써 지연 저장속성을 표시할 수 있다.

*/


/*
중요!

지연 속성은 초기화(initialization)가 끝난 뒤에도 초기값을 꺼낼 수 없을지도 모르기 때문에 언제나 var 키워드를 통해 변수로 선언되어야한다. 반면, 상수 속성은 초기화가 끝나기 전에 반드시 값을 가져야하기 때문에 지연 속성으로 선언될 수 없다.
*/


class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a non-trivial amount of time to initialize.
    */
    var fileName = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")


println(manager.importer.fileName)
// 위의 줄이 실행될 때 importer가 초기화가 일어난다.


/*

DataManager 클래스의 기능 중 하나는 파일에서 데이터를 가져오는 것이다. 이 기능은 초기화하는데 많은 시간이 드는 DataImporter 클래스가 제공한다. 이것은 DataImporter 인스턴스가 초기화될때 화일로부터 데이터를 읽어 메모리로 로드해야하기 때문이라고 가정하자.

DataManager 인스턴스가 데이터를 관리할 때 파일에서 읽어오지 않는 경우도 있을 수 있다. 이런 경우엔 DataManager가 생성될때, DataImporter 인스턴스를 생성하는 것은 불필요하다. 대신에, DataImporter 인스턴스를 최초로 사용할때 생성되도록 하는 것이 더 좋다.

지연 속성(lazy)으로 표시되어있기 때문에, DataImporter 인스턴스인 DataManager의 importer 속성은 fileName 속성을 조회할 때와 같은 최초의 접근시 생성된다.

*/


/*

계산속성 (Computed Properties)

저장속성에 더해서, 클래스, 구조체 그리고 열거체에는 계산속성(Computed properties)를 정의할 수 있다. 계산속성은 실제로 값을 저장하지는 않고, 다른 속성이나 값들이 간접적으로 접근하여 값을 조회하거나 수정할 수 있는 getter와 선택적인 setter를 제공한다.

*/


struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
println(square.center.x)
println(square.center.y)
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
println("square.origin is now at (\(square.origin.x), \(square.origin.y))")

/*

위 예제는 기하학의 도형을 다루기 위한 세개의 구조체를 정의하고 있다.

- Point 구조체는 x,y 좌표를 가진다.
- Size 구조체는 width(너비)와 height(높이)를 가진다.
- Rect 구조체는 origin(시작점)과 size(크기)로 사각형을 정의한다.

Rect 구조체는 center라는 이름의 계산속성도 제공한다. Rect 구조체의 현재 중점(center position)은 언제나 origin과 size에 의해 결정된다. 그러므로, 프로그래머는 중점을 명시적인 Point 값으로 저장하지 않아도 된다. 대신에, Rect 구조체는 center라는 이름의 저장속성을 위한 맞춤 getter와 setter를 제공한다. 프로그래머는 이 center 계산속성을 마치 실제 저장속성인 것처럼 사용할 수 있다.

이어지는 코드에서는 square란 이름의 새로운 Rect 변수가 생성된다. square 변수는 시작점 (0,0)과 너비 10 ,높이 10으로 초기화된다. 이 square는 아래 도표의 파란색 사각형으로 표시된다.

square 변수의 center 속성은 마침표(.)를 통해 square.center 처럼 접근할 수 있다. 이렇게 접근할 경우, 현재 속성값을 조회하는 getter가 호출된다. 이 getter는 실재하는 속성값을 반환하는게 아니라, 계산을 통해서 현재 사각형의 중점에 해당하는 새로운 Point 값을 반환한다. 위에서 보듯이, getter는 정확하게 (5,5) 좌표를 반환한다.

그 다음엔 center 속성을 (15,15)로 변경한다. 이것은 사각형을 아래 도표 속의 우상단에 있는 오렌지 사각형의 위치로 이동시킨다. center 속성에 값을 지정하게 되면 setter를 호출하게 되는데, 이것은 x, y 저장속성을 함께 변경시켜, 사각형이 새로운 위치로 이동하도록 만든다.

*/




/*

속기식의 Setter 선언(Shorthand Setter Declaration)

계산속성의 setter에 새로운 값이 저장될 이름이 명시되지 않으면 기본값으로 newValue를 사용한다. 속기식의 방식을 이용한 Rect 구조체의 새로운 버전은 다음과 같다:

*/

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

/*

읽기전용 계산속성 (Read-Only Computed Properties)

getter만 있고, setter가 없는 계산속성은 읽기전용 계산속성(read-only computed property)라 부른다. 읽기전용 계산속성은 언제나 값을 반환하며, 마침표(.)를 통해 접근할 수 있지만, 다른 값으로 설정할 수는 없다.

*/

/*
중요!

읽기전용을 포함한 모든 계산속성은 반드시 var 키워드로 선언되어야한다. 왜냐하면, 계산속성의 값은 고정되지 않았기 때문이다. let 키워드는 초기화시 한번 지정되면 변경할 수 없다는 것을 표시하기 위해 상수속성 선언에만 사용해야한다.

*/

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
println("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")



/*

속성감시자 (Property Observers)

속성 감시자는 속성값 변경를 감시하고 대응한다. 속성 감시자는 속성값이 설정될 때마다 호출되는데 새 값이 현재값과 동일하다라고 하더라도 호출된다.

지연 저장 속성은 별도로 선언한 모든 저장속성에 속성 감시자를 추가할 수 있다. 하위 클래스 안에서 속성을 오버라이딩해서 모든 상속받은 속성(저장 속성이나 계산 속성에 관계 없이)에도 속성 감시자를 추가할 수 있다. 속성 오버라이딩은 Overriding 항목에 설명한다.

중요!
오버라이딩 되지 않은 계산 속성에 속성감시자를 추가할 필요는 없다. 계산 속성 설정자(setter)에서 직접 해당 값 변화를 감시하고 대응할 수 있기 때문이다.


두가지 중 하나나 모두 설정할 수 있는 옵션을 속성에 대한 감시자에 정의할 수 있다.

- willSet는 값이 저장되지 직전에 호출된다.
- didSet는 새 값이 저장된 직후에 즉시 호출된다.

만약에 willSet 관찰자를 구현한다면, 새 속성값은 상수 매개변수로 전달된다. willSet 구현의 일부분으로 이 매개변수 이름을 정의할 수 있다. 만약 매개변수 이름과 둥근괄호를 구현에 작성하지 않기로 결정해도, 여전히 기본 매개변수 이름인 newValue로 매개변수를 사용할 수 있을 것이다.

비슷하게, didSet 감시자를 구현한다면 옛 속성값을 담고 있는 상수 매개변수를 전달할 것이다. 매개변수 이름을 원한다면 명명하고 혹은, oldValue이라는 기본 매개변수 이름을 사용할 수 있다.

중요!

willSet과 didSet 감시자는 속성이 최초로 초기화될 때는 호출되지 않는다. 속성값이 초기화 문맥을 벗어나서 설정되는 경우에만 호출된다.


*/


class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            println("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                println("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896


//참고 : http://stackoverflow.com/questions/24006234/what-is-the-purpose-of-willset-and-didset-in-swift


/*

전역 변수와 지역 변수(Global and Local Variables)

이전에 설명한 계산 속성과 관찰 속성에 대한 능력은 전역 변수와 지역변수에서도 가능하다. 전역 변수가 모든 함수, 메소드, 클로저, 타입의 문맥 밖에 정의된 변수라면, 지역 변수는 어떤 함수, 메소드, 클로저 문맥 안에 정의된 변수이다.

이전장에서 만난 전역 변수와 지역 변수는 모두 저장 변수 뿐이었다. 저장 변수란 저장 속성처럼 특정 타입의 값에 대한 저장소를 제공하고 그 값을 설정하거나 집어올 수 있도록 해준다.

그러나, 전역이냐 지역 유효범위이냐 관계 없이 계산변수나 저장 변수를 위한 관찰자를 또한 정의할 수 있다. 계산 변수는 값을 저장한다기 보다 계산을 하고 계산속성에서와 동일한 방식으로 작성하면 된다.

*/


/*
중요!

전역 상수와 변수는 Lazy Stored Properties와 유사한 방식으로 항상 지연 계산한다. 그러나 지연 저장 속성과는 다르게 전역 상수와 변수는 lazy이라는 특성으로 표시하지 않아도 된다.

*/




/*

타입 속성(Type Properties)

인스턴스 속성은 특정 타입의 인스턴스에 속한 속성이다. 해당 타입에 대한 새 인스턴스를 생성할 때마다 다른 인스턴스와 분리된 인스턴스 자신의 속성값 세트를 가지게 된다.

타입의 어떤 하나의 인스턴스에 속한 것이 아닌 해당 타입 자체에 속한 속성 역시 정의할 수 있다. 이 속성에 대해서는 얼마나 많은 인스턴스를 만들었는지에 관계없이 단 한개의 복사본만이 존재할 것이다. 이런 종류의 속성을 타입 속성이라고 한다.

타입속성은 특정 타입의 모든인스턴스에 영향을 미치는 값을 정의하는데 유용하다. 모든 인스턴스가 사용하는 상수 속성이라든지 (C의 정적 상수 같이), 특정 타입의 모든 인스턴스가 글로벌하게 값을 저장하는 변수 속성(C의 정적 변수 같이) 같은 경우가 있다.

값타입에서는 (즉, 구조체와 열거형), 저장 과 계산 타입 속성을 정의할 수 있다. 클래스에서는 계산 타입 속성만을 정의할 수 있다.

값 타입에서 저장 타입 속성은 변수가 상수가 될 수 있다. 저장 타입 속성은 항상 변수 속성으로 정의될 것이다. 저장 인스턴스 속성과 동일한 방식이다.

중요!

위에 나온 계산 타입 속성은 읽기 전용 계산 타입 속성이지만, 계산 인스턴스 속성과 동일한 문법을 사용해서 읽고쓰기용 계산 타입 속성 또한 정의할 수 있다.

*/



/*

타입 속성의 문법 (Type Property Syntax)

C나 Objective-C에서는 전역적인 static 변수의 타입을 가지는 static 상수와 변수를 정의할 수있다. 그러나 Swift에서는 타입 속성은 타입들의 바깥쪽 중괄호 안에 타입의 정의 부분을 적을 수 있다. 그리고 각 타입 속성은 그 타입이 지원하는 명시적인 scope를 가진다.

static키워드를 가지고 값 타입의 타입 속성을 정의할 수 있고, class키워드를 이용해서 클래스 타입의 타입 속성을 정의할 수 있다. 아래의 예시는 저장되거나 혹은 계산된 타입 속성을 위한 문법들을 보여준다:

*/

/*
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        // return an Int value here
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        // return an Int value here
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        // return an Int value here
    }
    class var overrideableComputedTypeProperty: Int {
        // return an Int value here
    }
}
*/

/*

타입 속성 조회와 설정 (Querying and Setting Type Properties)

타입 속성은 인스턴스 속성처럼 닷 표기법을 이용해서 조회하고 설정한다. 그러나, 타입 속성이 타입의 인스턴스가 아니라 타입에 조회하고 설정한다.

*/

/*
println(SomeClass.computedTypeProperty)
println(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
println(SomeStructure.storedTypeProperty)
*/


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}


/*

AudioChannel 구조체는 기능성을 지원하기 위한 두개의 저장 타입 속성을 정의한다. 먼저, thresholdLevel는 오디오 레벨이 받을 수 있는 최대 임계값을 정의한다. 이는 모든 AudioChannel 인스턴스를 위한 10이라는 상수 값이다. 만약 오디오 신호가 10보다 높은 값이 들어온다면, 이 임계값에 따라 ( 아래 설명하는 것처럼 ) 상한선이 정해질 것이다.

둘째 타입 속성은 maxInputLevelForAllChannels이란 변수 저장 속성이다. 이는 어떤 AudioChannel 인스턴스로 받는 최대 입력값을 계속 추적한다. 그 초기값은 0부터 시작한다. AudioChannel 구조체 역시 currentLevel이란 저장 인스턴스 속성 정의하는데 0부터 10까지 현재 체널의 오디오 레벨를 나타낸다.

currentLevel 속성은 didSet 속성 관찰자를 가지는데 언제 설정되던간에 currentLevel값을 확인하기 위함이다. 이 관찰자는 두가지 확인 사항을 실행한다:

- 만약 currentLevel의 새 값이 thresholdLevel에 의해 허용된 것보다 크다면, 속성 관찰자는 currentLevel를 thresholdLevel으로 상한선을 맞출 것이다.
- 만약 currentLevel의 새 값이(상한선이 맞춰진 다음) 이전에 아무 AudioChannel인스턴스로부터 전달 받은 어떤 값보다도 크다면 속성관찰자는 maxInputLevelForAllChannels 정적 속성에 새 currentLevel값을 저장할 것이다.

*/

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
println(leftChannel.currentLevel)  // 7
println(AudioChannel.maxInputLevelForAllChannels) // 7

rightChannel.currentLevel = 11
println(rightChannel.currentLevel)  // 10
println(AudioChannel.maxInputLevelForAllChannels) // 10

// 질문
// 왜 이러한 결과가 나오는지 설명할 수 있는가?






