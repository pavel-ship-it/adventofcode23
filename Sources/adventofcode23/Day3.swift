class Task5: Task {
    func calc(_ inputFile: String) -> Int {
        var count = 0
        let scheme = fileDataWithEmptyLines(inputFile).dropLast()
        for (y, line) in scheme.enumerated() {
            var strNumber = ""
            for (x, ch) in line.enumerated() {
                if ch.isNumber {
                    strNumber += String(ch)
                    if x == line.count-1 || !line[line.index(line.startIndex, offsetBy: x + 1)].isNumber { // last in line or next isn't number
                        let leading = max(x-strNumber.count, 0)         // Define region top left to right bottom
                        let top = max(y-1, 0)
                        let trailing = min(x+1, line.count-1)
                        let bottom = min(y+1, scheme.count-1)
                        if !scheme[top...bottom]
                            .flatMap({ Array($0)[leading...trailing] }) // Array of all symbols of region
                            .filter({ !$0.isNumber && $0 != "." })      // Remove numbers and dots
                            .isEmpty {                                  // If something remains
                                count += Int(strNumber) ?? 0            // it's a part number
                            }
                        strNumber = ""
                    }
                }
            }
        }
        return count
    }
}

class Task6: Task {
    func calc(_ inputFile: String) -> Int {
        var count = 0
        let scheme = fileDataWithEmptyLines(inputFile).dropLast()
        var gears = [(Int, Int, Int)]() // part number, gear x, gear y
        for (y, line) in scheme.enumerated() {
            var strNumber = ""
            for (x, ch) in line.enumerated() {
                if ch.isNumber {
                    strNumber += String(ch)
                    if x == line.count-1 || !line[line.index(line.startIndex, offsetBy: x + 1)].isNumber { // last in line or next isn't number
                        let leading = max(x-strNumber.count, 0)         // Define region top left to right bottom
                        let top = max(y-1, 0)
                        let trailing = min(x+1, line.count-1)
                        let bottom = min(y+1, scheme.count-1)

                        if !scheme[top...bottom]
                            .flatMap({ Array($0)[leading...trailing] }) // Array of all symbols of region
                            .filter({ $0 == "*" })                      // If it's a gear
                            .isEmpty {
                            for y in (top...bottom) {                   // Get gear's x and y
                                for x in (leading...trailing) {
                                    let ch = Array(scheme[y])[x]
                                    if ch == "*" {
                                        gears.append((Int(strNumber) ?? 0, x, y))
                                    }
                                }
                            }
                        }
                        strNumber = ""
                    }
                }
            }
        }
        for (i, gear) in gears.enumerated() { // Lookup paired gears
            guard i+1 < gears.count-1 else { break }
            for secondGear in gears[i+1..<gears.count] where gear.1 == secondGear.1 && gear.2 == secondGear.2 {
                count += gear.0 * secondGear.0
            }
        }
        return count
    }
}
