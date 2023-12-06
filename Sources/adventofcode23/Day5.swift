class Task9: Task {
    func calc(_ inputFile: String) -> Int {
        let data = fileDataWithEmptyLines(inputFile)
        let seeds = data[0].dropFirst(7).split(separator: " ").compactMap { Int($0) }   // [Int]
        let maps = data
            .dropFirst().dropLast()
            .reduce(into: [[(Int, Int, Int)]]()) { out, line in
            if line.isEmpty {
                out.append([])
            } else if line.first!.isNumber {
                let ints = line.split(separator: " ").compactMap { Int($0) }
                out[out.count-1].append((ints[0], ints[1], ints[2]))
            }
        }
            .map { $0.sorted { $0.0 < $1.0 } }                                  // [[(50, 98, 2), ...], ...]
        var out = Int.max
        for seed in seeds {
            var seed = seed
            maps.forEach { map in
                for (dst, src, ln) in map {
                    if seed >= src && seed < src+ln {
                        seed += dst - src                                       // 79 -> 81 -> _ -> _ -> 74 -> 78 -> 82
                        break
                    }
                }
            }
            out = min(out, seed)
        }

        return out
    }
}
