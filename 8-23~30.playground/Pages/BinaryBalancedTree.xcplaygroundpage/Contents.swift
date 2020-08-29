//: [Top](8-26)

/*:
 # 平衡二分探索木
 ## リンク
 https://ja.wikipedia.org/wiki/平衡二分探索木
 https://ja.wikipedia.org/wiki/AVL木
 http://wwwa.pikara.ne.jp/okojisan/avl-tree/index.html
 https://www.geeksforgeeks.org/avl-tree-set-1-insertion/
 
 ## 概念
 二分探索木の欠点として、挿入や削除の操作を繰り返すうちにルートノードから見て左右の部分木の深さが不均等になってしまい、最悪の場合では線形探索と同じだけの計算が必要になってしまう問題があった。平衡二分探索木では、木に対する変換を行うことで、この問題を解決してO(log n)を保てる。変換操作にはオーバーヘッドがあるが、不均等な木への操作のオーバーヘッドに比べられば劇的に少ないので、償却可能である。
 
 平衡二分探索木とは抽象的なもので、コンクリートな実装にはAVL木や赤黒木など、別の名前がついている。
 
 ## 仕様
 */
protocol Node {
    associatedtype Element
    
    /// 親を保持していると「検索対象と一致したノードが見つかったら、親から〇〇する」という処理を実行しやすくて便利
    var parent: Self? { get set }
    
    /// 自身より値の小さなノード
    var left: Self? { get set }
    
    /// 自身と値が等しいか大きいノード
    var right: Self? { get set }
}

protocol Tree {
    associatedtype TreeNode: Node
    
    /// ルートノードを保持している
    var root: TreeNode { get set }
    
    /// 要素からノードを検索する
    func find(element: TreeNode.Element) -> TreeNode?
    
    /// ある要素を持つノードを挿入する
    func insert(element: TreeNode.Element)
    
    /// ある要素を持つノードを削除する
    func remove(element: TreeNode.Element)
}

protocol BalancedBinarySearchTree : Tree {
    
    /// ノードの右回転。新しいルートを返す
    func rotateRight(node: TreeNode) -> TreeNode?
    
    /// ノードの左回転。新しいルートを返す
    func rotateLeft(node: TreeNode) -> TreeNode?

}

/*:
 ## 実装
 AVL木を実装する。AVL木では、データの挿入/削除のたびに全てのノードが条件を満たしているか調べる。
 平衡係数というのがよく用いられ
 > 平衡係数 = 左の部分木の高さ - 右の部分木の高さ
 の式で求める。
 
 平衡係数が1, 0, -1の場合は平衡であるとして回転操作が必要ではないが、2以上、-2以下の場合には回転が必要になる。
 
 回転操作は、平衡が崩れたノードの中で、もっともルートから遠いノードから行う。
 
 AVL木においては、平衡係数はbiasと呼ばれる。
 
 回転のイメージ
 
 ![回転](Rotation.jpeg)
 
 ![左右二重回転](DoubleRotation.jpeg)
 
 */
/// Comparableにしているので、StringでもIntでも、比較可能なものなら扱える。
final class AVLTreeNode<Element> : Node where Element : Comparable {
    
    /// ノードの要素
    var element: Element
    
    /// 自身のリーフからの高さ。これによって左右のノードの高さを辿れるので、平衡係数biasの算出ができる。
    var height: Int
    
    /// 親ノード
    var parent: AVLTreeNode?
    
    /// 自身の左のノード
    var left: AVLTreeNode?
    
    /// 自身の右のノード
    var right: AVLTreeNode?
    
    init(element: Element, height: Int, parent: AVLTreeNode?, left: AVLTreeNode?, right: AVLTreeNode?) {
        self.element = element
        self.height = height
        self.parent = parent
        self.left = left
        self.right = right
    }
    
    static func < (lhs: AVLTreeNode, rhs: AVLTreeNode) -> Bool {
        return lhs.element < rhs.element
    }
    
