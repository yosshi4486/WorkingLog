import UIKit

/*:
 ・for-inループと、forEachの違いについてはっきりこれまで説明できなかったけど、公式ドキュメントに書いてあった。
 
 https://developer.apple.com/documentation/swift/array/1689783-foreach
 
 ・for-inループはreturnやbreakなど、エスケープステートメント(?正式名称が分からない)がうまく使えるので、ループなどを活用して条件に適応したら抜けるような場合に優位性がある。
 
 ・子のポインタをリストで持つような設計の場合はこんな設計になる
 */

final class ChildrenTypeTree {
    var id: UUID = .init()
    var children: [ChildrenTypeTree] = []
}

let rootChildrenTypeTree = ChildrenTypeTree()
rootChildrenTypeTree.children.append(ChildrenTypeTree())
rootChildrenTypeTree.children[0].children.append(ChildrenTypeTree())

//: そのため、ルートの単一のツリーを保持することになる。親のポインタを持つツリー実装の場合はこのようになる。

final class ParentTypeTree {
    var id: UUID = .init()
    var parent: ParentTypeTree?
    
    init(parent: ParentTypeTree?) {
        self.parent = parent
    }
}

var parentTypeTrees: [ParentTypeTree] = []
let root = ParentTypeTree(parent: nil)
parentTypeTrees.append(root)
parentTypeTrees.append(ParentTypeTree(parent: root))

/*:
 ・このように、ツリーの実装方によってデータの形式が大きく変わる。`NSDiffableDataSourceSectionSnapshot`は、public APIを見るとデータ構造をフラットに返しているので、親保持型の実装の方が都合が良さそうに見える。
 
 ・AppleのCATreeというCoreFoundationのオブジェクトが存在しているのを見つけた。
 https://developer.apple.com/documentation/corefoundation/cftree-rds
 
 ・子リスト保持型の実装で便利そうなのが、1つ1つのノードそれ自体が部分木として振る舞えるので、概念的にはシンプルを保てそう。ただ、自分より上の情報を参照したいときはPreOrderのトラバースしていかないといけない。その点、parentを保持していると、PostOrderのトラバースが可能になる。
 
 お互いに、自分より深いノードを参照しやすい。自分より浅いノードを参照しやすいという関係がありそう。その点、その両方を持つタイプの実装では自由自在だが、一貫性を保持する実装をしないといけないので大変という、どれも一長一短の関係が窺える。
 */
