
/*

메소드 (Methods)

메서드Method는 타입type에 의존적인 함수입니다. 모든 클래스와 구조체 그리고 이너멀레이션Enumeration은, 타입이 정해진 인스턴스Instance가 수행하는 작업을 캡슐화하는 인스턴스 메소드를 정의 할 수 있습니다. 또한 타입 자체에 관여하는 타입 메소드를 정의 할 수 있습니다. 이 타입 메소드는 오브젝티브-C에서의 클래스Class Method와 유사합니다.

*/



/*

Instance Methods

인스턴스 메소드Instance Method는 특정 클래스, 구조체 혹은 이너멀레이션의 인스턴스에 속하는 함수입니다. 이것은 인스턴스 속성에 접근하고 수정하는 방법이나, 인스턴스의 용도에 관련된 기능을 지원합니다. 함수에서 설명된대로 인스턴스 메소드는 특히 함수와 동일한 문법을 가집니다.

여러분은 인스턴스 메소드를 해당 타입이 속한 괄호내에서 작성합니다. 인스턴스 메소드는 다른 인스턴스 메소드와 해당 타입의 속성에 대한 암시적 권한Implict access을 가지고 있습니다. 인스턴스 메소드는 오직 해당 타입이 속한 특정한 인스턴스에 의해서만 호출 될 수 있습니다. 이것은 속해있는 인스턴스 없이 독립적으로 호출 될 수 없습니다.

*/


class Counter {
    var count = 0
    func increment() {
        count++
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}


/*

이 Counter클래스는 세가지 인스턴스 메소드를 정의합니다.

- increment 1만큼 counter를 증가시킵니다.
- incrementBy(amount: Int) 특정한 정수값만큼 counter를 증가시킵니다.
- reset counter를 0으로 재설정합니다.

또한 Counter클래스는 현재 카운터 값을 추적하기 위해 변수 프로퍼티Property, count를 선언하였습니다.

*/

let counter = Counter()  // count = 0
counter.increment()  // count = 1
counter.incrementBy(5) // count = 6
counter.reset() // count = 0

// 질문
// 위의 코드가 실행될 때 count는 어떻게 변화하는가?



/*

메소드를 위한 지역 및 외부 변수 이름

함수 매개 변수는 외부 변수 이름 섹션에서 설명한대로 지역 이름(함수 바디에서 사용될)과 외부 이름(함수가 호출될 때 사용될)을 가질 수 있습니다. 메소드 매개 변수 또한 그렇습니다. 매소드는 그저 타입에 의존적인 함수와 마찬가지이기 때문입니다. 그러나 이 둘의 지역 이름과 외부 이름의 작명법은 다름니다.

스위프트의 메소드는 오브젝티브-C에서 사용하던 것과 매우 유사합니다. 오브젝티브-C에서 그러하였듯이, 스위프트에서 메소드 이름은, 앞서살펴본 Counter 클래스 예제의 incrementBy 메소드와 같이, 형식적으로 첫번째 파라미터가 with, for 또는 by와 같은 전치사를 사용합니다. 이 전치사가 사용되었다는 점은 메소드가 호출될 때 문장처럼 읽히는 것을 가능하게 만듭니다. 스위프트는 이 관습적으로 인정받은 작명법을 매서드 파라미터에 다른 기본 접근법을 사용하여 함수 파라미터보다 작성하기 쉽게 만들었습니다.

구체적으로, 스위프트는 메소드내 첫 번째 파라미터 이름은 기본적으로 지역 파라미터 이름으로 지정합니다, 그리고 두 번째 파라미터부터는 지역 파라미터와 외부 파라미터 둘다 지정합니다. 이 관습은 오브젝티브-C 메소드에서 형식적으로 이름을 짓고, 작성하던 것과 유사합니다. 그리고 파라미터 이름에 자격을 부여할 필요없이 알아보기 쉬운 메소드 호출을 만들 수 있습니다.

*/


class Counter2 {
    var count: Int = 0
    func incrementBy(amount: Int,numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}

let counter2 = Counter2()
counter2.incrementBy(5, numberOfTimes: 3)


/*

첫번째 인수값에 대해 외부 파라미터 이름을 정의 해줄 필요가 없습니다, 왜냐면 incrementBy라는 함수 이름에서 그것의 용도는 명확해졌기 때문입니다. 하지만 두번째 인수는 메소드가 호출 되었을 때, 그 용도를 명확히하기 위해서 외부 파라미터 이름으로 규정됩니다.

#을 붙임으로써 Swift의 메소드 정의가 Objective-C 와 같은 문법 스타일로 자연스럽게 표현할 수 있다.

*/

class Counter3 {
    var count: Int = 0
    
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}

let counter3 = Counter3()
counter3.incrementBy(5, numberOfTimes: 3)


/*

메소드의 외부파라미터 이름 수정법

기본적인 방법은 아니지만, 가끔씩 메소드의 첫번째 파라미터에 외부 파라미터 이름을 제공하는 것이 유용 할 수 있습니다. 당신은 직접 명시적으로 외부 이름을 추가 할 수 있으며, 혹은 해쉬 심볼을 첫번째 파라미터의 이름 앞에서 붙여서 지역 이름을 외부 이름과 같이 사용할 수 있습니다.

반대로, 메소드의 두번째 파라미터나 추가 파라미터에 대해 외부 이름을 제공하고 싶지 않으면, 언더바(_)로 사용해 해당 파라미터를 명시적 외부 파라미터이름으로 오버라이드해줄 수 있습니다.

*/


class Counter4 {
    var count: Int = 0
    
