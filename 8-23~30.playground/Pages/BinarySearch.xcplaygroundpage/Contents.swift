//: [ログに戻る](8-24)

import Foundation

/*:
 ## 二分探索(バイナリサーチ)
前提条件: ソート済み配列

方法: 検索する間隔を半分に分割しながらデータを探し出すアルゴリズム

時間計算量: O(log)

### 時間計算量の計算
データの総数がn、探索回数をmとするとき、探索一回につき探索空間が半分になる。というのは以下のように書ける。

> n = 2 ^ m ... (1)

両辺に自然対数を取る

> ln(n) = ln(2 ^ m) ...(2)

対数の法則によりmを頭に出す

> ln(n) = m * ln(2) ... (3)

両辺をln(2)で割る

> m = ln(n) / ln(2) ... (4)

このとき、ln(2)は定数項であり(≒0.69)、より詳細に書けば以下のようになる。

> m = (1 / ln(2)) * ln(n) ... (5)

時間計算量の表記では、次数がもっとも高いものだけ選び、その係数を飛ばして書くため、この時間計算量は

> **O(log n)**

となる。

*/

var dataSource: [Int] = Array<Int>(0...10000)

extension Collection where Element == Int, Index == Int {
   
   func binarySearchfirstIndex(of element: Int) -> Int? {
       var low = 0
       var high = count - 1
       var mid: Int = 0
       
       while low <= high {
           mid = (low + high) / 2
           
           if element == self[mid] {
               return mid
           } else if element > self[mid] {
               low = mid + 1
           } else {
               high = mid - 1
           }
       }
       
       return nil
   }
   
}

let binarySearch = Benchmark(key: "Binary Search")
for i in 0...10000 {
   assert(dataSource.binarySearchfirstIndex(of: i) == i)
}
binarySearch.finish()

//: 実行環境に依存するが、自分の環境だと4秒ぐらいかかる。

//: [Next](@next)
