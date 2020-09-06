//: [Previous](@previous)

import Foundation

/*:
 # きょうの作業ログ　2020/09/06
 ・FlatTreeの実装は何回か完成したものの、いきあたりばったりなのでパフォーマンスが出ない。最初は木全体をトラバースして再設定するようにしてみて、次は`setNeedsReindexing`でマーク付けしたノードより左の部分木を刈り取る実装を試してみたけど、公式の実装が異常に高速で再現できない。
 14948件のデータ追加をforで回して、最初の500件の間は1回あたりの処理時間が0.00023sec。最後の500件の一回あたりの処理時間が0.00100sec。
 ・ベンチマークとしていくつか処理を実行してみる。
 */

func testSort() {
    var randomArray = Array(0...14948)
    randomArray.shuffle()
    
    /// - Complexity: O(n log n)　準線型時間
    randomArray.sort() // 0.0118秒
}

func testInsert() {
    var randomArray = Array(0...14948)
    randomArray.shuffle()
    
    /// - Complexity: O(n)
    randomArray.insert(0, at: 5000) // 0.0000164

}

/*:
 ・ベンチマークを取ると、準線型時間の処理よりも早く、線型時間の処理より重いくらいなので、O(n)だけど次数や係数を飛ばさずに厳密に計算するとステップ数はnより多い(10nとか)感じなんかな。
 */

//: [Next](@next)
