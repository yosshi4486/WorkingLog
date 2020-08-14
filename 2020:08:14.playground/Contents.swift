/*:
 # きょうの作業ログ　2020/08/14
・ 今日からSwift Playgroundで実行可能な形式の文章を書いてみることにしました。
 開発者として何度か利用していますが、あまり踏み込んだ利用はしていなかったので、これを機に利用していこうと思います。
 
 ・他には、例えばPages, Chapters, Cutscenes, Modules, Resourcesなどの概念があるみたいで、サブディレクトリを作成してManifest.plistを配置することで別のものとして認識してくれるみたいです。良さげですね。
 
 ・Resourcesディレクトリに画像、動画、音楽、テキストなどを含めていても、いつものプログラミングのシンタックス通りに取り出せます。
 
 */

import SwiftUI
import UIKit

let textResourceURL = Bundle.main.url(forResource: "TextResource", withExtension: "text")
let string = try! String(contentsOf: textResourceURL!)

print(string)

/*:
 ・今後はこの形式で日々のログを書いていき、XcodeからレンダリングしたpdfをNotenに貼り付ける形式を試してみます。
 
 ・WebsiteでPlaygroundファイルが実行できたら最高なのにな〜と思います。
 
 ・PlaygroundのInspectorPaneから「Render Documentation」のチェックボックスを入れると、マークダウンをレンダリングしてくれます。
 */
let sampleImage = UIImage(named: "Rendered")

/*:
 ・SwiftUIは、静的なView作成とSource of Truthのツールセットは素晴らしいけど、動的なViewは弱いし、基本的にはシンタックス不足という事で、
 SwiftUI2の現状ではUIKit/AppKitと半々ぐらいの利用率を目指していきたい。
 
 ・[UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)は、UICollectionViewDataSourceプロトコルに適合している。これまでDataSourceに対する大量のボイラープレートを実装していたのが、公式にサポートされる感じみたい。あとは、ネットワークから取得してきたデータの反映とかもややこしかったので、差分管理の仕組みが入ったぽい。
 
 ・あーはいはい。今までFlowLayout渡していたところでListConfiguration含んだLayoutが渡せるようになったのか。
 */

//: ### Before
let collectionViewFlowLayout = UICollectionViewFlowLayout()
collectionViewFlowLayout.itemSize = CGSize(width: 50, height: 50)
collectionViewFlowLayout.minimumLineSpacing = 5
collectionViewFlowLayout.minimumLineSpacing = 5
collectionViewFlowLayout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)

let floyLayoutCollectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 300, height: 500), collectionViewLayout: collectionViewFlowLayout)

//: ### Now
var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
let compositionalLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
let listAppearanceCollectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 300, height: 500), collectionViewLayout: compositionalLayout)

//: ここでUICollectionViewCompositionalLayoutはUICollectionViewLayoutのサブクラス。つまり提供されたAPIの内部では渡されたConfigurationを使ってよしなにListを構築してくれるような実装がなされているわけだ。

//: スワイプのAPIの場所がWWDCの時と変わっているみたい
//: このように利用できる。

listConfiguration.leadingSwipeActionsConfigurationProvider = { indexPath in
    
    let indent = UIContextualAction(style: .normal, title: "Indent") { (_, _, completion) in
        completion(true)
    }
    
    return UISwipeActionsConfiguration(actions: [indent])
}

/*:
 ・Things3は流石に上手いなぁ...。称賛を送るしかない。セルタップで、まさかセルのエリアが拡大してiPhoneでフォーカスを表現するとは思わんかった。なるほど確かに、それなら一覧のコンテキストを保持したまま、テンポラリモードだけで入力・編集を終えられる。これは本当にすごい。発明。
 */
