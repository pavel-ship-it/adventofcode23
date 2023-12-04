
extension String {
    func parse() -> (Int, Int, Int) { // (r, g, b)
        var r = 0, g = 0, b = 0
        split(separator: ",")
            .forEach {
                let str = String($0).replacingOccurrences(of: " ", with: "") // "5red"
                if str.contains("red") {
                    r = Int(str.replacingOccurrences(of: "red", with: "")) ?? 0
                } else if str.contains("green") {
                    g = Int(str.replacingOccurrences(of: "green", with: "")) ?? 0
                } else if str.contains("blue") {
                    b = Int(str.replacingOccurrences(of: "blue", with: "")) ?? 0
                }
            }
        return (r, g, b)
    }

    func d2p1gameResult() -> Bool {
        let expectation = (12, 13, 14)
        // Game 95: 5 blue, 2 red, 9 green; ...
        guard let q = self.firstIndex(of: ":") else { return false }
        // " 5 blue, 2 red, 9 green; ..."
        let result = self[q...].dropFirst()
        // [" 5 blue, 2 red, 9 green", ...]
            .split(separator: ";")
        // [2 9 5, ...]
            .map { String($0).parse() }
        // true if ALL expectations are fulfiled
            .map { $0.0 <= expectation.0 && $0.1 <= expectation.1 && $0.2 <= expectation.2 }
        // true if all game sets are possible
            .reduce(into: true) { $0 = $1 && $0 }
        return result
    }

    func d2p2gameResult() -> Int {
        // Game 95: 5 blue, 2 red, 9 green; ...
        guard let q = self.firstIndex(of: ":") else { return 0 }
        // " 5 blue, 2 red, 9 green; ..."
        let result = self[q...].dropFirst()
        // [" 5 blue, 2 red, 9 green", ...]
            .split(separator: ";")
        // [2 9 5, ...]
            .map { String($0).parse() }
        // calc power
            .reduce(into: (0, 0, 0)) { $0 = (max($0.0, $1.0), max($0.1, $1.1), max($0.2, $1.2)) }
        return result.0 * result.1 * result.2
    }
}

class Task3: Task {
    func calc(_ inputFile: String) -> Int {
        let games = fileDataWithEmptyLines(inputFile)
            .compactMap { $0.d2p1gameResult() }
        var sum = 0
        for (i, n) in games.enumerated() {
            if n {
                sum += i + 1
            }
        }
        return sum
    }
}

class Task4: Task {
    func calc(_ inputFile: String) -> Int {
        fileDataWithEmptyLines(inputFile)
            .compactMap { $0.d2p2gameResult() }
            .reduce(0, +)
    }
}
