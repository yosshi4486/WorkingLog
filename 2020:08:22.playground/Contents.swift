import UIKit

/*:
 # きょうの作業ログ　2020/08/22
 ・macOS betaのバージョンをあげるたびに入力ソースがバグっていつもの入力が出来なくなってしまう。まぁベータやからしゃーない。
 
 ・https://twitter.com/yosshi_4486/status/1297027064248193025
 
 ・いい感じに考えている事を言語化できるようになってきた。
 
 ・コミットのPrefixって雰囲気で使ってるけど、もしかしてあれってCIとの連携を基本に考えられてる？Angularで使われているのは知っている
 
 ・あ〜なるほど。入れ子のテーブル構造をフラットに扱おうとすると、アイテムをHashableにして、HashableItem + MetaDataにすると常にO(1)アクセス出来るのか。内部でTree構築するやり方だと、何かとO(n)かかりがちだったので、ずっと不審だった。なるほどなるほど。
 
 ・ツリー構造、思ってたより計算が安くないので辞めたかった。
 */

// つまり、このようなデザインではない
// 🙅‍♂️
final class Node : Hashable {
    
    let id: UUID = .init()
    
    var children: [Node] = []
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct Tree {
    var root = Node()
    
    func traverse() {
        // 木構造探索の何かしらのアルゴリズム
        // 基本的にルートからトラバースすると、多分木の時間計算量はO(n)になる。
    }
}

// このようなデザインのはず
// 🙆‍♂️

struct SnapshotItem<ItemIdentifierType> where ItemIdentifierType : Hashable {
    var item: ItemIdentifierType
    var metaData: MetaData
    struct MetaData {
        var level: Int
    }
}

struct Snapshot<ItemIdentifierType> where ItemIdentifierType : Hashable {
    var itemTable : [ItemIdentifierType : SnapshotItem<ItemIdentifierType>] = [:]
}

//: これだとlevel(of: itemIdentifier)という呼び出しに対してO(1)で答えられる。

extension Snapshot {
    
    func level(of itemIdentifier: ItemIdentifierType) -> Int? {
        return itemTable[itemIdentifier]?.metaData.level
    }
    
}

/*:
 ・問題は、parent(of:)のような、親を求めるAPIに対してどのように答えるかという所。安く算出できるのか、プロパティに親/子を持たせつつ、hashtableに格納するのか。
 
 ・「ハッシュテーブルに格納されたメタデータ付きのアイテムとして保存して、それをメタデータを考慮しながら正しい並び順で返すのが、items, visibleItems, rootItemsというプロパティである」と推論すると、全体がスッキリ収まる感覚。割と推論として筋が良さそうだけどどうだろう。
 
 ・データ構造とアルゴリズムについて詳しい知識を持っていれば、この辺りの話は知識でスッと解決できていたはず(知らんけど)
 
 ・知らないだけで、常に時間がかかる。やはりメンターや質問できる人がいると助かるなぁという感じ。お金入ったら、プログラミング周りは自分より圧倒的にすごい人にお金払ってコーチ頼むことにしよう。
 
 ・1ヶ月に相談し放題と軽いペアプロがついて100万とかなら、お釣りがくるぐらい安いな。
 
 ・目的を持って活動していて、それに関して質問しまくれる人って、大学の教授か。大学生活は、自分でテーマを持って質問しまくるのが正解やったな。院に行くチャンスがあれば、ぜひそうしよう。
 
 ・仕事は、OJTの期間中ならそれで良しだけど、そうではないなら相手の作業時間も奪ってしまうので、コーチ役のエンジニアリングマネージャー的な人がいれば良さげ。
 
 */
