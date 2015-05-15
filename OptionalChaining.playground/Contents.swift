/*

19 옵셔널 체인 (Optional Chaining)


옵셔널 체인(Optional chaining)란 nil이 될 수도 있는 옵션(options)을 가진 프로퍼티(property), 메소드(method), 서브 스크립트 (subscript)에 질의하고 호출하는 프로세스를 말한다. 만약 어떤 옵션이 값을 가진다면 프로퍼티, 메소드, 서브스크립트 호출은 성공하고 옵션이 nil이면, 프로퍼티, 메소드, 서브스크립트 호출은 nil을 반환하게 된다. 여러개의 질의도 함께 엮일 수 있으며, 만약 체인(chaining) 중간의 어떤 링크가 nil이라면 조용하게 전체 체인은 실패한다.

중요!

스위프트(Swift)의 옵셔널 체인이 오브젝티브씨(Objective-C)에 있는 nil에 메시지 보내기와 유사하다. 그러나, 모든 타입(any type)에서 동작하고, 성공, 실패 여부를 확인할 수 있다는 점에서 차이가 있다.

*/



/*

강제 랩핑 해제(Forced Unwrapping) 대안으로써 옵셔널 체인

호출하고자 하는 프로퍼티, 메소드, 서브스크립트의 옵셔널 값(optional value)이 nil 아닐 때 옵션값 뒤에 물음표(?)를 두어 옵셔널 체인을 명시 할 수 있다. 이것은 옵션널 값 뒤에 느낌표(!)를 두어 그 값을 강제로 랩핑 해제하는 것과 유사하다. 가장 주요한 차이점은 옵셔널 체인은 옵션이 nil일 때 자연스럽게 실패한다는 것이고, 강제 랩핑 해제는 옵션이 nil인 경우 런타임 에러가 발생한다. 옵셔널 체인이 nil 값에도 호출할 수 있다는 사실을 반영하기 위해 옵셔널 체인 호출 결과는 항상 옵션널 값이다. 비록 질의한 프로퍼티, 메소드, 서브스크립트가 항상 옵션널 값이 아닌 결과를 도출해도 그렇다. 이 옵션널 반환 값을 사용해서 옵셔널 체인 호출이 성공했는지 ( 반환된 옵션이 값을 가지는 ) 체인 중간의 nil 값 ( 옵션 반환값이 nil ) 때문에 실패했는지를 확인할 수 있다. 구체적으로, 옵셔널 체인 호출 결과는 옵션으로 감싸여져 있음에도 기대한 반환값과 동일한 타입이다. 일반적으로 Int를 반환하는 프로퍼티는 옵셔널 체인에 따라 접근이 가능할때는 Int?를 반환할 것이다.

*/


class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

//let roomCount = john.residence!.numberOfRooms
// this triggers a runtime error

if let roomCount = john.residence?.numberOfRooms {
    println("John's residence has \(roomCount) room(s).")
} else {
    println("Unable to retrieve the number of rooms.")
}
// prints "Unable to retrieve the number of rooms."



john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    println("John's residence has \(roomCount) room(s).")
} else {
    println("Unable to retrieve the number of rooms.")
}
// prints "John's residence has 1 room(s)."




/*

옵셔널 체인을 위한 모델(Model) 클래스(Class) 선언

프로퍼티, 메소드, 서브스크립트를 호출하는 것 같은 한단계 더 깊은 옵셔널 체인을 사용할 수 있다. 이는 상호관계있는 타입간의 복잡한 모델에서 서브 프로퍼티(subproperty)를 파고 들 수 있게 해주고 그 서브 프로터티에 프로퍼티와 메소드, 서브스크립트에 접근할 수 있는지 아닌지를 확인할 수 있게 해준다. 다음 코드 조각은 다단계 옵셔널 체인 예를 포함한 몇가지 순차적인 예제에서 사용될 4개의 모델 클래스를 정의한다.

*/


class Person2 {
    var residence: Residence2?
}

