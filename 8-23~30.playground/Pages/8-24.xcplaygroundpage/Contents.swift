import UIKit

/*:
 # きょうの作業ログ　2020/08/24
 朝一番、一時間を目処にこの「アルゴリズムとデータ構造」の内容を一通りさらっていきます。
 
 https://www.codereading.com/algo_and_ds/
 
 ・PlaygroundsのSourcesの下においてもアクセスコントロールをpublicにしないと参照できない。
 
 ・各種アルゴリズムのベンチマークを取ってみる。10000回検索を回す。1000の理由は、10万だと実行者が長すぎると感るし、1000回だとハッキリわかるほど差が出ない。1万だとちょうど良い。各自10, 100倍を脳内で実行してもらいながら見てもらえれば良いかと思う。
 
 ## リニアサーチ
 前提条件: なし
 方法: 配列の頭から順番に対象を検索する
 時間計算量: O(n)
 
 */

var dataSource: [Int] = Array<Int>(0...10000)

let linearSeach = Benchmark(key: "Linear Seach")
for i in 0...10000 {
    assert(dataSource.firstIndex(of: i) == i)
}
linearSeach.finish()

//: 実行環境に依存するが、自分の環境だと7~8秒ぐらいかかる。

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
