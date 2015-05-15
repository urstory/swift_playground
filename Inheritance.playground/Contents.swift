/*

상속 (Inheritance)



하나의 클래스는 또다른 클래스의 메서드, 프로퍼티, 이 외에 다른 특징들을 상속받을 수 있다. 어떤 클래스가 다른 클래스로부터 상속받을 때, 상속받는 클래스를 하위클래스(subclass)라 하고 하위클래스가 상속하는 클래스를 상위클래스(superclass)라 한다. Swift에서 상속이란, 다른 타입의 클래스들과 차별화하는 기본적인 방법이다.

Swift에서 모든 클래스는 상위클래스에 속한 메서드, 프로퍼티, 서브스크립트들을 호출하고 접근할 수 있고, 해당 메서드, 프로퍼티, 서브스크립트들을 오버라이딩하여 자신의 행동을 재정의하거나 수정할 수도 있다. Swift는 오버라이드 정의가 상위클래스의 정의와 일치하는 지를 확인하여 오버라이드가 정확히 이뤄졌음을 보장해주기도 한다.

또한 모든 클래스에는 프로퍼티 값의 변화를 감지하기 위한 프로퍼티 관찰자(property observers)를 상속한 프로퍼티에 추가할 수도 있다. 프로퍼티 관찰자는 해당 프로퍼티가 stored 혹은 computed 인지에 관계없이 어떤 프로퍼티에도 추가할 수 있다.

*/


/*

베이스 클래스 정의

베이스 클래스(Base Class)란, 어떤 클래스도 상속받지 않은 클래스를 말한다.

중요!

Swift 클래스들은 보편적인 베이스 클래스를 상속받지 않는다. 당신이 정의한 클래스가 상위클래스를 가지지 않는다면, 자동적으로 베이스 클래스가 된다.

*/


// Vehicle Base class 정의
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

// Vehicle 클래스는 프로퍼티들의 초기값을 설정하기 위해 생성자(intializer)를 정의하고 있다.

/*
가장 단순한 형태의 생성자는 매개변수가 없는 인스턴스 메서드처럼 보이며, init 키워드를 사용해서 작성한다.

init() {
// perform some initialization here
}
*/


let someVehicle = Vehicle()
// 새로운 인스턴스를 생성


/*

하위클래스 정의

하위클래스를 정의(subclassing)한다는 것은 기존 클래스에 기반을 둔 새로운 클래스를 생성하는 것이다. 하위클래스는 기존 클래스의 모든 특징을 상속받고, 그것들을 재정의할 수 있다. 또한 새로운 특징들을 하위클래스에 추가할 수 있다.

어떤 클래스가 상위클래스를 갖는다는 것을 나타내려면 본 클래스명 뒤에 콜론(:)과 상위클래스명을 차례로 적는다.

class SomeClass: SomeSuperclass {
// class definition goes here
}

*/

class Bicycle: Vehicle {
    var hasBasket = false
}

/*

Bicycle은 Vehicle의 하위클래스이고, Vehicle은 Bycicle의 상위클래스이다. 새로운 Bicycle 클래스는 자동적으로 Vehicle의 모든 특징들, maxPassengers와 numberOfWheels와 같은 프로퍼티들을 획득한다. Bicycle 클래스의 요구조건을 맞추기 위해 상위클래스의 특징을 딱 맞게 조정하고 새로운 특징을 추가할 수 있다.

또한 Bicycle 클래스는 자신에게 딱 맞춰진 특징들을 설정하기 위해 생성자를 정의한다. Bicycle 생성자는 super.init() 메서드를 통해 상위클래스인 Vehicle의 생성자를 호출하고 있다. 이 때 Bicycle이 상속한 모든 변수들을 수정하기 전에 Vehicle에 의해 초기화된다.

중요!

Object-C와 달리, Swift에서 생성자는 디폴트로 상속하지 않는다. 더 많은 정보를 보려면, Initializer Inheritance and Overriding을 참고하도록 한다.

*/


let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
println("Bicycle: \(bicycle.description)")





class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}


let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
println("Tandem: \(tandem.description)")



/*

오버라이딩

하위클래스는 인스턴스 메서드, 클래스 메서드, 인스턴스 프로퍼티 혹은 서브스크립트에 대해 자신만의 커스텀 구현체를 제공할 수 있다. 그렇지 않았다면 상위클래스의 것들을 상속받을 것이다. 이를 오버라이딩(Overriding)이라 한다.

상속한 특징을 오버라이드하려면 오버라이딩한다는 의미로 override 키워드를 접두사로 붙인다. 그렇게 하는 것은 의도적으로 오버라이드를 했고 실수로 일치하는 않는 정의를 한 것이 아님을 분명하게 만든다. 우연히도 오버라이딩은 예기치 못한 행동을 일으킬 수도 있고, override 키워드가 없는 어떤 오버라이드는 코드가 컴파일될 때 에러로 인식될 수도 있다.

또한 override 키워드는 Swift 컴파일러에게 오버라이딩 클래스의 상위클래스(혹은 부모 클래스 중 하나)가 당신이 오버라이드한 것과 일치하는 선언을 갖고 있는지 확인하도록 즉각적인 명령을 내린다. 이러한 확인은 오버라이딩 정의가 올바르게 되었음을 확실하게 만든다. ‌

*/



