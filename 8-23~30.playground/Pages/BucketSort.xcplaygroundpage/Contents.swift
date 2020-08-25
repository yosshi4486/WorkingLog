//: [ログに戻る](8-25)

import Foundation

/*:
## バケットソート(ビンソート)
リンク: https://www.codereading.com/algo_and_ds/algo/bucket_sort.html
概念:  あらかじめ、データのとりうる最小値と最大値をみて、その区間の配列を用意しておき、整列対象配列の要素をそのバケツに移動し、バケツの先頭からからではない値を取り出すことでソートを行う。
時間計算量: worth O(n^2), best O(n), average O(n + k) k=number of buckets
特徴: 比較を用いない整列アルゴリズム。とりうる値が大きいほど、確保する領域が肥大する。重複が許されない。
*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 100

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

extension Array where Element == Int {
    
    mutating func bucketSort(maximumValue: Int) {
        var buckets = Array<Int?>(repeating: nil, count: maximumValue+1)
        
        for element in self {
            buckets[element] = element
        }
        
        var sorted: [Int] = []
        for content in buckets {
            if let aContent = content {
                sorted.append(aContent)
            }
        }
        self = sorted
    }
    
    
}

Benchmark.measure(key: "Bucket Sort") {
    dataSource.bucketSort(maximumValue: numberOfItems)
}

import XCTest
XCTAssertEqual(dataSource, Array<Int>(0...numberOfItems))

/*:
 ## ベンチマーク
 ### n=100
 0.066(s)
 
 ### n=500
 0.238(s)
 
 ### n=1000
 0.531(s)
 
 */
//: [Next](@next)
