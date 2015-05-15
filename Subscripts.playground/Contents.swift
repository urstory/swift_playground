/*


서브스크립트 (Subscripts)

클래스, 구조체 그리고 열거형은 collection, list, sequence의 member element에 접근하기 위한 축약형인 서브스크립트로 정의할 수 있습니다. 또한 값의 설정이나 검색을 위한 별도의 메서드(seperate method)없이 index를 통해서 값을 설정하거나 검색하기 위해 서브스크립트를 사용할 수있습니다. 예를 들어서 someArray[index]와 같이 배열의 내부값(element)에 접근하거나 someDictionary[key]와 같이 사용하여 딕셔너리의 내부값(element)에 접근할 수 있습니다.

한 타입을 위해서 여러개의 서브스크립트를 정의 할 수도 있고, 또한 서브스크립트로 넘기는 index값의 타입을 기초로하여 사용하기 적절한 서브스크립트 overload(중복)를 선택할수 있다. 서브스크립트는 당신이 원하는 타입에 맞게 여러개의 입력 파라미터(input parameter)를 가지도록 정의할 수도 있다.

서브스크립트 문법(Subscript Syntax)

서브스크립트는 인스턴스의 이름 뒤에 있는 '[]'안에 한개 이상의 값을 적는 것으로 당신이 인스턴스들의 타입(instances of a type)를 요구할 수 있다. 그들의 문법은 인스턴스의 메서드나 computed property의 문법과 유사합니다. 인스턴스의 메서드들과 동일한 방식으로 subscript키워드와 함께 특정한 하나 이상의 입력 파라미터와 와 리턴타입을 통해서 서브스크립트를 정의할 수 있다. 다만 인스턴스의 메서드들과는 달리 서브스크립트는 읽고 쓰는 권한만 있거나 읽는 권한만을 가질 수 있다. 다음 코드는 서브스크립트가 computed property들과 동일한 방식으로 getter와 setter를 통해 작업하는 것을 보여줍니다

subscript(index: Int) -> Int {
get {
// return an appropriate subscript value here
}
set(newValue) {
// perform a suitable setting action here
}
}
newValue의 type은 해당 subscript의 리턴값과 동일합니다. computed properties와 같이 당신은 setter의 파라미터인 (newValue)를 특정하게 선택할수 없습니다. 만일 당신이 setter를 위한 타입을 아무것도 제공하지 않는다면, 그제서야 기본 parameter인 newValue가 setter를 위해 제공될 것입니다.

읽기 전용의 computed properties와 같이 get 키워드를 없애서 읽기 전용의 서브스크립트를 만들 수 있다.:

subscript(index: Int) -> Int {
// return an appropriate subscript value here
}

*/


struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
println("six times three is \(threeTimesTable[6])") // 18


/*

중요!

n배 테이블은 고정된 숫자값을 출력하는 규칙에 기반합니다. 따라서 newValue등을 통하여 treeTimesTable[someindex]를 따로 설정하는 것은 적절하지 않으며 그러기에 위의 TimesTable을 위한 서브스크립트는 읽기전용의 서브스크립트로 선언되었습니다.

*/




/*

서브스크립트 사용(Subscript Usage)

아주 정확한 의미의 "subscript"는 그것이 사용되는 문맥에 따라 결정된다. 서브스크립트는 일반적으로 collection, list, 또는 sequence에 특정 member elements에 접근하기 위한 단축형이라는 의미로 사용되며, 당신은 특별한 클래스나 구조체의 기능을 위해 적절한 방식으로 자유롭게 대부분의 서브스크립트를 구현할 수있다. 예를 들어서 Swift의 Dictionary 타입은 Dictionary 인스턴스에 저장된 값들을 설정하고 검색하기 위한 하나의 서브스크립트로 구현했다. 당신은 딕셔너리 안에 딕셔너리의 키의 타입의 키값을 서브스크립트의 '[]'안에 넣는 것으로 값을 세팅할 수 있으며 딕셔너리 안에 들어갈 값을 서브스크립트에 할당할 수도 있다:

*/


var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2


/*

중요!

 Swift의 딕셔너리 타입은 내부적인 key-value 서브스크립트가 요구하고 반환하는 타입이 옵셔널 타입인 서브스크립트로 구현하였습니다. 위에서 numberOfLegs 딕셔너리를 보면, key-value 서브스크립트를 요구하고 반환하는 타입이 Int일까요?, 그렇지 않으면 옵셔널 Int일까요? 딕셔너리 타입은 '모든 키가 값을 가지는 것은 아니다'라는 사실을 위한 모델을 지원하기 위해 옵셔널 서브스크립트 타입을 사용합니다. 그리고 어떤 키에 값을 삭제하는 방법을 제공하는데, 이 경우 해당 키값의 값는 nil로 할당된다.

*/


/*

서브스크립트 옵션(Subscript Options)

서브스크립트는 어떠한 숫자의 입력 파라미터들도 처리가 가능하다.그리고 그리고 이 입력 파라미터들은 어떠한 타입도 가능하다. 서브스크립트는 또한 어떠한 타입으로도 리턴이 가능하다. 서브스크립트는 변수 파라미터와 variadic parameters도 가능하지만, in-out parameters 나 default parameter 값은 지원하지 않습니다. 클래스나 구조체는 필요한 만큼의 서브스크립트를 구현하는 것이 가능하며, 적절한 서브스크립트는 보통 각각의 서브스크립트가 사용되는 요소요소에서 서브스크립트에 포함되어 서로 대비하도록 한 값이나 값들의 타입이 기초라고 생각할 수 있습니다. 이러한 다수의 서브스크립트에 관한 정의는 서브스크립트 overloading으로도 알려져 있습니다. 대부분의 한개의 파라미터만을 요구하는 서브스크립트와는 다르게, 만일 당신이 만들 것에 필요하다면, 다수의 파라미터를 요구하는 서브스크립트를 선언할 수도 있습니다.

*/


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}



var matrix = Matrix(rows: 2, columns: 2)

//  0   0
//  0   0


matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

// 0   1.5
//3.2   0


let someValue = matrix[0, 1]
//let someValue = matrix[2, 2]
//assert에 위하여 위의 코드를 실행하면 중지 된다.
println(someValue)





