//: [Previous](@previous)

/*:
 # B木
 ## リンク
 http://wwwa.pikara.ne.jp/okojisan/b-tree/index.html
 https://ja.wikipedia.org/wiki/B木
 
 ## 概念
 > B木は以下の条件を満たす多分探索木です
 > - 各ノードは最大でm本の枝を持つ(m>=3)
 > - 根と葉を除く各ノードは[m/2]本以上の枝を持つ
 > - 枝と枝の間には要素が1つあり、各要素は昇順に整列されている
 > - 各ノードの左端の要素aの左の枝の先にはaより小さい要素がある
 > - 各ノードの右端の要素aの右の枝に先にはaより大きい要素がある
 > - 各ノードの要素 a, b(a < b)の間の枝の先にはaより大きくbより小さい要素がある
 > - 全ての葉から根までのパス上のノード数は等しい
 
 > B木の最後の条件は重要で、赤黒木やAVL木と違って、B木が完全にバランスしていることを示しています。
 
 > ここで、[m/2]はm/2nの小数点を切り上げる演算です。m=3ならm/2 = 1.5ですから[m/2] = 2になります。根(root)とは12が割り当てられている最上位のノードのことで、葉とは空のノードのことです。1,2や4,5が割り当てられているノードの下には本来は枝があるのですが、簡略化のために図示していません。空のノードはこれらの枝の先にあると考えます。特定のノードを根と見なした木構造のことを部分木といいます。最大の部分木はB木自身です。
 
 (B木の定義, http://wwwa.pikara.ne.jp/okojisan/b-tree/index.html)
 
 ## 実装
 
 */

import Foundation
final class BTreeNode {
    
    var keys: [Int?]
    
    // TはBTreeの最大ブランチの数、ブロックサイズによって決められる。自身が持つキーの数は、ブランチの数-1なので、そのようになっている。
    // swiftではあまり、配列の数を決め打ちで使った経験がないが、ここはサンプルコードに従う。
    var t: Int
    
    var children: [BTreeNode?]
    
    var currentNumberOfKeys: Int
    
    var isLeaf: Bool
    
    init(t: Int, isLeaf: Bool) {
        self.t = t
        self.isLeaf = isLeaf
        self.keys = Array(repeating: nil, count: 2 * t - 1)
        self.children = Array(repeating: nil, count: 2 * t)
        self.currentNumberOfKeys = 0
    }
    
    func traverse() {
        for i in 0...currentNumberOfKeys {

            if !isLeaf {
                children[i]?.traverse()
            }
            print(keys[i])
        }
    }
    
    func search(from key: Int) -> BTreeNode? {
        var i = 0
        
        // keyと等しいか大きい最初のデータを探す
        while i < currentNumberOfKeys && key > keys[i]! {
            i += 1
        }
        
        // 自身が対象の値を持ったノードなら返す
        if keys[i] == key {
            return self
        }
        
        // 自身が対象の値を持っておらず、リーフである場合は、検索対象の要素は見つからないのでnilで返す
        guard !isLeaf else {
            return nil
        }
        
        // 自身が対象の値を持っておらず、中間ノードである場合は、子への探索を続けさせる。
        return children[i]?.search(from: key)
    }
    
    func insertNonFull(key: Int) {
        
        // 今持っているキーの数-1をインデックスにする。
        var index = currentNumberOfKeys - 1
        
        if isLeaf {
            
            // キーの適切な挿入位置を探すために、キーの末尾から逆順に走査
            // デクリメントしながら挿入位置のindexを探りつつ
            // 対象要素より大きいものを末尾側に1つづつずらして位置を確保している。
            // この関数はノードのキーが一杯ではない時に呼ばれるので、これで問題ない。
            while index >= 0 && keys[index]! > key {
                keys[index+1] = keys[index]
                index -= 1
            }
            
            // whilenの最後で、挿入位置の一つ手前を指しているので+1
            keys[index+1] = key
            
            // 配列を固定確保して操作する都合上、computed propertyだと都合が悪い。
            currentNumberOfKeys = currentNumberOfKeys + 1
        } else {
            
            // リーフの時と同じく対象のノードを探すが、自身のキーに挿入するわけではないので、インデックスを探すだけで
            // キーずらしはしない。
            while index >= 0 && keys[index]! > key {
                index -= 1
            }
            
            // 挿入対象の子ノードが、分割条件を満たすキー数の場合、分割処理を実行させる
            if children[index+1]!.currentNumberOfKeys == 2 * t - 1 {
                
                // 対象の子に対して分割処理を実行
                splitChild(index: index + 1, y: children[index+1]!)
                
                // スプリット操作の後、子が分割されて、中間の値が自身のキーに入って、そこから2つに枝分かれすることになる。
                // これは、分割処理後に挿入しようとしているキーが分割後のどちらの子に入るかを検討している記述
                // 中間の値よりもキーがデカければ、右側の子を指すので+1するし、小さければ左側の子を指すので変わらない。
                if keys[index + 1]! < key {
                    index += 1
                }
            }
            
            //　必要があれば分割処理を実行し、その後に再帰処理で挿入操作をする。これをリーフまで繰り返す。
            children[index+1]?.insertNonFull(key: key)
        }
    }
    
