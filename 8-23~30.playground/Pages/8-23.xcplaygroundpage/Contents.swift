import UIKit

/*:
 きょうの作業ログ　2020/08/23
 ・今日からページを活用して一週間ごとに進めるようにしてみた。一日ごとに区切っていると、Playgroundの記法を十分に使いこなす機会がないなぁと思ったため。
 
 ・Playgroundは//: [Previous](@previous)とすると、前のページへのリンクになる。この前のページというのは、ページヒエラルキーで上に位置しているPlaygroundPageのこと。
 
 そして//: [Next](@next)とすると、次のページへのリンクになる。
 
 任意のページへのリンクも作成可能で、
 //: [Sapmpe](SamplePage)などで使える。
 
 ・新規ページの作成は右下のプラスボタンを押すとできるようになる。
 */

let image = UIImage(named: "NewPlaygroundPage")

//: UIImageってNSObjectを継承しているけど、UIViewを継承しているわけではないので上記のように表示可能なんだけど、SwiftUIのImageってそれ自体がViewなので、うまく表示できない。
import SwiftUI

let swiftUIImage = Image("NewPlaygroundPage")

//: ↑なんか真っ黒になる。これどうにかしたいけど、しゃあない。

/*:
 ・zip関数は辞書型(Dictionary)を取り回したいときに便利
 */

var dictionary: [Int: String] = [:]
let keyArray = [1, 2, 3]
let valueArray = ["a", "b", "c"]
let tuppled = zip(keyArray, valueArray)
dictionary.merge(tuppled) { (current, new) in current } // keyが衝突(Collision)したときに、どちらを優先するかという

/*:
 
 ・配列やLinkedListの場合、線形探索の必要があり、O(n)のコストがかかる。BinarySeachTreeの場合は検索をO(log n)でできるが、挿入・削除はコストが掛かる。
 
 ・Balanced Binary Search Treeは検索、挿入、削除をO(log n)で実行可能。
 
 ・Direct Access Tableは、でっかい配列を用意して、それにindexでアクセスすれば、常にアクセスはO(1)よね。というやつ。例えば小さい数でやるけど、電話番号が4桁だとして、電話番号でアクセスできるテーブルを作れば良い。
 */

class Record {
    var name: String = ""
    var phoneNumber: Int = 0
    
    init(name: String = "", phoneNumber: Int = 0) {
        self.name
        self.phoneNumber = phoneNumber
    }
}
var array: [Record] = .init(repeating: Record(), count: 1000)

let newRecord = Record(name: "yosshi", phoneNumber: 345)
array[newRecord.phoneNumber] = newRecord

//: このように、レコードの何かしらの整数型のプロパティが取りうる最大数の配列を作って、中にはポインタを格納すれば(swiftのクラスの変数は実体へのポインタ)アクセスは常にO(n)、ただしinsertとかは配列のズラしが発生するので最悪O(n)の時間計算量になる。このDirect Access Tableの悪いところは、キーに利用する数値の取りうる数だけ配列の要素を用意しないといけないところにあり、無駄なメモリを消費してしまうところ。実際には電話番号は10桁とかなので、このテーブルには100億個のレコードを格納可能なスペースが必要になる。

/*:
 これを改善するのがHashingになる。
 Hash化は、ちょうどこのDirectAccessTableを改良したもので、ハッシュ関数によってキーをハッシュ化して小さな番号に変更し、それをキーとしてハッシュテーブルに格納して利用する。
 
 */

Int64(0).hashValue
Int64(9223372036854775807).hashValue // Int64の最大値
 
/*:
 ・このように、ハッシュ値は元の値の大小にかかわらず、同じようなサイズの数値を返す。ハッシュ化は実行するごとに値が変わる。
 
 ・ちょと作ってみたいけど、夜にしよう。それもiPadで良いや。
 
 https://www.geeksforgeeks.org/implementing-our-own-hash-table-with-separate-chaining-in-java/
 
 ・こういう風に、ちょっと試したいことがあるときにPlaygroundが立ち上がりっぱなしだと便利。コードを軽く書いて試せるので。
 
 */

struct SomeType {
    var dictionary: [Int : String] = [0:"Foo", 1: "Bar", 2: "FooBar"]
}

dump(SomeType())

//: [Next](@next)
