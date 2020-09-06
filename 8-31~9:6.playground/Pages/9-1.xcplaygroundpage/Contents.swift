import UIKit

/*:
 # きょうの作業ログ　2020/09/01
 ・WWDCに日本語がついたらしくて、セッションを流している。
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

/*:
 ・
 */

// フラットツリーの難点は、要素のインデックスが固定ではない。要素の挿入や削除によってズレること。

/*:
 テーブル用のフラットツリーで実現したい要件
 1. 要素への早いアクセスO(1)かO(log n)
 2. 挿入、追加、削除操作での適切なインデックス構築
 3. インデックス通りに並べたデータを返す
 
 インデックスが正しく構築さえされていれば、O(n)でfilterして要素を返す程度大した問題にならない。
 
 今、要素の変更ごとに必ずO(n)の時間計算量が発生するようにしているので、そこを改善しよう。
 */

struct Record<ItemIdentifier> where ItemIdentifier : Hashable {
    var index: Int
}

struct TableIndex<ItemIdentifier> where ItemIdentifier : Hashable {
    
    var indentationLevel: Int
    
    var startIndex: Int
    
    var numberOfItems: Int {
        return records.count
    }
    
    var records: [Record<ItemIdentifier>] = []
}

struct FlatTree<ItemIdentifier> where ItemIdentifier : Hashable  {
    var recordTable: [ItemIdentifier : Record<ItemIdentifier>] = [:]
    var indexes: [TableIndex<ItemIdentifier>] = []
    
    func append(_ children: [ItemIdentifier], to parent: ItemIdentifier?) {
        
    }
    
    func index(of identifier: ItemIdentifier) -> Int? {
        return recordTable[identifier]?.index
    }
    
}
