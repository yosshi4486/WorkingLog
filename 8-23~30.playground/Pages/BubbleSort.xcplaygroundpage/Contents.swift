//: [ログに戻る](8-24)

import Foundation

/*:
## バブルソート
前提条件: なし
方法: 隣あう2つの要素の値を比較して、条件に応じた交換を行う整列アルゴリズム
時間計算量: O(n^2)

*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 500

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

dataSource[0...5]

//: 配列をランダムにシャッフルした後、数値の順番に整列させる。先頭のいくつかの要素を出力しても、混ざっているのが見て取れる。

extension MutableCollection where Element : Comparable, Index == Int {
    
    mutating func bubbleSort(desending: Bool = true) {
        for outerRoopIndex in 0..<self.count-1 {
            for innerRoopIndex in (outerRoopIndex...self.count-1).reversed().dropLast() {
                if self[innerRoopIndex] < self[innerRoopIndex-1] {
                    swapAt(innerRoopIndex, innerRoopIndex-1)
                }
            }
        }
    }
    
}

Benchmark.measure(key: "Bubble Sort") {
    dataSource.bubbleSort()
}

assert(dataSource == Array<Int>(0...numberOfItems))

/*:
 ## ベンチマーク結果
 ### n=100
 0.849s
 
 ### n=500
 29.276
 
 ### n=1000
 166.526s
 
 例えばTableViewの要素のソートに、こんな170秒弱もかかっていたらユーザーキレて帰ってしまう。
 */

//: [Next](@next)