    func splitChild(index: Int, y: BTreeNode) {
        
        /*:
         BTreeの性質を復唱
         1. 全てのリーフの深さが揃っている
         2. 各ノードは、最小次数のtによって定義される。このTはブロックサイズに依存する。
         3. ルート以外の全てのノードはt-1のキーを持たないといけない。
         4. 全てのノードは、最大で2t-1までキーを持てる
         5. 子のノードの数は、自身のキーに1を足した数値と一致する
         6. 全てのキーは昇順で並んでいる。
         (あとは微妙に理解できないので省略)
         (Properties of B-Tree: https://www.geeksforgeeks.org/introduction-of-b-tree-2/)
         */
        
        // yは分割対象として渡されてきたノード
        // 分割後のノードはt-1のキーを最初から含まないといけない
        let z = BTreeNode(t: y.t, isLeaf: y.isLeaf)
        
        z.currentNumberOfKeys = t - 1
        
        // yの末尾のt...2t-1までの、t-1個のキーをzの先頭から順にコピーしていく。
        for j in 0..<t-1 {
            z.keys[j] = y.keys[j+t]
        }
        
        // yの子のt子のキーをzの子の先頭から順にコピーしていく。
        if !y.isLeaf {
            for j in 0..<t {
                z.children[j] = y.children[j+t]
            }
        }
        
        // yのキーの数を減らす
        y.currentNumberOfKeys = t - 1
        
        // 自分は新しい子を持つことになるから、分割先としていされた箇所まで末尾にずらしていく
        for j in stride(from: currentNumberOfKeys, through: index+1, by: -1).reversed() {
            children[j+1] = children[j]
        }
        
        // 指定箇所に要素をコピー済みのノードを割り当てる
        children[index+1] = z
        
        // yのキーが自身のノードに移動するので場所を開ける
        for j in stride(from: currentNumberOfKeys - 1, through: index, by: -1).reversed() {
            keys[j+1] = keys[j]
        }
        
        // キーを自身に挿入
        // イメージとしては、このInsert90の図(https://www.geeksforgeeks.org/insert-operation-in-b-tree/)
        // t-1はy.keysの中間の要素を指している。
        keys[index] = y.keys[t-1]
        
        // 自身のキーの数をインクリメント
        currentNumberOfKeys += 1
    }
    
    
}

final class BTree {
    
    var root: BTreeNode?
    
    var t: Int
    
    init(t: Int) {
        self.t = t
    }
    
    func traverse() {
        guard let aRoot = root else {
            return
        }

        aRoot.traverse()
    }
    
    func search(from key: Int) -> BTreeNode? {
        guard let aRoot = root else {
            return nil
        }
        return aRoot.search(from: key)
    }
    
    func insert(key: Int) {
        
        guard let aRoot = root else {
            root = BTreeNode(t: t, isLeaf: true)
            root?.keys[0] = key
            root?.currentNumberOfKeys = 1
            return
        }
        
        // ルートのキーが溢れている場合
        if aRoot.currentNumberOfKeys == 2*t-1 {
            let s = BTreeNode(t: t, isLeaf: false)
            
            // スプリット操作
            s.children[0] = root
            s.splitChild(index: 0, y: aRoot)
            
            var i = 0
            if s.keys[0]! < key {
                i += 1
            }
            
            s.children[i]?.insertNonFull(key: key)
            root = s
        } else {
            aRoot.insertNonFull(key: key)
        }
    }
    
}

import XCTest

    
func testBTree() {
    let btree = BTree(t: 3)
    btree.insert(key: 10)
    btree.insert(key: 20)
    btree.insert(key: 5)
    btree.insert(key: 6)
    btree.insert(key: 12)
    btree.insert(key: 30)
    btree.insert(key: 7)
    btree.insert(key: 17)
    
    btree.traverse()
    XCTAssertNotNil(btree.search(from: 6))
    XCTAssertNil(btree.search(from: 15))
}

testBTree()



//: [Next](@next)
