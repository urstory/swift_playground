/*

Optional



Optional의 존재는 nil 로부터 온다.

nil 의미

Swift 에서의 nil 은 Objective-C 에서의 nil 과 다르다.

nil of Swift : 값이 없다  in 모든타입 (Reference or Value Type)
nil of Objective-C : 값이 없다 in Reference Type
즉, Swift에선 어떤 타입이든 값이 없으면  nil 이다.


*/



/*

Optional Type

Optional Type 은 nil이 될 수도  있는 변수 (or 상수)를 의미하며 선언할 때 ‘?’ 를 사용한다.  ‘?’  이 없으면 Non-Optional Type 으로 nil이 될 수 없다.

*/



// optional type.
var optionalString : String?   // nil 로 초기화

// non-optional type.
//var nonOptionalString : String // nil 이 될 수 없음. 초기화 필요
// 컴파일 오류가 발생한다.


/*

WWDC 2014 에서 Safe, Power, Modern 세가지를 Swift의 특징으로 꼽았다. Optional은  Safe에 속한다.

기존 nil 로 인한 앱 크래쉬 문제를  nil 전용 변수 타입을 따로 정의해서 compile 시점에서 막아줄께 하는 것이다. (실제로 이것이 얼마나 안전한지는 더 써봐야 알겠다.)

개발자는 변수 선언할 때마다 Optional Type으로 선언할 것인지 판단해야 한다. 꼭 필요한 경우에만 Optional Type 사용을 권장한다.

*/


/* Optional은 enum 으로 정의된다.

enum Optional<T>{
    case None
    case Some(T)
}
*/


/*

! (forced-unwrapping operator)

Optional을 이용하여 안전한 코드를 짜려면 반드시 if 문으로 값이 있는지 확인을 해야 한다. 값이 있는 경우엔 ‘!’ 를 이용하여 값이 있음을 명시적으로 알려줘야 한다.

‘!’ 는 forced-unwrapping operator 로서 애매모호한 Optional Type 값을 명확하게 들어낸다. 이를 통해 불필요한 Optional Type 추가 발생을 막는다.

*/

let numCards = ["one" : 1 , "two" : 2, "three" : 3,
    "four" : 4 , "five": 5]

// dictionary[key] 는 optional type을 반환 (즉,myCard 는 Int?)
let myCard = numCards["two"]
if myCard != nil { // 값을 체크
    
    let card = myCard! // 값이 있으므로 !로 값을 드러냄
    // card의 타입은 Int (Int? 가 아님)
    
    println("card \(card)")
    
}else {
    
    println("no card")
}


/*

Runtime Error

Optional Type을 if 문 없이 unwrapping 하여 사용하면 Runtime Error가 발생한다. 더 이상 안전하지 않다.

*/

let numCards2 = ["one" : 1 , "two" : 2, "three" : 3, "four" : 4 , "five": 5]
let myCard2 = numCards2["nine"]    // myCard = nil

//println("\(myCard2!)")      // Runtime Error 발생



/*

Optional Binding

결국 Optional Type을 다룰때는 항상

값 여부를 확인 하고 값이 있으면 unwrapping 하여 사용해야 한다.

그러나 매번 위처럼 단계적으로 처리하는 건 불편하다. Optional Binding은 이를 동시에 할 수 있다.

Optional Binding 포멧은 if let ~ 이다.

*/


let numCards3 = ["one" : 1 , "two" : 2, "three" : 3,
    "four" : 4 , "five": 5]

if let card3 = numCards3["two"] { // 값 체크 & unwapping
    
    println("card \(card3)")  // card 는 Int 타입.
    
}else{
    println("no card")
}

/*

Optional Chaining

코드를 짜다보면 Optional Binding 이 중첩될 수 있다. 반복되는  if let~ 은  귀찮다.

여러 층의 Optional Binding을 한 줄에 쓰게 하는 것이 Optional Chaining이다. (Swift 개발팀에서도 Optional이 불편하긴 했나보다.)

Optional Chaining은 ‘?’ 기호를 사용한다. (Optional Type 선언에 사용하는 ‘?’ 과 동일시 하면 헷갈린다. 비슷하지만 다른것으로 보자.)

*/


/*
// 중첩 Optional Binding
if let home = paul.residence {
    if let postalAddress = home.address{
        if let building = postalAddress.buildingNumber{
            if let convertedNumber = building.toInt(){
                println("building number of paul is \(convertedNumber)")
            }
        }
    }
}

// Optional Chaining
if let addressNumber = paul.residence?.address?.buildingNumber?.toInt(){
    
    println("building number of paul is \(addressNumber)")</pre>
}



코드를 간단히 설명하면 paul 은 class 개체로 Non-Optional Type 이고 나머지 residence, address, buildingNumber 는 Optional Type 이다.

paul 의 집 주소를 알기 위해 Optioanl Binding으로 순차적으로 값을 확인한다. 이를 Optional Chaining 을 이용하면 한 줄에 끝이다.

*/


/*

Optional 과 Enum Pattern Matching

앞서 살펴봤듯이 Optional 은 enum 타입이다.


enum Optional<T>{
case None
case Some(T)
}
따라서 enum을 이용한 Pattern Matching 이 가능하다.

let numberCards : Dictionary<String,Int> = [ "one" : 1, "two" : 2, "three": 3, "four" : 4,
"five" : 5, "six": 6, "seven" : 7]

for num in numberCards.keys{

// Dictionary[key] 리턴은 optional type
switch numberCards[num]{

case .Some(let v) where v > 3 :
println("\(v)")
default:
println("...")

}

}
numberCards[num] 의 리턴값은 Optional Type 이므로 – 여기선 Int? – 위와 같이 switch, enum 을 이용하여 처리할 수 있다.

*/




// 참조 : https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-XID_399

// 참조 : https://soulpark.wordpress.com/2014/06/20/swift-optionals-and-question-mark/