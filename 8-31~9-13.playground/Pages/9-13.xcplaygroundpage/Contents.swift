//: [Previous](@previous)

/*:
 # きょうの作業ログ　2020/09/13
 ・UISplitViewControllerを使うときは、segueとしてshowDetailを利用する。これはSplitViewControllerの管理下にあるVCで効果を発揮する遷移で、master paneの選択によってdetail paneのVCを**置き換える。**この際、VCのインスタンスは保持されず、毎回生成される。検証としてカウンターを置いてみたが、インクリメントさせても毎回ゼロのままなので使いまわされていないことがわかる。重い画面を扱うときは、ここでトリックが必要かもしれない。
 ・iOS14からはColumnを3つまで使える。primary, supplimentary, detail。CatalystのHIGで「Macではinspector paneがあるので、iPad用にpopoverを利用している画面はinspectorに置き換るとベストな体験です。」と解説があったけど、うまいこと書いておけば自動で変換してくれんのかいな。
 ・こんな数ヶ月頑張ってから気づいたのはあれやけど、アウトラインを実装しようと思うとSectionSnapshotのようなツリーをフラットに扱えるような仕組みを用意するか、普通にFetchedResultsController使いつつEntityにグローバルインデックスとルートノードへの参照を持たして、fetchRequestでroot == fooでフェッチしたEntitiesを平坦に並べるのでもいけるな。indentationLevelのメタプロパティが必要ではあるけど。
 ・前者の仕組みだと、データーソース側でUI処理に必要な処理をやってくれるので便利だけど、SplitView(iPadの画面分割操作)とかマルチウインドウとかで、同期が取れなさそう。変更通知のための仕組みを自分で頑張って組まないとダメそう。
 ・後者はUIで必要な仕組みをDB周りに持っていくし、余計に複雑な処理を産むので微妙。であるが、変更通知は使えるのでモードレス。
 ・いやいや、最近はNSManagedObjectにpublisherが付いてるので、変更があったEntityに対してindexPath(for identifier:)を呼び出して、configureCellをすれば良い。

 */

//: [Next](@next)
