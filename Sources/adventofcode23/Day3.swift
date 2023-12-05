class Task5: Task {
    func calc(_ inputFile: String) -> Int {
        var count = 0
        let scheme = fileDataWithEmptyLines(inputFile).dropLast()
        let len = scheme[0].count
        for (y, line) in scheme.enumerated() {
            var strNumber = ""
            for (x, ch) in line.enumerated() {
                if ch.isNumber {
                    strNumber += String(ch)
                    if x == line.count-1 || !line[line.index(line.startIndex, offsetBy: x + 1)].isNumber { // last in line or next isn't number
                        let leading = max(x-strNumber.count, 0)
                        let top = max(y-1, 0)
                        let trailing = min(x+1, line.count-1)
                        let bottom = min(y+1, scheme.count-1)
                        if !scheme[top...bottom]
                            .flatMap({ Array($0)[leading...trailing] })
                            .filter({ !$0.isNumber && $0 != "." })
                            .isEmpty {
                                count += Int(strNumber) ?? 0
                            }
                        strNumber = ""
                    }
                }
            }
        }
        return count
    }
}
