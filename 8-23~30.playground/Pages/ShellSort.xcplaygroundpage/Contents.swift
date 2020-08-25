//: [ログに戻る](8-24)

import Foundation

/*:
## シェルソート
リンク: https://www.codereading.com/algo_and_ds/algo/shell_sort.html
前提条件: 整列済みリスト
方法: 新しい要素を適切な位置に挿入することで整列を行う。挿入ソートが隣り合う要素を比較/交換していくのに対し、シェルソートはhずつ離れた要素を交換する。
時間計算量: worth O(n^2), best O(n log n), average depends on stride.
挿入ソートの改良版ソートアルゴリズム
 
 stridenの選び方で時間計算量が変わる。このサンプルでは簡単さのために、要素数の半分を初期値にし、その後も半分にし続けている。
 
*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 500

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

//: 配列をランダムにシャッフルした後、数値の順番に整列させる。先頭のいくつかの要素を出力しても、混ざっているのが見て取れる。

extension MutableCollection where Element : Comparable, Index == Int {
    
    mutating func shellSort() {
        var sortStride = count / 2
        
        while sortStride > 0 {
            for i in 1..<count {
                /// j-sortStrideの添字アクセスするので、添字がマイナスにならないように条件付けしないといけない。
                for j in stride(from: i, through: sortStride, by: -sortStride) where self[j] < self[j-sortStride] {
                    swapAt(j-sortStride, j)
                }
            }
            
            if sortStride / 2 != 0 {
                sortStride /= 2
            } else if (sortStride == 1) {
                sortStride = 0
            } else {
                sortStride = 1
            }
        }
    }
    
}

Benchmark.measure(key: "Inseration Sort") {
    dataSource.shellSort()
}

dataSource

assert(dataSource == Array<Int>(0...numberOfItems))

/*:
 ## ベンチマーク
 ### n=100
 0.168(s)
 
 ### n=500
 1.648(s)
 
 ### n=1000
 5.082(s)
 
 */
//: [Next](@next)
