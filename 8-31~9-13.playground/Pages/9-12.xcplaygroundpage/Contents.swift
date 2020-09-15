//: [Previous](@previous)

/*:
 # きょうの作業ログ　2020/09/12
 ・最初から完璧にやる必要はない。少しづつ理解しながら実装をよくしていけば良い。
 ・同じアプリ間でD&Dして、別シーン立ち上げるの、すごく良い。自分も実装しようこれ。
 ・SwiftUIやったことで、概念の関係がよくわかるようになってきた。
 App: Applicationそのもの。エントリポイント
 Scene: Windowを内容する概念。MacOSである、重なるwindowとして同一アプリケーションを展開するのも1つ1つがscene(詳しくはWindowScene)だし、アプリケーション内で複数展開しているタブも、1つ1つがscene。シーンはメモリとプロセスを共有しているので、競合には気をつける必要がある。(MacNative Developerの皆様はこの辺り熟知していそう)
 View: Scene内で使う、実際の見た目を構成する基本要素
 Screen: SwiftUIでは隠蔽されているが、物理的なスクリーンを指す。iOSでは、スクリーンサイズとwindowサイズが一致していることが多いが(iPadで1/2表示している時などは食い違う)、macでは顕著に違う。最大表示しているとき以外はスクリーンサイズとwindowサイズが一致していることはない。
 Window: Viewを管理する、不可視の親(いまいち説明がうまくいかない)
 
 今までScreen→Window→Viewだったのが、iOS13からScreen→Scene→Window→Viewになった。
 
 ・iOS13以降では、ライフサイクルイベントは全体のもの`didFinishLaunchingWithOptions`とか`willTerminate`とか以外は、全てSceneDelegateに投げるようになった。
 
 ・ユーザーは複数のシーンを生成できて、それぞれが自身のライフサイクルを持つ
 */
//: [Next](@next)
