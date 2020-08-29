//: [Previous](@previous)

/*:
 きょうの作業ログ　2020/08/29
 ・木構造の再帰処理を実装するのには再帰処理便利だけど、実際の動きを追うのに関数のスタックフレームを脳内で再現しないといけないのでやや困難。その点、反復構文は実装がやや混雑しがちではあるけれど、ただループしていくだけなので動きをイメージしやすい。
 ・BSTの時は、ある値を左と比較して、それより小さければ左に、そうでなければ右に。っていう操作だったけど、B木はノードの最大値がm子(m>=3)なので、範囲検索になるのか。つまり検索が120で、ルートが100、自身が130, 180を持っていたら、三パターンに分かれる。
 */

let searchValue = 120
let nodeRange = 130...180

if searchValue < nodeRange.first! {
    // 左の子へ
} else if nodeRange.contains(searchValue) {
    // 真ん中の子へ
} else {
    // 右の子へ
}

/*:
 ・上記のような形式。
 
 ・Bツリーに挿入の場合は、挿入対象のノードの要素数がtより大きくならないか見て、大きくなるなら`splitChild`という操作をする。
 
 ・個人の活動をずっと続けるのは精神衛生上あまり良くないと思った。仮に1人でずっと行動し誰とも関わりを持たないとすると、より多くのコミュニティにとって価値がある指針を取り入れる必要性がなくなるので、利益は自己のためだけに最適化される。つまり思想がヤバくなる。
 
 ・コードで記述できる技術を学ぶ時は、写経→テストコードでサンプル通りに実装できたか検証、振る舞いを固定→コメントを付けながら記述の意味を理解していく→可能であれば実装を改善していき理解を深める。(この段階でテストコードが役に立つ)
 
 というのが良さそう。
 
 ・B+Treeがリーフしかレコードへのポインタを持たないのは、範囲検索に強いからと、途中のノードがレコードへのポインタを持ってしまうと、ページに対して閉めるキーの割合が低くなる。B+Treeの方式を取ると、リーフ以外に対応するページではキーしか乗らないことになるので、より多くのキーを格納できる。このためオーダーが高くなりTreeの深さを浅くできる。
 */
//: [Next](@next)
