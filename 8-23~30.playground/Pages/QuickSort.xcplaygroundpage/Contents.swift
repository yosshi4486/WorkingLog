//: [ログに戻る](8-25)

import Foundation

/*:
## クイックソート
リンク: https://www.codereading.com/algo_and_ds/algo/quick_sort.html
方法:
 > クイックソートは、リストにおいてピポットと呼ぶ要素を軸に分割を繰り返して整列を行うアルゴリズムです。「分割を繰り返して整列を行う」ような手法を分割統治法 divide-and-conquerと呼びます。
 (上記リンクから引用)
 
時間計算量: worth O(n^2), best O(n log n), average O(n log n).
 
*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 1000

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

//: 配列をランダムにシャッフルした後、数値の順番に整列させる。先頭のいくつかの要素を出力しても、混ざっているのが見て取れる。

extension Array where Element == Int {
    
    mutating func quickSort() {
        
        func sort(_ list: [Element]) -> [Element] {
            // 1. 要素数が1かそれ以下なら、整列済みとしてソートを行わない
            guard list.count > 1 else {
                return list
            }
            
            // 2. ピボット要素をピックアップする
            let pivot = list[0]
            
            // 3. ピボット要素を中心とした大小のリストに分割する。
            var lessThanOrEqualToPivot: [Element] = []
            var greaterThanPivot: [Element] = []
            
            // 4.今はピボットとして先頭要素を選択しているので、それを分割したリストに入れないように注意して1..<list.countで進める
            // ピボットとして中央値を選択するような場合は、それを走査の対象に含めないように。
            for i in 1..<list.count {
                if list[i] <= pivot {
                    lessThanOrEqualToPivot.append(list[i])
                } else {
                    greaterThanPivot.append(list[i])
                }
            }
            
            // 5. 再帰的にこの操作を繰り返していくことで、ソート済みの配列が得られる。
            lessThanOrEqualToPivot = sort(lessThanOrEqualToPivot)
            greaterThanPivot = sort(greaterThanPivot)
//            print("left: \(lessThanOrEqualToPivot)")
//            print("pivot: \(pivot)")
//            print("right: \(greaterThanPivot)")
            return lessThanOrEqualToPivot + [pivot] + greaterThanPivot
        }
        
        self = sort(self)
    }
    
}

Benchmark.measure(key: "Inseration Sort") {
    dataSource.quickSort()
}

dataSource

assert(dataSource == Array<Int>(0...numberOfItems))

/*:
 ## ベンチマーク
 ### n=100
 0.089(s)
 
 ### n=500
 0.685(s)
 
 ### n=1000
 1.741(s)
 
 */
//: [Next](@next)
