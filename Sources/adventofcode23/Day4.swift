extension String {
    func d4p1gameResult() -> Int {                                              // returns number of winning number in card
        guard let q = self.firstIndex(of: ":") else { return 0 }                // "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
        let result = self[q...].dropFirst()                                     // " 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
            .split(separator: "|")                                              // [" 41 48 83 86 17 ", " 83 86  6 31 17  9 48 53"]
            .map { $0.split(separator: " ").compactMap { Int(String($0).replacingOccurrences(of: " ", with: "")) } } // [[41, 48, 83, 86, 17], [83, 86, 6, 31, 17, 9, 48, 53]]
        return result[1].compactMap { result[0].contains($0) ? $0 : nil }.count // 4
    }
}

class Task7: Task {
    func calc(_ inputFile: String) -> Int {
        fileDataWithEmptyLines(inputFile).dropLast()
            .compactMap { 1 << ($0.d4p1gameResult()-1) }                        // 0b00000001 << 3 = 0b00000100 = 8
            .reduce(0, +)
    }
}

class Task8: Task {
    func calc(_ inputFile: String) -> Int {
        let cards = fileDataWithEmptyLines(inputFile).dropLast()
        var counts = [Int](repeating: 1, count: cards.count)
        for (i, card) in cards.enumerated() {
            let count = card.d4p1gameResult()
            if count == 0 || i+count > cards.count { continue }
            for j in (i+1...i+count) {                                          // For number of next cards
                counts[j] += counts[i]                                          // Advance count for number of curret cards
            }
        }
        return counts.reduce(0, +)
    }
}
