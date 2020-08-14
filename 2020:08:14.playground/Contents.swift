/*:
 # きょうの作業ログ　2020/08/14
・ 今日からSwift Playgroundで実行可能な形式の文章を書いてみることにしました。
 開発者として何度か利用していますが、あまり踏み込んだ利用はしていなかったので、これを機に利用していこうと思います。
 
 ・他には、例えばPages, Chapters, Cutscenes, Modules, Resourcesなどの概念があるみたいで、サブディレクトリを作成してManifest.plistを配置することで別のものとして認識してくれるみたいです。良さげですね。
 
 ・Resourcesディレクトリに画像、動画、音楽、テキストなどを含めていても、いつものプログラミングのシンタックス通りに取り出せます。
 
 */

import SwiftUI
import UIKit

let textResourceURL = Bundle.main.url(forResource: "TextResource", withExtension: "text")
let string = try! String(contentsOf: textResourceURL!)

print(string)

/*:
 ・今後はこの形式で日々のログを書いていき、XcodeからレンダリングしたpdfをNotenに貼り付ける形式を試してみます。
 
 ・WebsiteでPlaygroundファイルが実行できたら最高なのにな〜と思います。
 
 ・PlaygroundのInspectorPaneから「Render Documentation」のチェックボックスを入れると、マークダウンをレンダリングしてくれます。
 */
let sampleImage = UIImage(named: "Rendered")
