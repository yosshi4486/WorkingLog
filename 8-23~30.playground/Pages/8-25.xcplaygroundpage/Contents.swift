//: [Previous](@previous)

/*:
 # 今日の作業ログ　2020/08/25
 ・昨日は基本のアルゴリズムを学んでいたわけだが、途中だったので今日はそれを続けつつ、終わり次第、足りてない項目をここから
 https://programming-place.net/ppp/contents/algorithm/index.html
 それが終われば木構造を一通り作って理解する。
 
 https://ja.wikipedia.org/wiki/木構造_(データ構造)
 
 このwikipediaが一番分類列挙されていて良さげだった。
 
 ・木構造のアプリケーション作るのだから、焦らずに正しい知識を身につけていかねば。
 
 ・「安定ソート」「内部ソート」「外部ソート」という考え方がある。
 
 ・「安定ソート」は、値が等しいなデータの順序が、ソート後も保たれること。「内部ソート」はメモリ内の配列などが対象のソートのこと、「外部ソート」は外部記憶装置に保存された情報が対象のソートのこと。
 
 ・クイックソートまーじで早え
 
 ・コンセプト→仕様→実装の3点を掴む
 
 ・ArraySliceの挙動をやっとうまく掴んだ。ちょっと試す
 */

let arraySlice: ArraySlice<String> = .init(["a", "b", "c", "d", "e", "f"])
let decoupledLeft = arraySlice[0...2]
let decoupledRight = arraySlice[3...]

//: ここで分割される。Arrayの場合は、left、rightがそれぞれ0からインデックスが振りなおされて別々のものとして扱えるので、dが欲しければ

// decoupledRight[0]

//: と記述したくなるが、ArraySliceではIndex out of boundsが発生する。これはArraySliceが、その名の通りArrayをスライスしているだけで、新規のArrayを作っているわけではなくストレージ共有しているので、このような挙動になる。
//: つまりdにアクセスしたければ

decoupledRight[3]

//: を実行しないといけない。Arrayを量産してパフォーマンス下げたくないからArraySlice使ってみるか。と思ったらこの仕様知らなくてドツボにハマった。勉強勉強
/*:
 
 ・スタックが、追加される要素に対して最高の優先度が設定される優先度付きキューと考えられるし、キューは追加されるたびに前の要素より優先度が下がると考えると、どちらも優先度付きキューの一種として捉えられるという考え方は新しい。(自分に取って
 
 https://medium.com/@yasufumy/data-structure-heap-ecfd0989e5be
 
 ・バケツソートは取りうる値の最大値がそこそこの時は、時間計算量はクイックソートより速い。
 
 ## ソートアルゴリズム(続)
 - [Quick Sort](QuickSort)
 - [Marge Sort](MargeSort)
 - [Heap Sort](HeapSort)
 - [Backet Sort](BacketSort)
 - [Counting Sort](CountingSort)
 */

//: [Next](@next)
