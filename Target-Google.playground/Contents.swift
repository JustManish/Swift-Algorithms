/*
 Target Google
 */

// [1, 1, 2, 2, 3, 3, 4, 9]

import Foundation

//Brute Force Approach
func frequency(in input: [Int]) -> [Int] {
    guard let maxValue = input.max() else {
        return []
    }
    
    var output: [Int] = Array(repeating: 0, count: maxValue)
    for i in 0..<input.count {
        if output[input[i] - 1] != .zero {
            continue
        }
        for j in i..<input.count {
            if input[i] == input[j] {
                output[input[i] - 1] += 1
            }
        }
    }
    return output
}

func _frequency(_ input: [Int]) -> [Int] {
    var memo: [Int : Int] = [:]
    
    for i in 0..<input.count {
        let key = input[i]
        memo[key, default: .zero] += 1
    }
    
    return memo.keys.sorted().map { key in
        memo[key, default: .zero]
    }
}

print(_frequency([1, 1, 2, 2, 3, 3, 4, 9]))

var list: LinkedList<Int> = LinkedList()
