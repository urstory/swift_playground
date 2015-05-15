// 정수를 문자열로, 문자열을 정수로 변환하는 방법

let x : Int = 42
var myString = String(x)

let i: Int? = myString.toInt()

if (i != nil) {
    println(i!)
}

import Foundation // 를 사용하려면 필요함

let sString = "236.86"
var dNumber = NSNumberFormatter().numberFromString(sString)

var dNumber2:Double = ("236.4" as NSString).doubleValue


let str = NSString(format: "%.2f", 1.23)



// Swift random 값 구하기
// arc4random_uniform(n) for a random integer between 0 and n-1
// standard c lib
  let randomValue = Int(arc4random_uniform(7))

// dice
for _ in 1...10 {
    let diceRoll = Int(arc4random_uniform(6)) + 1
    println(diceRoll)
}

println("-------------------------------------")

var k: Int = random() % 10;
println(k)



extension UInt32 {
     static func random(max: UInt32) -> Int {
        var random = Int(arc4random_uniform(max)) + 1
        return random
    }
}

for _ in 1...10 {
    println(UInt32.random(6))
}

// 배열 섞기
var list = [1,2,3,4,5,6,7,8]
let c = count(list)
for i in 0..<(c - 1) {
    let j = Int(arc4random_uniform(UInt32(c - i))) + i
    swap(&list[i], &list[j])
}
println(list)


// 배열 섞기 함수 이용
func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
    let c = count(list)
    for i in 0..<(c - 1) {
        let j = Int(arc4random_uniform(UInt32(c - i))) + i
        swap(&list[i], &list[j])
    }
    return list
}
shuffle([1, 2, 3, 4, 5, 6, 7, 8])        // e.g., [6, 1, 8, 3, 2, 4, 7, 5]
shuffle(["hello", "goodbye", "ciao"])    // e.g., ["ciao", "goodbye", "hello"]


// 배열 섞기 확장 이용 (shuffle as a mutating array method)
extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}
var numbers = [1, 2, 3, 4, 5, 6, 7, 8]
numbers.shuffle()                     // e.g., numbers == [6, 1, 8, 3, 2, 4, 7, 5]


// 배열 섞기 확장 이용 (shuffled as a non-mutating array method)
extension Array {
    func shuffled() -> [T] {
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
}
let numbers2 = [1, 2, 3, 4, 5, 6, 7, 8]
let mixedup = numbers2.shuffled()     // e.g., mixedup == [6, 1, 8, 3, 2, 4, 7, 5]




