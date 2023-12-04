import Foundation

extension TimeInterval {
    init?(dispatchTimeInterval: DispatchTimeInterval) {
        switch dispatchTimeInterval {
        case .seconds(let value):
            self = Double(value)
        case .milliseconds(let value):
            self = Double(value) / 1_000
        case .microseconds(let value):
            self = Double(value) / 1_000_000
        case .nanoseconds(let value):
            self = Double(value) / 1_000_000_000
        case .never:
            return nil
        @unknown default:
            fatalError()
        }
    }
}

protocol Task {
    func run(_ inputFile: String, _ expected: Int)
    func calc(_ inputFile: String) -> Int
}

var total: TimeInterval = 0

extension Task {
    func run(_ inputFile: String, _ expected: Int) {
        let start: DispatchTime = .now()
        let result = calc(inputFile)
        let duration = start.distance(to: .now())
        out(result, expected, TimeInterval(dispatchTimeInterval: duration)!)
    }

    func fileData(_ inputFile:String) -> [String] {
        let file = Bundle.module.path(forResource: "Input/\(inputFile)", ofType: "txt")!
        return try! String(contentsOfFile: file).components(separatedBy: CharacterSet.newlines).compactMap { $0.isEmpty ? nil : $0 }
    }

    func fileDataWithEmptyLines(_ inputFile:String) -> [String] {
        let file = Bundle.module.path(forResource: "Input/\(inputFile)", ofType: "txt")!
        return try! String(contentsOfFile: file).components(separatedBy: CharacterSet.newlines)
    }

    func out(_ result: Int, _ expected: Int, _ duration: TimeInterval) {
        total += duration
        if result == expected {
            print(String(format:"%@ - result '%lu' in %.3f sec", String(describing: Self.self), result, duration))
        } else {
            print(String(format:"%@ - wrong result '%lu' while expected '%lu'. Wasted %.3f sec", String(describing: Self.self), result, expected, duration))
        }
    }
}
