//: [ログに戻る](8-25)

import Foundation

/*:
 ヒープ構造
 
 Referenced: https://medium.com/@yasufumy/data-structure-heap-ecfd0989e5be
 
 ## ヒープソート
 Referenced: https://medium.com/@yasufumy/data-structure-heap-ecfd0989e5be
 概念: ヒープ構造を構築しながらソートを行う
 時間計算量: worth O(n log n), best O(n), average O(n log n)
 */

let numberOfItems = 100

var dataSource: [Int] = Array<Int>(0...numberOfItems)
dataSource.shuffle()

// 配列のアクセスが0から始まるので、2n, 2n + 1ではなく、2n + 1, 2n + 2となっている。
func minHeapify(array: inout [Int], index: Int) {
    let left = 2 * index + 1
    let right = 2 * index + 2
    let length = array.count - 1
    
    // 渡される親ノードのインデックス。min heapではこのノードが子よりも小さくなければならない。
    var smallest = index
    
    let isLeftNodeInArrayBounds = left <= length
    
    if isLeftNodeInArrayBounds {
        let isLeftNodeSmallerThanParentNode = array[index] > array[left]

        if isLeftNodeSmallerThanParentNode {
            // 左のノードがヒープの制約を満たしていないので、交換対象として設定する
            smallest = left
        }
    }
    
    let isRightNodeInArrayBounds = right <= length
    
    if isRightNodeInArrayBounds {
        let isRightNodeSmallerThanParentNode = array[smallest] > array[right]

        if isRightNodeSmallerThanParentNode {
            // 右のノードがヒープの制約を満たしていないので、交換対象として設定する
            smallest = right
        }
    }
    
    let requiresExchangingNodes = smallest != index
    if requiresExchangingNodes {
        array.swapAt(index, smallest)

        minHeapify(array: &array, index: smallest)
    }
}

func buildMinHeap(array: inout [Int]) {
    for i in (0..<(array.count/2)).reversed() {
        minHeapify(array: &array, index: i)
    }
}

extension Array where Element == Int {
    
    mutating func heapSort() {
        buildMinHeap(array: &self)
        
        var sortedArray: [Int] = []
        
        for _ in 0..<count {
            swapAt(0, count-1)
            sortedArray.append(popLast()!)
            minHeapify(array: &self, index: 0)
        }
        self = sortedArray
    }
    
}

Benchmark.measure(key: "Heap Sort") {
    dataSource.heapSort()
}

import XCTest
XCTAssertEqual(dataSource, Array<Int>(0...numberOfItems))

/*:
 ## ベンチマーク
 ### n=100
 0.422(s)
 
 ### n=500
 4.124(s)
 
 ### n=1000
 11.368(s)
 
 */
//: [Next](@next)
