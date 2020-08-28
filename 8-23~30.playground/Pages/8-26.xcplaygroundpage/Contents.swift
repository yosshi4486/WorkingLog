//: [Previous](@previous)

import Foundation

/*:
 # きょうの作業ログ　2020/08/26
 ・ある他のライブラリと同性能を出したい時、そのベンチマークを取って目標値に設定すれば良い。というムーブを覚えた。
 
 ・XCTestのmeasureメソッドって、デフォルトで10回実行してアベレージを表示してくれるようになっているのか。とても助かる。便利
 
 ・そして、ベースラインを決めて、アルゴリズムや実装を変更したときのパフォーマンスリグレッションテストとして機能してくれる。
 
 ・Heapの制約を満たさない領域を、再度整える操作ってなんて呼ぶんやろう？
 
 ・Arrayの挙動を調査
 */

var array = Array(0...100)
array.count

array.removeAll(keepingCapacity: true)
array.count

array = []
array.count

//: array = []とarray.removeAllはほぼ等価という[記事](https://stackoverflow.com/questions/54133045/performance-array-removeall-vs/54133969)をみた

//: Swift自体はOSSなので、こういう時は中身みられるのか。便利
//: https://github.com/apple/swift/blob/ad50a39b120343f4827edb0a5a7013bb586306a6/stdlib/public/core/Array.swift#L1255
//: 雰囲気がこんな感じで作られている
struct _ArrayBuffer<Element> { } // Objcとのブリッジング用

struct _ContiguousArrayBuffer<Element> { } // swift用のArray?

typealias EmptyCollection<Element> = Array<Element> //実装が結構あって面倒なので省略

struct ImitationArray<Element> {
    
    #if _runtime(_ObjC)
    @usableFromInline
    typealias _Buffer = _ArrayBuffer<Element>
    #else
    @usableFromInline
    typealias _Buffer = _ContiguousArrayBuffer<Element>
    #endif
    
    @usableFromInline
    internal var _buffer: _Buffer
    
    @inlinable
    internal init(_buffer: _Buffer) {
        self._buffer = _buffer
    }
    
    @inlinable
    public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        if !keepCapacity {
            // keepCapacityがfalseの場合は、新しいBufferを作成して代入しているので、これがほとんど
            // array = []
            // と等価ということ。むしろremoveAllの方が最適化が効いていて効率的だろうという。
            _buffer = _Buffer()
        } else {
            // indeciesはどこから来ているのか。ここでは分からないので適当に決めておく。
            // 本来はこれが自身の保持している配列の範囲が入るはず
            self.replaceSubrange(0..<100, with: EmptyCollection())
        }
    }
    
    @inlinable
    public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: __owned C) where C: Collection, C.Element == Element {
        // 省略
    }
}

//: [Next](@next)
