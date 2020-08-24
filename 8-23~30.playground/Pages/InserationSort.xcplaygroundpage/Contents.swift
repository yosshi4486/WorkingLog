//: [ログに戻る](8-24)

import Foundation

/*:
## 挿入ソート
リンク: https://www.codereading.com/algo_and_ds/algo/insertion_sort.html
前提条件: 整列済みリスト
方法: 新しい要素を適切な位置に挿入することで整列を行う
時間計算量: O(n^2)
使い所:
 
 >　整列済みのリストの後ろにいくつかの要素を追加して再び整列させるという場合や、一方の整列済みリストに整列されていない他方のリストを追加しながら整列させたい時に威力を発揮します。

 交換回数はバブルソートと変わらないが、比較回数が少なくなる。
*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 100

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

//: 配列をランダムにシャッフルした後、数値の順番に整列させる。先頭のいくつかの要素を出力しても、混ざっているのが見て取れる。

extension MutableCollection where Element : Comparable, Index == Int {
    
    mutating func inserationSort() {
        for i in 1..<count {
            for j in stride(from: i, through: 1, by: -1) where self[j] < self[j-1] {
                swapAt(j-1, j)
            }
        }
    }
    
}

Benchmark.measure(key: "Inseration Sort") {
    dataSource.inserationSort()
}

print(dataSource)

assert(dataSource == Array<Int>(0...numberOfItems))

/*:
 ## Strideの挙動
 */
print("------------------------------------")
for i in stride(from: 0, to: 100, by: 5) {
    print("from:to:by, upward, index:\(i)")
}
print("------------------------------------")
for i in stride(from: 0, through: 100, by: 5) {
    print("from:through:by, upward, index:\(i)")
}
print("------------------------------------")
for i in stride(from: 100, to: 0, by: -5) {
    print("from:to:by, downward, index:\(i)")
}
print("------------------------------------")
for i in stride(from: 100, through: 0, by: -5) {
    print("from:through:by, downward, index:\(i)")
}
print("------------------------------------")

//: toはその要素を含まない。UpwardをRange記法すると0..<100、throughはその要素を含むのでRange記法だと0...100に相当する。
//: [Next](@next)