    static func == (lhs: AVLTreeNode, rhs: AVLTreeNode) -> Bool {
        return lhs.element == rhs.element
    }
    
}

final class AVLTree<Element> : BalancedBinarySearchTree where Element : Comparable {

    typealias TreeNode = AVLTreeNode<Element>

    enum Rotation {
        case singleR
        case singleL
        case doubleLR
        case doubleRL
        
        init?(balance: Int, node: TreeNode) {
            
            func height(of node: TreeNode?) -> Int {
                guard let aNode = node else {
                    return 0
                }
                return aNode.height
            }

            if balance > 1 && height(of: node.left?.left) > height(of: node.left?.right) {
                self = .singleR
            } else if balance < -1 && height(of: node.right?.right) > height(of: node.right?.left) {
                self = .singleL
            } else if balance > 1 && height(of: node.left?.left) < height(of: node.left?.right) {
                self = .doubleLR
            } else if balance < 1 && height(of: node.right?.right) < height(of: node.right?.left) {
                self = .doubleRL
            } else {
                return nil
            }
        }

    }

    var root: TreeNode
    
    /// あるノードの高さをえる
    func height(of node: TreeNode?) -> Int {
        guard let aNode = node else {
            return 0
        }
        return aNode.height
    }
    
    var isBalanced: Bool {
        let aBalance = balance(of: root)
        return -1 < aBalance && aBalance < 1
    }
    /// ノードの平衡係数を返す
    func balance(of node: TreeNode?) -> Int {
        guard let aNode = node else {
            return 0
        }
        
        return height(of: aNode.left) - height(of: aNode.right)
    }
    
    // 探索は二分探索木と変わらない。
    func find(element: Element) -> AVLTreeNode<Element>? {
        var node: TreeNode? = root
        
        while node != nil {
            if element < node!.element {
                node = node?.left
            } else if element > node!.element {
                node = node?.right
            } else {
                // 検索対象が探索したnodeと一致した。
                break
            }
        }
        return node
    }
    
    private func insert(node: TreeNode?, element: Element) -> TreeNode? {
        // 1. 普通にBSTの挿入操作をする
        guard let aNode = node else {
            return TreeNode(element: element, height: 1, parent: nil, left: nil, right: nil)
        }
        
        if element < aNode.element {
            // 左が空の場合は、空のノードがinsertに渡されて上のguard文からreturnされる。
            aNode.left = insert(node: aNode.left, element: element)
        } else if element > aNode.element {
            // 右が空の場合は、空のノードがinsertに渡されて上のguard文からreturnされる。
            aNode.right = insert(node: node?.right, element: element)
        } else {
            return aNode
        }
        
        // 2. 高さの更新をする
        // リーフ直前のノードから始まって、左右の高さより自分が+1高いところにいる。
        aNode.height = 1 + max(height(of: aNode.left), height(of: aNode.right))
        
        // 3. 平衡係数を取る
        let aBalance = balance(of: aNode)
        
        /*
         5. 経路を辿りながら、平衡係数を見て必要なら回転操作を掛けていくが、以下の4パターンがある。
         1) 左単一回転
         2) 右単一回転
         3) 左右二重回転
         4) 右左二重回転
         
         単回転では平衡条件が満たされないパターンが2つあり、それが3と4に該当する。
         [1]: 平衡条件を満たさないノードをPとして、Pの左部分木の方が高く、かつPの左の子ノードの右部分木の方が高い場合
         [2]: 平衡条件を満たさないノードをPとして、Pの右部分木の方が高く、かつPの右の子ノードの左部分木の方が高い場合
         
         */
        
        if let rotation = Rotation(balance: aBalance, node: aNode) {
            switch rotation {
            case .singleR:
                return rotateRight(node: aNode)
            case .singleL:
                return rotateLeft(node: aNode)
            case .doubleLR:
                aNode.left = rotateLeft(node: aNode.left!)
                return rotateRight(node: aNode)
            case .doubleRL:
                aNode.right = rotateRight(node: aNode.right!)
                return rotateLeft(node: aNode)
            }
        }
                
        return aNode
    }
    
