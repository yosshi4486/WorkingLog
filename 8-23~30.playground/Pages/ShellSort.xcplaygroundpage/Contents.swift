//: [ログに戻る](8-24)

import Foundation

/*:
## シェルソート
リンク: https://www.codereading.com/algo_and_ds/algo/shell_sort.html
前提条件: 整列済みリスト
方法: 新しい要素を適切な位置に挿入することで整列を行う。挿入ソートが隣り合う要素を比較/交換していくのに対し、シェルソートはhずつ離れた要素を交換する。
時間計算量: O(n^2)
挿入ソートの改良版ソートアルゴリズム
 
*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 100

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

//: 配列をランダムにシャッフルした後、数値の順番に整列させる。先頭のいくつかの要素を出力しても、混ざっているのが見て取れる。

//extension MutableCollection where Element : Comparable, Index == Int {
//    
//    mutating func shellSort(desending: Bool = true) {
//        var sortStride = count / 2
//        
//        while sortStride > 0 {
//            for i in 0..<count {
//                for j in stride(from: i, to: sortStride - 1, by: <#T##Comparable & SignedNumeric#>)
//                var j = i
//                
//                while j >= sortStride && self[i] < self[j-sortStride] {
//                    swapAt(j, j-sortStride)
//                    j -= sortStride
//                }
//            }
//            
//            if sortStride / 2 != 0 {
//                sortStride /= 2
//            } else if (sortStride == 1) {
//                sortStride = 0
//            } else {
//                sortStride = 1
//            }
//        }
//    }
//    
//}
//
//Benchmark.measure(key: "Inseration Sort") {
//    dataSource.shellSort()
//}
//
//assert(dataSource == Array<Int>(0...numberOfItems))
//
////: [Next](@next)
