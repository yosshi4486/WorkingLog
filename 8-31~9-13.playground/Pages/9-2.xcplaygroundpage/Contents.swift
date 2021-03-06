//: [Previous](@previous)

/*:
 # きょうの作業ログ　2020/09/02
 ・
 ~/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/UIKit.framework/Headers
 を眺めて、真似したいクラスのヘッダーを見ると結構コメントとか書いてあったりするので良い情報になる。このテクニックは今後利用していこう。
 ・問題は、その問題と同じレベルでは解決しない。という考えが自分に浸透してきた。
 ・https://twitter.com/yosshi_4486/status/1301005854582349825
 ・契約による設計が良さそう。古いオブジェクト指向についての文書も読んでいこう。
 ・APIレベルでのエラーの設計はswiftのエラー4分類がすごく良さそう。
 
 それに加えて使い分けを考える。
 
 事前条件と事後条件を合わせて考えてみる。
 利用者側で契約が破られた場合は、事前条件が満たされないことを想定しつつ処理を実行しているはずなので、Simple domain errorかLogic failureで返す。
 実装側で契約が破られた場合は、事後条件が満たされないことは利用者側にとって想定外なので、Recoverable errorかLogic failureで返す。
 
 ・型変換は実行して失敗してもif let で分岐するなど、事前条件を満たさないかもしれないことをわかった上で実行させて、失敗したら別の処理をさせる。というのを利用者側で考えられるので、回復可能な利用者契約違反としてSimple Domain Errorを考えられる。
 ・index out of rangeは、失敗した時点で実装に問題があることが明らかなものと考えられるので、回復不可能な利用者契約違反としてLogic Failureを考えられる。
 ・ネットワークやファイル処理なので発生する様々なエラー(通信状態が悪い、サーバービジー、etc...)は、利用者側の責任(事前条件)を満たしていても、実装側の問題で権利が履行できない(事後条件を満たせない)ものと考えられるので、発生し得る問題を列挙してRecoverableErrorとしてエラーをthrowする。
 ・メモリ不足やスタックオーバーフローは、利用者の責任を満たしているが、権利が履行できないし回復不可能であるので、fatalErrorとしてプログラムを落としてしまう。
 
 回復可能であるかそうでないかは、「これは失敗の可能性がある」と思いつつ実行しているかどうかみたいな感触。index out of rangeは、仕様見落としで意図せず発生するのが100%。optional chainingは、失敗するかもしれない処理として認識して実行している。
 
 ・これはUIへも転用できる便利な考え方ではないかなーと考え始めている。validationのようにルールが決まっている入力がある時、事前条件を満たせない行動を取った利用者には自身で回復行動を取ってもらう必要がある。(もちろん、システムで入力中にリアルタイムで違反について明示を行う)
 ネットワークの調子が悪くて、提供側が契約を満たせないような場合は可能な限り自動解決を目指すが、できない場合は理由を簡潔に伝えて自身で解決行動を取ってもらう。
 
 など。後者は、基本的にはシステム、デバイス側の問題なのでこちらの問題なので、自身で解決してもらうと体験の質が下がる。
 */
//: [Next](@next)
