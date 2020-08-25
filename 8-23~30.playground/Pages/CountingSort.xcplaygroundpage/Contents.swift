//: [ログに戻る](8-25)

import Foundation

/*:
## 分布数え上げソート(Conting Sort)
リンク: 　https://www.codereading.com/algo_and_ds/algo/counting_sort.html
概念: ソート対象のデータをキーとして、その出現回数と累積度数分布を計算して利用する。
時間計算量: worth O(n + k) k=number of buckets
特徴: 重複を取り扱えるバケツソートみたいな感じ
*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 1000

var dataSource: [Int] = Array<Int>(0...numberOfItems) + Array<Int>(0...numberOfItems)
dataSource.shuffle()

extension Array where Element == Int {
    
    mutating func countingSort(maximumValue: Int) {
        var counting = Array<Int>(repeating: 0, count: maximumValue+1)
        
        for element in self {
            counting[element] += 1
        }
        
        var sorted: [Int] = []
        for (index, counted) in counting.enumerated() {
            if counted != 0 {
                sorted.append(contentsOf: Array(repeating: self[index], count: counted))
            }
        }
        self = sorted
    }
    
    
}

Benchmark.measure(key: "Counting Sort") {
    dataSource.countingSort(maximumValue: numberOfItems)
}

import XCTest
let expectedItem: [Int] = {
    var array: [Int] = []
    
    for i in 0...100 {
        array.append(i)
        array.append(i)
    }
    
    return array
    
}()

XCTAssertEqual(dataSource, expectedItem)


/*:
 ## ベンチマーク
 ### n=100
 0.071(s)
 
 ### n=500
 0.277(s)
 
 ### n=1000
 0.646(s)
 
 */
//: [Next](@next)