class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        println("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}


/*

옵셔널 체인를 통한 프로퍼티 호출

강제 랩핑 해제(Forced Unwrapping) 대안으로써 옵셔널 체인에서 봤던 것처럼 옵셔널 체인을 온션값에 대한 프로퍼티 접근에 접근할 수 있는지 만약 프로퍼티 접근이 가능한지 확인하기 위해 사용할 수 있다. 그러나선택 묶임를 통해 프로퍼티의 값을 설정하는 것은 할 수 없다. 위에 정의한 새로운 Person 인스턴스를 사용해 클래스를 만들어 이전처럼 numberOfRooms 프로퍼티에 접근하기를 시도해본다.

*/


let john2 = Person2()
if let roomCount2 = john2.residence?.numberOfRooms {
    println("John's residence has \(roomCount2) room(s).")
} else {
    println("Unable to retrieve the number of rooms.")
}
// prints "Unable to retrieve the number of rooms."

// john.residence가 nil이기 때문에 이 옵셔널 체인을 예전과 동일한 방식으로 호출했지만 에러 없이 실패한다.




let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john2.residence?.address = someAddress


/*
옵셔널 체인을 통한 메소드 호출

옵셔널 체인을 사용해서 옵션값을 호출하고 메소드 호출이 성공했는지 여부를 확인해볼 수 있다. 설렁 메소드가 반환값을 정의하지 않더라고 할 수 있다.
*/

if john2.residence?.printNumberOfRooms() != nil {
    println("It was possible to print the number of rooms.")
} else {
    println("It was not possible to print the number of rooms.")
}
// prints "It was not possible to print the number of rooms."


/*
옵셔널 체인을 통한 서브스크립트 호출

옵셔널값에 대한 서브스크립트에서 값을 가져와서 서브스크립트 호출이 성공했는지 확인하기 위해 옵셔널 체인을 사용할 수 있다. 그러나 을 통해 서브스크립트로 값을 설정하는 것은 할 수 없다.

중요!
옵셔널 체인를 통해 옵션값에 대한 서브스크립트를 접근할 때 서브스크립트 꺽은 괄호(bracket) 앞에 물음표를 놓아야 한다. 뒤가 아니다. 옵셔널 체인 물음표는 항상 옵셔널 표현식의 뒤에 바로 따라나와야 한다.

*/

if let firstRoomName = john2.residence?[0].name {
    println("The first room name is \(firstRoomName).")
} else {
    println("Unable to retrieve the first room name.")
}
// prints "Unable to retrieve the first room name."


john2.residence?[0] = Room(name: "Bathroom")

let johnsHouse2 = Residence2()
johnsHouse2.rooms.append(Room(name: "Living Room"))
johnsHouse2.rooms.append(Room(name: "Kitchen"))
john2.residence = johnsHouse2


if let firstRoomName = john2.residence?[0].name {
    println("The first room name is \(firstRoomName).")
} else {
    println("Unable to retrieve the first room name.")
}
// prints "The first room name is Living Room."


/*
Accessing Subscripts of Optional Type
*/

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]

println(testScores["Dave"]) // Optional([91,82,84])
println(testScores["Brian"]) // nil


if let johnsStreet2 = john2.residence?.address?.street {
    println("John's street name is \(johnsStreet2).")
} else {
    println("Unable to retrieve the address.")
}
// prints "Unable to retrieve the address."



let johnsAddress3 = Address()
johnsAddress3.buildingName = "The Larches"
johnsAddress3.street = "Laurel Street"
john2.residence!.address = johnsAddress3


if let johnsStreet3 = john2.residence?.address?.street {
    println("John's street name is \(johnsStreet3).")
} else {
    println("Unable to retrieve the address.")
}
// prints "John's street name is Laurel Street."



if let buildingIdentifier = john2.residence?.address?.buildingIdentifier() {
    println("John's building identifier is \(buildingIdentifier).")
}
// prints "John's building identifier is The Larches."



if let beginsWithThe =
    john2.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            println("John's building identifier begins with \"The\".")
        } else {
            println("John's building identifier does not begin with \"The\".")
        }
}
// prints "John's building identifier begins with "The"."
