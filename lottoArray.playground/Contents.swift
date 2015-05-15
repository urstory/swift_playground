//: Playground - noun: a place where people can play

import UIKit

var lottoArray = [Int](count: 45, repeatedValue: 0)
for index in 0..<lottoArray.count {
    lottoArray[index] = index + 1
}

println(lottoArray)

var index0 = 0
var index1 = 0
for _ in 0...100{
    index0 = Int(arc4random_uniform(45)) // 0 <= x < 45
    index1 = Int(arc4random_uniform(45))
    if index0 != index1 {
        var tmp = lottoArray[index0]
        lottoArray[index0] = lottoArray[index1]
        lottoArray[index1] = tmp
    }
}

println(lottoArray)

for index in 0...5 {
    println(lottoArray[index])
}







//45
//6
//14
//27
//28
//15