//: [ログに戻る](8-25)

import Foundation

/*:
## マージソート
リンク: https://www.codereading.com/algo_and_ds/algo/merge_sort.html
概念: 未整列のリストを2つに分割して、それぞれを整列させた後、それをマージして整列済みリストを作る
仕様: マージの際は、マージ元の二つの要素の先頭を見て、小さいをpopし、新しい方にpushする。
実装:
時間計算量: worth O(n log n), best O(n log n), average O(n log n)
特徴: ランダムなデータでは、通常クイックソートの方が速い。
*/

//: ここを任意の数値に置き換えて実行してください。
let numberOfItems = 1000

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

extension Array where Element == Int {
    
    mutating func margeSort() {
        self = _margeSort(self)
    }
    
    // Arrayを何回も内部で作成すると効率が悪そうなので、出来る限りArraySliceを利用する形で進める。
    private func _margeSort(_ list: [Element]) -> [Element] {
        guard list.count > 1 else {
            return list
        }
        
        // 1. リストを分割する
        let middle = (list.count - 1) / 2
        var left: [Element] = Array(list[0...middle])
        var right: [Element] = Array(list[(middle+1)...])

        // 2. 各個数が1になるまで再帰処理させる
        left = _margeSort(left)
        right = _margeSort(right)

        return marged(left: left, right: right)
    }
    
    private func marged(left: [Element], right: [Element]) -> [Element] {
        // コピー
        var left = left
        var right = right
        
        var marged: [Element] = .init()

        // 3. どちらかが空になるまでmargeを続ける
        // popFirstをうまく活用してみている。
        while !left.isEmpty || !right.isEmpty {
            guard let leftFirst = left.first, let rightFirst = right.first else {
                break
            }
            
            if leftFirst <= rightFirst {
                marged.append(leftFirst)
                left.removeFirst()
            } else {
                marged.append(rightFirst)
                right.removeFirst()
            }
        }

        // 4.残った要素を末尾につける。
        if !left.isEmpty {
            marged.append(contentsOf: left)
        } else {
            marged.append(contentsOf: right)
        }
        return marged
    }
    
}

Benchmark.measure(key: "Marge Sort") {
    dataSource.margeSort()
}

import XCTest
XCTAssertEqual(dataSource, Array<Int>(0...numberOfItems))

/*:
 ## ベンチマーク
 ### n=100
 0.322(s)
 
 ### n=500
 0.904(s)
 
 ### n=1000
 2.145(s)
 
 */
//: [Next](@next)
