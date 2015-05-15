/*

타입변환(Type Casting)

타입 변환이란 인스턴스(instance)의 타입을 체크하기 위한 방법이며, 또한 이것은 인스턴스를 마치 해당 클래스가 가친 계층구조에서 온 상위클래스나 하위클래스처럼 다룬다. Swift에서 타입 변환은 is와 as라는 연산자로 구현할 수 있으며, 이 두 연산자는 값의 타입을 체크하거나 다른 타입으로 변환하는 간단하고 표현적인 방법을 제공합니다. 또한 해당 타입이 프로토콜에 적합하지 아닌지 체크하기 위해서 타입 변환을 사용할 수 있으며 보다 자세한 사항은 Protocol Conformance를 참조하시기 바랍니다.

*/



/*

타입 캐스팅을 위한 클래스 계층 정의(Defining a Class Hierarchy for Type Casting)

당신은 특정한 클래스의 인스턴스의 타입을 체크하거나 인스턴스를 같은 계층의 또다른 클래스로 변환하기 위해서 클래스들과 하위클래스들의 계층정보를 사용한 타입캐스팅을 할 수 있다.

*/

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}


class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}


let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// the type of "library" is inferred to be [MediaItem]



/*

타입 체크(Checking Type)

어떠한 인스턴스가 확실히 하위클래스 타입인지 아닌지를 체크하기 위해서는 타입 체크 연산자인 is를 이용합니다. 이 타입체크용 연산자는 만일 해당 인스탄스가 해당 하위 클래스라면 true를, 아니라면 false를 반환합니다.

*/


var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        ++movieCount
    } else if item is Song {
        ++songCount
    }
}

println("Media library contains \(movieCount) movies and \(songCount) songs")
// prints "Media library contains 2 movies and 3 songs"


/*

다운캐스팅( Downcasting )

상수와 변수의 명확한 클래스 타입은 사실은 아마도 the scenes뒤에 있는 하위 클래스의 인스탄스에 속할것이다. 당신이 위와 같은 케이스를 믿는 경우, 당신은 타입 변환 연산자인 as를 통하여 하위클래스타입으로 다운캐스팅을 시도 할 수 있다. 다운캐스팅은 실패할 수 있기때문에, 타입 캐스팅연산자는 두가지의 다른 형태를 가집니다. 하나는 as?와 같은 연산자를 사용하는 optional form으로 다운캐스팅을 시도하여 optional value를 리턴합니다. 다른 하나는 as와 같은 연산자를 사용하는 forced form으로 다운 캐스팅을 시도하고 강제로 unwrap한 결과를 한번에 합한 작업을 합니다. 네가 만일 다운캐스트가 성공할지 확신을 가지지 못한다면 타입변환 연산자인 as?를 이용하는 optional form을 사용한다. 위 연산자를 사용하는 form은 항상 optional value를 리턴하며 그래서 만일 다운 캐스트가 가능하지 않은 경우에는 nil을 리턴할 수 있도록 할 수 있다. 이 것은 당신이 다운 캐스팅의 성공 유무를 체크할 수 있도록 하게 한다. 오직 당신이 다운캐스트가 항상 성공할 것이라는 확신이 있다면 타입 변환 연산자인 as를 이용하는 forced form을 사용할 수 있다. 위의 연산자를 사용하는 form은 만일 올바르지 않은 클래스 타입으로 다운캐스팅을 시도했을 시에 런타임 에러를 발생시킨다.

*/

for item in library {
    if let movie = item as? Movie {
        println("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        println("Song: '\(song.name)', by \(song.artist)")
    }
}

// Movie: 'Casablanca', dir. Michael Curtiz
// Song: 'Blue Suede Shoes', by Elvis Presley
// Movie: 'Citizen Kane', dir. Orson Welles
// Song: 'The One And Only', by Chesney Hawkes
// Song: 'Never Gonna Give You Up', by Rick Astley


/*

중요!

변환(Casting)은 실제로 해당 인스턴스를 수정하거나 그 값을 바꾸는 것이 아닙니다. 근본적인 인스턴스는 처음상태 그대로 남아있습니다. 이것은 간단히 특별한 것이며, 캐스팅된 타입의 인스턴스로서 접근이 가능한 것입니다.

*/

/*

Type Casting for Any and AnyObject

Swift는 특정한 타입을 가지지 않는 상태로 작업하기 위한 두가지의 특별한 타입을 제공합니다:

AnyObject는 어떠한 클래스타입의 인스턴스라도 표현할 수 있습니다 Any는 함수형의 타입을 제외하고는 어떠한 타입의 인스턴스라도 표현할 수 있습니다.

중요!

Any나 AnyObject는 오로지 당신이 명시적으로 behavior나 그들이 제공하는 능력들이 필요한 경우에만 사용합니다. 이는 항상 당신의 코드 속에서당신이 예상한 특정한 형태의 타입으로 작동하는 것이 더 낫습니다.

*/


/*
AnyObject

Cocoa APIS를 이용하여 작업을 할때, 보통 AnyObject[] 타입의 배열을(AnyObject 타입의 값을 가진 배열) 받는것이 일반적입니다. 이것은 Objective-C가 명시적인 타입의 배열을 가지지 못하기 때문입니다. 그러나 당신이 종종 당신이 알고있는 API가 제공하는 배열을 포함한 여러가지 정보를 포함한 오브젝트들의 타입에 대해서 자신이 있을 수 있다. 이러한 상황에서, 당신은 optional unwrapping이 필요하지 않은 경우에 한하여 배열의 각각의 아이템을 특정한 클래스의 타입으로 바꾸는 다운캐스팅을하기 위한 타입 변환 연산자 as로 강제로 변경한 형태를 사용할 수 있습니다.

*/
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]


for object in someObjects {
    let movie = object as! Movie
    println("Movie: '\(movie.name)', dir. \(movie.director)")
}
// Movie: '2001: A Space Odyssey', dir. Stanley Kubrick
// Movie: 'Moon', dir. Duncan Jones
// Movie: 'Alien', dir. Ridley Scott


for movie in someObjects as! [Movie] {
    println("Movie: '\(movie.name)', dir. \(movie.director)")
}
// Movie: '2001: A Space Odyssey', dir. Stanley Kubrick
// Movie: 'Moon', dir. Duncan Jones
// Movie: 'Alien', dir. Ridley Scott


/*
Any

이곳에 non-class타입을 포함한 여러가지 다른 타입을 섞어서 작업하기 위한 Any를 사용한 예제가 있다. 이 예제는 Any타입의 값을 저장할 수 있는 things이라는 한 배열을 생성한다.
*/

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })


for thing in things {
    switch thing {
    case 0 as Int:
        println("zero as an Int")
    case 0 as Double:
        println("zero as a Double")
    case let someInt as Int:
        println("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        println("a positive double value of \(someDouble)")
    case is Double:
        println("some other double value that I don't want to print")
    case let someString as String:
        println("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        println("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        println("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as String -> String:
        println(stringConverter("Michael"))
    default:
        println("something else")
    }
}

// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called 'Ghostbusters', dir. Ivan Reitman
// Hello, Michael


/*

중요!

switch문의 case항목들은 체크 및 특정한 타입으로의 변환을 위해서 as나 as?를 통해서 강제로 변경된 형태를 사용한다. 이런 체크는 switch문의 문맥안에 있는 이상 항상 안전하다.

*/

