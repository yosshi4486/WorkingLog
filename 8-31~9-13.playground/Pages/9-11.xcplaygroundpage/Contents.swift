//: [Previous](@previous)

/*:
 きょうの作業ログ　2020/09/11
 ・UIのテストするときに難しいのが、メインスレッドの挙動に合わせてDispatchQueue.main.asyncを実行すると、先にtearDownが呼ばれてリソースが解放されてしまうところ。
 */

import SwiftUI

struct DisclosureAccessoryView : View {
    
    var onChangeExpandingState: ((Bool) -> Void)?
    
    @State
    var isExpanding: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "chevron.right")
                .rotationEffect(isExpanding ? Angle(degrees: 90) : Angle(degrees: 0))
                .animation(.easeIn(duration: 0.2))
                .onTapGesture {
                    isExpanding.toggle()
                    onChangeExpandingState?(isExpanding)
                }
        }
        .frame(width: 100, height: 100)
    }
    
}

import PlaygroundSupport
PlaygroundPage.current.setLiveView(DisclosureAccessoryView())

//: [Next](@next)
