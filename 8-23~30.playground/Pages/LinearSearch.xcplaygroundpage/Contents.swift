//: [ログに戻る](8-24)

import Foundation

/*:
## リニアサーチ
前提条件: なし
方法: 配列の頭から順番に対象を検索する
時間計算量: O(n)

*/

var dataSource: [Int] = Array<Int>(0...10000)

Benchmark.measure(key: "Linear Search") {
    for i in 0...10000 {
       assert(dataSource.firstIndex(of: i) == i)
    }
}

//: 実行環境に依存するが、自分の環境だと7~8秒ぐらいかかる。

//: [Next](@next)
