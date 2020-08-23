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

//: [Next](@next)
