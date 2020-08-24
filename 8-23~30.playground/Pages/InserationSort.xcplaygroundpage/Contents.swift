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

*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 100

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

//: 配列をランダムにシャッフルした後、数値の順番に整列させる。先頭のいくつかの要素を出力しても、混ざっているのが見て取れる。

extension MutableCollection where Element : Comparable, Index == Int {
    
    mutating func inserationSort(desending: Bool = true) {
        for i in 1..<count {
            var j = i
            
            // 既にソートずみの配列に、新しい配列を足してソートするような場合に、
            // 挿入ソートは頭から走査するが、ソート済みの場合は二重目のループに入らなくても良くなるのでO(n)に近くなる。
            while j > 0 && self[j] < self[j-1] {
                swapAt(j-1, j)
                j -= 1
            }
        }
    }
    
}

Benchmark.measure(key: "Inseration Sort") {
    dataSource.inserationSort()
}

assert(dataSource == Array<Int>(0...numberOfItems))

//: [Next](@next)