/*

상위클래스의 메서드, 프로퍼티, 서브스크립트에 접근하는 방법

메서드, 프로퍼티, 서브스크립트를 오버라이드해서 하위클래스를 만들 때 오버라이드의 일부분으로서 기존 상위클래스의 구현을 활용하는 것이 때때로 유용하다. 예를 들면, 기존 구현의 행동을 재정의할 수도 있고 상속한 변수에 변경된 값을 저장할 수 있기 때문이다.

적절한 위치에서 super 접두사를 가지고 상위클래스의 메서드, 프로퍼티, 서브스크립트에 접근할 수 있다.

- someMethod()가 오버라이드 되었을 때, 오버라이딩 메서드 내부에서 super.someMethod()를 통해 상위클래스의 someMethod() 메서드를 호출할 수 있다.
- someProperty가 오버라이드 되었을 때, 오버라이딩한 접근자(getter)와 설정자(setter) 내부에서 super.someProperty를 통해 상위클래스의 someProperty를 호출할 수 있다.
- someIndex에 해당하는 서브스크립트가 오버라이드 되었을 때, 오버라이딩한 서브스크립트 내부에서 super[someIndex]를 통해 상위클래스의 동일한 서브스크립트를 호출할 수 있다.

*/


/*

메서드 오버라이딩

하위클래스에서 특정한 목적에 맞는 메서드를 제공하거나 해당 메서드를 대체하려면, 상속한 인스턴스나 클래스 메서드를 오버라이드하면 된다.

*/

class Train: Vehicle {
    override func makeNoise() {
        println("Choo Choo")
    }
}


let train = Train()
train.makeNoise()




/*

프로퍼티 오버라이딩

프로퍼티에 대한 커스텀 접근자와 설정자를 제공하거나 프로퍼티 값의 변경을 감시하기 위한 프로퍼티 관찰자를 추가하려면, 상속한 인스턴스나 클래스 메서드를 오버라이드하면 된다.

*/


/*

프로퍼티 접근자와 설정자 오버라이딩

상속한 프로퍼티를 오버라이드 하려면 그 프로퍼티가 stored 혹은 computed 프로퍼티인지에 관계없이 커스텀 접근자와 설정자를 제공하면 된다. 상속한 프로퍼티의 stored 혹은 computed 성질은 하위클래스는 알지 못하고, 오로지 상속한 프로퍼티의 이름과 타입만 알 뿐이다. 항상 오버라이딩 하려는 프로퍼티의 이름과 타입을 동일하게 유지해야 한다. 그래야 컴파일러가 오버라이드한 것과 상위클래스의 프로퍼티의 이름과 타입이 일치하는지를 체크할 수 있다.

하위클래스 프로퍼티를 오버라이딩할 때 접근자와 설정자를 동시에 정의함으로써 읽기만 가능했던 상속 프로퍼티를 읽고 쓰기가 가능한 프로퍼티로 나타낼 수 있다. 그러나 읽고 쓰기가 가능한 상속 프로퍼티를 읽기만 가능한 프로퍼티로 나타낼 수는 없다.

중요!

프로퍼티 오버라이드 중 설정자를 제공한다면, 접근자도 반드시 제공해야 한다. 아래 SpeedLimitedCar 예제처럼 상속한 프로퍼티의 값을 오버라이딩 접근자 안에서 변경하고 싶지 않다면, super.someProperty를 통해 상속한 프로퍼티의 값을 그대로 해당 접근자로부터 가져올 수 있다.

*/

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}


let car = Car()
car.currentSpeed = 25.0
car.gear = 3
println("Car: \(car.description)")   // Car: traveling at 25.0 miles per hour in gear 3


/*

프로퍼티 관찰자 오버라이딩

프로퍼티 관찰자를 상속한 프로퍼티에 추가하려면, 프로퍼티 오버라이딩을 사용한다. 이것은 프로퍼티가 어떻게 구현되었는지에 관계없이 상속한 프로퍼티 값의 변화를 알아차릴 수 있도록 해준다. 프로퍼티 관찰자에 대한 더 많은 정보를 보려면, Property Observers를 참고하도록 한다.

중요!

프로퍼티 관찰자는 상수 혹은 읽기 전용 프로퍼티에 추가될 수 없다. 이러한 프로퍼티 값은 다시 설정될 수 없기 때문에 오버라이드의 일부인 willSet() 혹은 didSet()을 제공하는 것은 적절치 않다. 또한 오버라이딩 설정자와 오버라이딩 프로퍼티 관찰자를 동시에 제공할 수 없다. 프로퍼티 값이 변경되는 것을 관찰하고 싶고 이미 그 프로퍼티를 위한 커스텀 설정자를 제공하고 있다면, 커스텀 설정자 안에서 값의 변화를 간단하게 관찰할 수 있다.


*/

println("start")
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            println("didSet!!!!")
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}


let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
println("AutomaticCar: \(automatic.description)") // AutomaticCar: traveling at 35.0 miles per hour in gear 4
println("end")
//
//start
//didSet!!!!
//AutomaticCar: traveling at 35.0 miles per hour in gear 4
//end


/*

오버라이드 방지

메서드, 프로퍼티, 서브스크립트를 오버라이딩하지 못하도록 하려면, final로 표시하면 된다. @final 속성을 첫 키워드 앞에 표시한다. (예, final var, final func, final class func, final subscript)

하위클래스 내에 final 메서드, 프로퍼티, 서브스크립트를 오버라이드하면 컴파일 시간 에러(compile-time error)를 발생한다. 확장 클래스 안에 추가한 메서드, 프로퍼티, 서브스크립트도 final로 표시될 수 있다.

전체 클래스를 final로 만들려면 class 키워드 앞에 final을 표시(final class)하면 된다. 하위클래스를 final 클래스로 만들려면 컴파일 시간 에러를 발생할 것이다.

*/