    // 挿入時には平衡係数を調べて、条件を満たしていれば木の回転を行う
    func insert(element: Element) {
        guard let inserted = insert(node: root, element: element) else {
            return
        }
        
        root = inserted
    }
    
    private func remove(node: TreeNode?, element: Element) -> TreeNode? {
        // 1. 普通にBSTの削除操作をする
        guard let aNode = node else {
            return nil
        }
        
        if element < aNode.element {
            // 左が空の場合は、空のノードがinsertに渡されて上のguard文からreturnされる。
            aNode.left = remove(node: aNode.left, element: element)
        } else if element > aNode.element {
            // 右が空の場合は、空のノードがinsertに渡されて上のguard文からreturnされる。
            aNode.right = remove(node: node?.right, element: element)
        } else {
            // 一致した要素をnilにする。
            return nil
        }
        
        // 2. 高さの更新をする
        // リーフ直前のノードから始まって、左右の高さより自分が+1高いところにいる。
        aNode.height = 1 + max(height(of: aNode.left), height(of: aNode.right))
        
        // 3. 平衡係数を取る
        let aBalance = balance(of: aNode)
        
        /*
         5. 経路を辿りながら、平衡係数を見て必要なら回転操作を掛けていくが、以下の4パターンがある。
         1) 左単一回転
         2) 右単一回転
         3) 左右二重回転
         4) 右左二重回転
         
         単回転では平衡条件が満たされないパターンが2つあり、それが3と4に該当する。
         [1]: 平衡条件を満たさないノードをPとして、Pの左部分木の方が高く、かつPの左の子ノードの右部分木の方が高い場合
         [2]: 平衡条件を満たさないノードをPとして、Pの右部分木の方が高く、かつPの右の子ノードの左部分木の方が高い場合
         
         */
        
        if let rotation = Rotation(balance: aBalance, node: aNode) {
            switch rotation {
            case .singleR:
                return rotateRight(node: aNode)
            case .singleL:
                return rotateLeft(node: aNode)
            case .doubleLR:
                aNode.left = rotateLeft(node: aNode.left!)
                return rotateRight(node: aNode)
            case .doubleRL:
                aNode.right = rotateRight(node: aNode.right!)
                return rotateLeft(node: aNode)
            }
        }
        
        return aNode
    }
    
    func remove(element: Element) {
        guard let removed = remove(node: root, element: element) else {
            return
        }
        self.root = removed
    }
    
    func rotateLeft(node: AVLTreeNode<Element>) -> AVLTreeNode<Element>? {
        /*
         RS: Rotation Side Node
         OS: Opposite Side Node
         
         ## 抽象表現
         Pivot = Root.OS
         Root.OS = Pivot.RS
         Pivot.RS = Root
         Root = Pivot
         
         ## 左回転の具体的な操作
         Pivot = Root.right
         Root.right = Pivot.left
         Pivot.left = Root
         Root = Pivot(この関数では戻り値としている)
         */
        // 主役はルートとピボット
        let root = node
        guard let pivot = root.right else {
            return nil
        }
        
        // 左回転操作
        root.right = pivot.left
        pivot.left = root
        
        // 高さの更新
        root.height = max(height(of: root.left), height(of: root.right) + 1)
        pivot.height = max(height(of: pivot.left), height(of: pivot.right) + 1)

        return pivot
    }
    
