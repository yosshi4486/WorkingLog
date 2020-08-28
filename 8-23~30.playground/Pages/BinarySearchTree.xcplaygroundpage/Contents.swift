//: [Top](8-26)

/*:
 # 二分探索木
 ## 参考
 https://ufcpp.net/study/algorithm/col_tree.html
 ## 概念
 各ノードが子を2つまでしか持たない、かつ、全ての要素が「左<親<=右」もしくは「左<=親<右」を満たす木構造
 
 ## 特徴
 二分探索が可能な構造になっているので、平衡なら各操作がO(log n)
 
 ## 仕様
 */

protocol Node : Comparable {
    associatedtype Element : Comparable
    
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

 /*:
 左右のノードが定義されている。find, insert, removeが実行可能
 
 ## 実装
 */

/// Comparableにしているので、StringでもIntでも、比較可能なものなら扱える。
final class BinaryTreeNode<Element> : Node where Element : Comparable {
    
    var element: Element
    
    var parent: BinaryTreeNode?

    var left: BinaryTreeNode?
    
    var right: BinaryTreeNode?
    
    init(element: Element, parent: BinaryTreeNode?, left: BinaryTreeNode?, right: BinaryTreeNode?) {
        self.element = element
        self.parent = parent
        self.left = left
        self.right = right
    }
    
    static func < (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool {
        return lhs.element < rhs.element
    }
    
    static func == (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool {
        return lhs.element == rhs.element
    }
    
}

/// ルートノードの初期化によってElementが束縛される
final class BinarySearchTree<Element> : Tree where Element : Comparable {

    typealias TreeNode = BinaryTreeNode<Element>

    var root: TreeNode
    
    func find(element: Element) -> BinaryTreeNode<Element>? {
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
    
    func insert(element: Element) {
        var parentNode: TreeNode? = nil
        var node: TreeNode? = root
        
        while(node != nil) {
            parentNode = node
            if element < node!.element {
                node = node?.left
            } else if element > node!.element {
                node = node?.right
            }
        }
        
        guard let foundParentNode = parentNode else {
            return print("Not found")
        }
        
        node = BinaryTreeNode<Element>(element: element, parent: foundParentNode, left: nil, right: nil)
        
        if element < foundParentNode.element {
            foundParentNode.left = node
        } else {
            foundParentNode.right = node
        }
    }
    
    func remove(element: Element) {
        var node: TreeNode? = root
        
        while node != nil {
            if  element < node!.element {
                node = node?.left
            } else if element > node!.element {
                node = node?.right
            } else {
                let parent = node!.parent
                if let left = parent?.left, left.element == element {
                    parent?.left = nil
                } else {
                    parent?.right = nil
                }
                break
            }
        }
    }
    
    init(root: TreeNode) {
        self.root = root
    }
}

//: ## テスト
import XCTest

func testTree() {
    let root = BinaryTreeNode(element: "d", parent: nil, left: nil, right: nil)
    let tree = BinarySearchTree(root: root)
    
    tree.insert(element: "b")
    tree.insert(element: "f")
    tree.insert(element: "a")
    tree.insert(element: "c")
    tree.insert(element: "e")
    tree.insert(element: "g")
            
    let result = tree.find(element: "b")
    XCTAssertNotNil(result)
    XCTAssertEqual(result?.left?.element, "a")
    XCTAssertEqual(result?.right?.element, "c")
    
    tree.remove(element: "b")
    
    let nilResult = tree.find(element: "b")
    XCTAssertNil(nilResult)
    
}
testTree()

//: [Next](@next)
