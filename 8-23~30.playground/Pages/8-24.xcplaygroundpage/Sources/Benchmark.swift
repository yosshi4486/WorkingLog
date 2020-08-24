import Foundation

// https://qiita.com/tady/items/40d7c4feecda337cf271から拝借
public struct Benchmark {
    
    // 開始時刻を保存する変数
    var startTime: Date
    var key: String
    
    // 処理開始
    public init(key: String) {
        self.startTime = Date()
        self.key = key
    }
    
    // 処理終了
    public func finish() {
        let elapsed = Date().timeIntervalSince(startTime) as Double
        let formatedElapsed = String(format: "%.3f", elapsed)
        print("Benchmark: \(key), Elasped time: \(formatedElapsed)(s)")
    }
    
    // 処理をブロックで受け取る
    public static func measure(key: String, block: () -> ()) {
        let benchmark = Benchmark(key: key)
        block()
        benchmark.finish()
    }
    
}
