import UIKit

/*:
 # きょうの作業ログ　2020/09/01
 ・WWDCに日本語がついたらしくて、セッションを流している。しばらくこういう生活にしよう、興味ないセッションも流しっぱなし、情報が一ミリでも脳みそに引っ掛かっていればよし。
 ・宣言していた通り、今日から製品の実装に復帰。一週間の間、探索&ソート&木構造の学習と、グラフ理論入門の第5章(有向多重グラフ)までやれた。肝心要の第7章「木」まで辿り着けなかったので、毎日1~2時間やりつつカバーしていこうと思う。
 ・集合の軽い勉強も出来て、それにより集合学習へのモチベーションも上がってきたので、いい感じにやっていこう。
 ・superclassとsubclassがsupersetとsubsetの包含関係であることは分かったので、あとは集約やコンポジション、プロトコルなどの関係を考えていきたい。
 */

protocol Barkable {
    func bark()
}

protocol Animal {
    associatedtype Owner
    var owner: Owner { get set }
}

struct Human { }

struct Dog : Barkable, Animal {
    typealias Owner = Human
    
    var owner: Owner
    func bark() {
        print("Bah!!")
    }
    
}

class BaseAnimal { }

class BarkableAnimal : BaseAnimal {
    func bark() {
        print("Bah!!")
    }
}

class ClassDog : BarkableAnimal {
    var owner: Human? = nil
}

//: 例えば、このようなDogとBarkable, Animalとの関係はどのように捉えることが出来るか？という。Dogは複数の集合の部分集合からできている集合であると捉えられるけど、単一継承的な概念構成とどのように差が’あるか？ということを論じたい(でも今知識不足でできない)という
