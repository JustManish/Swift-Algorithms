import Foundation

//Alvin the programmer

class Solution {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        // Memoization dictionary
        var memo: [Int: [[Int]]] = [:]
        return findCombinations(candidates, target, &memo)
    }
    
    private func findCombinations(_ candidates: [Int], _ target: Int, _ memo: inout [Int: [[Int]]]) -> [[Int]] {
        // Check if result is already computed
        if let result = memo[target] {
            return result
        }
        
        // Base case: if target is 0, return one valid combination (empty combination)
        if target == 0 {
            return [[]]
        }
        
        // Base case: if target is negative, return an empty list
        if target < 0 {
            return []
        }
        
        // List to store combinations for the current target
        var combinations: [[Int]] = []
        
        // Explore all candidates
        for candidate in candidates {
            let remainder = target - candidate
            // Recursive call with the updated target
            let subCombinations = findCombinations(candidates, remainder, &memo)
            
            // For each combination found, prepend the current candidate
            for combination in subCombinations {
                var newCombination = combination
                newCombination.append(candidate)
                combinations.append(newCombination)
            }
        }
        
        // Cache the result
        memo[target] = combinations
        return combinations
    }
}

// Example usage:
let solution = Solution()
let candidates = [2, 3, 6, 7]
let target = 7
let result = solution.combinationSum(candidates, target)
print(result) // Output: [[2, 2, 3], [7]]

    
//Longest Increasing Subsequence
func lengthOfLIS(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    
    var memo: [Int: Int] = [:]
    var maxLength = 1
    
    for i in 0..<nums.count {
        maxLength = max(maxLength, LIS(nums, i, &memo))
    }
    
    return maxLength
}

private func LIS(_ nums: [Int], _ currentIndex: Int, _ memo: inout [Int: Int]) -> Int {
    if let cachedResult = memo[currentIndex] {
        return cachedResult
    }
    
    var maxLength = 1
    
    for previousIndex in 0..<currentIndex {
        if nums[currentIndex] > nums[previousIndex] {
            maxLength = max(maxLength, 1 + LIS(nums, previousIndex, &memo))
        }
    }
    
    memo[currentIndex] = maxLength
    return maxLength
}

