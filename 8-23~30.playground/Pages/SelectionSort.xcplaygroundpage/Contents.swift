//: [ログに戻る](8-24)

import Foundation

/*:
## 選択ソート
前提条件: なし
方法: 配列の最小値(最大値)を持つ要素を、配列の先頭と交換することでソートを行うアルゴリズム
時間計算量: worth O(n^2), best O(n^2), average O(n^2)

 バブルソートは、隣あう数字の大小によって交換を平均n/2回行うが、選択ソートは一回の走査で一度しか交換を行わない。
*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 1000

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

dataSource[0...5]

//: 配列をランダムにシャッフルした後、数値の順番に整列させる。先頭のいくつかの要素を出力しても、混ざっているのが見て取れる。

extension MutableCollection where Element : Comparable, Index == Int {
    
    mutating func selectionSort() {
        for outerRoopIndex in 0..<self.count-1 {
            var min = outerRoopIndex
            for innerRoopIndex in (outerRoopIndex..<self.count) {
                if self[innerRoopIndex] < self[min] {
                    min = innerRoopIndex
                }
            }
            swapAt(outerRoopIndex, min)
        }
    }
    
}

Benchmark.measure(key: "Selection Sort") {
    dataSource.selectionSort()
}

assert(dataSource == Array<Int>(0...numberOfItems))

/*:
 ## ベンチマーク結果
 時間かかるの大変なので、各種1回ずつしか実行していいないです。
 
 ### n=100
 2.025
 
 ### n=500
 28.833
 
 ### n=1000
 161.429s
 
 */

//: [Next](@next)