    func incrementBy(amount: Int, _ numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}

let counter4 = Counter4()
counter4.incrementBy(5, 3)

// 두번째 파라메터에 파라미터 이름을 적지 않아도 된다.



/*

self 프로퍼티

모든 인스턴스 타입은 인스턴스 자체와 명확하게 동일한, 셀프라고 불리는 명시적 프로퍼티를 가지고 있습니다. 이 명시적 셀프 프로퍼티는, 자신이 속한 인스턴스 메소드내에서 현재 인스턴스를 참조하는 데 사용 할 수 있습니다.

*/

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    println("This point is to the right of the line where x == 1.0")
}

// self는 JAVA에서는 this라고 생각하면 쉽다.
// self 접두사가 없다면, 아마도 스위프트는 두 x 모두 메소드 파라미터 x를 참조한다고 여깁니다.

/*

인스턴스 메소드 안에서의 값타입 변경

구조체와 열거형는 값타입이다. 기본적으로 값타입의 프로퍼티는 인스턴스 메소드 안에서 변경될 수 없다. 그러나 만약 특정 메소드 안에서 구고체나 열거형을 변경할 필요가 있다면, 그 메소드에 변화(mutating)동작을 선택할 수 있다. 그러면 메소드는 자신 안에서 해당 프로터리를 변화(즉, 변경)시킬 수 있고, 적용된 모든 변경은 메소드가 끝나면 원본 구조체에 쓰여지게 된다. 메소드는 내포된 self 프로퍼티에 완전히 새로운 인스턴스를 할당할 수도 있다. 어떤 메소드 func키워드 앞에 mutating 키워드를 둬서 이 동작을 선택할 수 있다.

*/


struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint2 = Point2(x: 1.0, y: 1.0)
somePoint2.moveByX(2.0, y: 3.0)
somePoint2.x = 50.0
println("The point is now at (\(somePoint2.x), \(somePoint2.y))")


/*

변하는(Mutating) 메소드안에서 self에 할당하기

변하는(Mutating) 메소드는 암시적으로 self프로퍼티에 완전한 새 인스턴스를 할당할 수도 있다.

*/

struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point3(x: x + deltaX, y: y + deltaY)
    }
}

var point3 = Point3(x: 5.0, y: 2.0)
point3.moveByX(50.4, y: 60.4)


enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()


/*

타입 메소드

위에서 설명한대로, 인스턴스 메소드는 특정타입의 인스턴스에서 호출되는 메소드이다. 타입 자체에서 호출하는 메소드 또한 정의할 수 있다. 이런 종류의 메소드를 타입 메소드라고 한다. 클래스를 위한 타입 메소드는 func 키워드 앞에 class 키워드를 써서 그리고 구조체와 열거형을 위한 타입 메소드는 func 키워드 앞에 static 키워드를 써서 지칭할 수 있다.

타입 메소드는 인스턴스 메소드처럼 점표기법(dot syntax)으로 호출한다. 그러나 타입에 대한 타입 메소드를 호출해야지 그 타입에 대한 인스턴스를 호출하는 것이 아니다.
*/


class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()



// 아래 코드를 분석해보고 어떻게 실행될지 예상해 보자.

struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
println("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    println("player is now on level 6")
} else {
    println("level 6 has not yet been unlocked")
}


// init은 이니셜라이저다. JAVA에서는 생성자라고 생각하면 된다.


