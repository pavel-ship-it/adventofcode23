extension String {
    func d4p1gameResult() -> Int {
        guard let q = self.firstIndex(of: ":") else { return 0 }                // "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
        let result = self[q...].dropFirst()                                     // " 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
            .split(separator: "|")                                              // [" 41 48 83 86 17 ", " 83 86  6 31 17  9 48 53"]
        let winning = result[0].split(separator: " ").compactMap { $0.replacingOccurrences(of: " ", with: "").isEmpty ? nil : Int(String($0).replacingOccurrences(of: " ", with: "")) } // [41, 48, 83, 86, 17]
        let card = result[1].split(separator: " ").compactMap { $0.replacingOccurrences(of: " ", with: "").isEmpty ? nil : Int(String($0).replacingOccurrences(of: " ", with: "")) }    // [83, 86, 6, 31, 17, 9, 48, 53]
        let matching = card.compactMap { winning.contains($0) ? $0 : nil }.count // 4
        return 1 << (matching-1)                                                // 0b100 = 8
    }
}
class Task7: Task {
    func calc(_ inputFile: String) -> Int {
        fileDataWithEmptyLines(inputFile).dropLast()
            .compactMap { $0.d4p1gameResult() }
            .reduce(0, +)
    }
}