    func rotateRight(node: AVLTreeNode<Element>) -> AVLTreeNode<Element>? {
        
        /*
         RS: Rotation Side Node
         OS: Opposite Side Node
         
         ## 抽象表現
         Pivot = Root.OS
         Root.OS = Pivot.RS
         Pivot.RS = Root
         Root = Pivot
         
         ## 左回転の具体的な操作
         Pivot = Root.left
         Root.left = Pivot.right
         Pivot.right = Root
         Root = Pivot(この関数では戻り値としている)
         */

        // 主役はルートとピボット
        let root = node
        guard let pivot = root.left else {
            return nil
        }

        // ローテーション
        root.left = pivot.right
        pivot.right = root
        
        // 高さの更新
        root.height = max(height(of: root.left), height(of: root.right) + 1)
        pivot.height = max(height(of: pivot.left), height(of: pivot.right) + 1)
        
        return pivot
    }
    
    func traverse() -> [TreeNode.Element] {
        var results: [TreeNode.Element] = []
        func preOrder(_ node: TreeNode?) {
            guard let aNode = node else {
                return
            }
            results.append(aNode.element)
            preOrder(aNode.left)
            preOrder(aNode.right)
        }
        preOrder(root)
        
        return results
    }
    
    
    init(root: TreeNode) {
        self.root = root
    }
}

//: ## テストコード

import XCTest

func testInsert() {
    let tree = AVLTree(root: AVLTreeNode(element: 10, height: 1, parent: nil, left: nil, right: nil))
    tree.insert(element: 20)
    tree.insert(element: 30)
    tree.insert(element: 40)
    tree.insert(element: 50)
    tree.insert(element: 25)

    XCTAssertEqual(tree.balance(of: tree.root), 0)
    
    print("Preorder traversal")
    let result = tree.traverse()
    XCTAssertEqual(result[0], 30)
    XCTAssertEqual(result[1], 20)
    XCTAssertEqual(result[2], 10)
    XCTAssertEqual(result[3], 25)
    XCTAssertEqual(result[4], 40)
    XCTAssertEqual(result[5], 50)
}

func testFind() {
    let tree = AVLTree(root: AVLTreeNode(element: 10, height: 1, parent: nil, left: nil, right: nil))
    tree.insert(element: 20)
    tree.insert(element: 30)
    tree.insert(element: 40)
    tree.insert(element: 50)
    tree.insert(element: 25)

    XCTAssertEqual(tree.balance(of: tree.root), 0)
    
    print("Preorder traversal")
    let result = tree.traverse()
    XCTAssertEqual(result[0], 30)
    XCTAssertEqual(result[1], 20)
    XCTAssertEqual(result[2], 10)
    XCTAssertEqual(result[3], 25)
    XCTAssertEqual(result[4], 40)
    XCTAssertEqual(result[5], 50)
    
    XCTAssertNil(tree.find(element: 80))
    XCTAssertEqual(tree.find(element: 40)?.element, 40)
}


func testRemove() {
    let tree = AVLTree(root: AVLTreeNode(element: 10, height: 1, parent: nil, left: nil, right: nil))
    tree.insert(element: 20)
    tree.insert(element: 30)
    tree.insert(element: 40)
    tree.insert(element: 50)
    tree.insert(element: 25)

    XCTAssertTrue(tree.isBalanced)
    
    print("Preorder traversal")
    let inserationResult = tree.traverse()
    XCTAssertEqual(inserationResult[0], 30)
    XCTAssertEqual(inserationResult[1], 20)
    XCTAssertEqual(inserationResult[2], 10)
    XCTAssertEqual(inserationResult[3], 25)
    XCTAssertEqual(inserationResult[4], 40)
    XCTAssertEqual(inserationResult[5], 50)
    
    tree.remove(element: 40)
    
    let removedResult = tree.traverse()
    XCTAssertEqual(removedResult.count, 4)
    XCTAssertEqual(inserationResult[0], 30)
    XCTAssertEqual(inserationResult[1], 20)
    XCTAssertEqual(inserationResult[2], 10)
    XCTAssertEqual(inserationResult[3], 25)
    
}

testInsert()
testRemove()
testInsert()

