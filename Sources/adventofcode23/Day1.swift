import Foundation

extension String {
    func digitize() -> Int {
        let major = String(first(where: { $0.isNumber }) ?? "0")
        let minor = String(reversed().first(where: { $0.isNumber }) ?? "0")
        return Int(major + minor) ?? 0
    }

    func indexOf(_ str: String) -> Int? {
        if let range = range(of: str) {
            return distance(from: startIndex, to: range.lowerBound)
        }
        return nil
    }
    func unspelledDigitize() -> Int {
        guard !self.isEmpty else { return 0 }
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: "en_EN")
        // array of (digit, index)
        let majorFound: [(Int, Int)] = (0...9).compactMap {
            if let index = indexOf("\($0)") {
                return ($0, index)
            }
            return nil
        }   // Digits
        + (0...9).compactMap {
            if let index = indexOf(formatter.string(for: $0)!) {
                return ($0, index)
            }
            return nil
        } // Words
        let major = majorFound.min(by: { $0.1 < $1.1 })!.0

        let selfRev = String(reversed())
        let minorFound: [(Int, Int)] = (0...9).compactMap {
            if let index = selfRev.indexOf("\($0)") {
                return ($0, index)
            }
            return nil
        }   // stigiD
        + (0...9).compactMap {
            if let index = selfRev.indexOf(String(formatter.string(for: $0)!.reversed())) {
                return ($0, index)
            }
            return nil
        } // sdroW
        let minor = minorFound.min(by: { $0.1 < $1.1 })!.0
        return major * 10 + minor
    }
}

class Task1: Task {
    func calc(_ inputFile: String) -> Int {
        fileDataWithEmptyLines(inputFile)
            .map { $0.digitize() }
            .reduce(0, +)
    }
}

class Task2: Task {
    func calc(_ inputFile: String) -> Int {
        fileDataWithEmptyLines(inputFile)
            .map { $0.unspelledDigitize() }
            .reduce(0, +)
    }
}
