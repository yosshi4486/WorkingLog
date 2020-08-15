import UIKit


/*:
 # きょうの作業ログ　2020/08/15
 ・SwiftUIで頑張ってアプリ作ってれば、良い投資になるだろうと思っていたけど、あまりに記法不足すぎて、自身の要求に耐えないレベルだった、かつ、なんとしてもアプリケーションを作っていかないと金銭的に死ぬ事が分かっているので、目下は**UIKIt+ Catalyst**という方針を立てた。iOS13以降の対応にして最速でリリースし、収益性が上がってきたらAppKitでMac向けに最適化したりSwiftUIを取り入れたりしよう。
 
 ・持続可能性を確保していないのに延々と技術投資をし続けるのは無理や。この辺りは投資のツールセットがあれば良いかな。
 
 ・学んだら、学んだだけ貰いを増やしていかないと、それ自体を継続できない。
 
 ・現在master-featureブランチ一本で切っていたところを、ここにSwiftUIブランチとUIKitブランチを生やして、最終的には両方に対して同じUITestを書いてパスできるなら移行をする形にしていく。
 
 ・Appleの公式ドキュメント読んでると、型の概要では「A collection cell」と書いてあるけど、パラメータの説明では「The indexPath」と書いてあるので、そういう感覚かと思っている。
 
 ・OSS一つ作って公開した💪SnapshotとDifferableDataSourceへの理解が深まったので、すごくよかった。
 
 ・UICollectionViewのListCellの挙動をprintしていたら、Outline表示していても存在しているセクションは1つだけであった。加えて、disclusure indicatorをタップして子をexpandすると、これもまたセクション数が変わらずにnumberOfRowsが増減した。内部実装をエスパーしてみると、データモデルは木構造になっているがセル自体はセクションも1つだけのフラットな構造をしており、expandすると表示のためのViewModelに対してinsert処理が走り、それがapply(もしくはiOS12以前ならbeginUpdate() ~ endUpdate())されているのだと思う。インデントも、中身のセルはleadingにインセットをつけてるだけのはず。
 */

// イメージ実装
struct TreeView {
    
    struct ViewModel {
        var id: UUID = .init()
        var source: String = ""
        var indentationLevel = 0
    }
    var sources: [String] = [] // 仮に文字列。ソースには、完全なツリー構造のデータが含まれている。
    var viewModels: [ViewModel] = [] // ViewModelは表示のためのデータ。expand/collapseのたびに、元のデータと照らし合わせて中身が増減する。その増減のsnapshotがDiffereableDataSourceにapplyされる仕組み
}

/*:
 ・Outline表示をやるときは、NSDiffableDataSourceSectionSnapshotでsnapshot.append(items, to: parent)をやっているので、このメソッドが親子関係の構築において大きな役割を果たしていそう。
 
 ・自前実装頑張るなら、UITableViewDiffableDataSourceでNSDiffableDataSourceSectionSnapshotを受け入れられるようにしないといけないんじゃないかな。
 */
