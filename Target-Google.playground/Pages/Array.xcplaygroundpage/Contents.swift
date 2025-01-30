import Foundation

func linearSearch(_ key: Int, in items: [Int]) -> Int? {
    for (index, value) in items.enumerated() {
        if value == key {
            return index
        }
    }
    return nil
}

func isPallindrome(_ input: [Int]) -> Bool {
    var left = 0
    var right = input.count - 1
    
    while left < right {
        if input[left] == input[right] {
            left += 1
            right -= 1
        } else {
            return false
        }
    }
    
    return left == right || left > right
}

isPallindrome([1, 1, 0, 4, 1, 1])

func reverse(_ num: Int) -> Int {
    var currentNum = num
    var reverse: Int = .zero
    while currentNum != 0 {
        let lastDigit = currentNum % 10
        currentNum = currentNum / 10
        reverse = reverse * 10 + lastDigit
    }
    return reverse
}

reverse(342)

func twoSum(_ input: [Int], target: Int) -> [Int] {
    
    var memo: [Int : Int] = [:]
    
    for (index, element) in input.enumerated() {
        let complement = target - element
        
        if let complementIndex = memo[complement] {
            return [index, complementIndex]
        }
        memo[element] = index
    }
    return []
}


func threeSum(_ input: inout [Int], target: Int) -> [[Int]] {
    input.sort()
    var result = [[Int]]()
    
    for (index, element) in input.enumerated() {
        if index > 0 && element == input[index - 1] {
            continue // Skip duplicates
        }
        var left: Int = index + 1
        var right = input.count - 1
        
        while left < right {
            let sum = element + input[left] + input[right]
            if sum == target {
                result.append([element, input[left], input[right]])
                
                // Skip duplicates for left and right
                while left < right && input[left] == input[left + 1] {
                    left += 1
                }
                while left < right && input[right] == input[right - 1] {
                    right -= 1
                }
                
                left += 1
                right -= 1
            } else if sum > target {
                right -= 1
            } else {
                left += 1
            }
        }
    }
    return result
}

let a = " ".split(separator: " ").last?.count

let result = twoSum([2, 7, 11, 15], target: 17)
print(result)

//Maximum Distance

//input: [3, 5, 4, 1] [3, 1, 4, 2]

func maxDistance(_ input: [Int]) -> (Int, Int) {
    for (index, element) in input.enumerated() {
        var left = 0
        var right = input.count - 1
        
        var maxDistance: Int = .zero
        while left < right {
            if input[left] > input[right] {
                right -= 1
            } else {
                maxDistance =  max(maxDistance, (right - left))
            }
        }
    }
    return (0, 0)
}

func longestMatch(_ input: [String], str: String) -> String? {
    var largetsMatch: String?
    for name in input {
        var count = name.count
        
        for c in name {
            if str.contains(c) {
                count -= 1
            }
        }
        
        if count == .zero && largetsMatch?.count ?? .zero < name.count {
            largetsMatch = name
        }
    }
    return largetsMatch
}

longestMatch(["ale", "apple", "monkey", "plea"], str: "abcplea")

//Input : arr[] = {1, 2, 3, 4, 5}, k = 3
//Output : {5, 1, 4}
//Explanation :
//Median m = 3,
//Difference of each array elements from median,
//1 ==> diff(1-3) = 2
//2 ==> diff(2-3) = 1
//3 ==> diff(3-3) = 0
//4 ==> diff(4-3) = 1
//5 ==> diff(5-3) = 2
//First K elements are 5, 1, 4 in this array.

//Brute Force

func absoluteDifference(_ input: inout [Int], k: Int) -> [Int] {
    input.sorted()
    
    let median = median(of: input)
    
    var absDiff: [Int] = []
    
    var output: [Int] = []
    
    for e in input {
        let diff = abs(e - median)
        absDiff.append(diff)
    }
    
    var left = 0
    var right = input.count - 1
    
    var _k = k
    
    while k != 0 {
        if absDiff[left] > absDiff[right] {
            output.append(absDiff[left])
            left += 1
        } else {
            output.append(absDiff[right])
            right -= 1
        }
        _k -= 1
    }
    return output
}

func median(of input: [Int]) -> Int {
    var isEventLength = input.count % 2 == 0
    if isEventLength {
        let midLeft: Int = (input.count / 2) - 1
        let midRight: Int = (input.count / 2)
        return (input[midLeft] + input[midRight]) / 2
    } else {
        let midIndex = input.count / 2
        return input[midIndex]
    }
}

//Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
//Output: [1,2,2,3,5,6]
//Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
//The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var left = m - 1
    var right = n - 1
    
    var current = m + n - 1
    
    while left >= 0 && right >= 0 {
        if nums1[left] > nums2[right] {
            nums1[current] = nums1[left]
            left -= 1
        } else {
            nums1[current] = nums2[right]
            right -= 1
        }
        current -= 1
    }
    
    while right >= 0 {
        nums1[current] = nums2[right]
        right -= 1
        current -= 1
    }
}


func findDifference(_ nums1: [Int], _ nums2: [Int]) -> [[Int]] {
    let set1: Set<Int> = Set(nums1)
    
    let set2: Set<Int> = Set(nums2)
    
    let output1 = set1.subtracting(set2)
    
    let output2 = set2.subtracting(set1)
    
    return [Array(output1), Array(output2)]
}

func uniqueOccurrences(_ arr: [Int]) -> Bool {
    var occurences: [Int : Int] = [:]
    for n in arr {
        occurences[n, default: .zero] += 1
    }
    
    let unique = Set(occurences.values)
    
    return unique.count == occurences.values.count
}

//Modified Kadanes...
func largestSumSubArray(_ nums: [Int]) -> [Int] {
    guard !nums.isEmpty else { return [] } // Handle empty array edge case
    
    var largestSum = nums[0] // Start with the first element
    var currentSum = nums[0] // Current running sum
    
    var start = 0 // Start index of the current subarray
    var tempStart = 0 // Potential new start index when a new subarray is considered
    var end = 0 // End index of the subarray with the largest sum
    
    for i in 1..<nums.count {
        if currentSum + nums[i] > nums[i] {
            currentSum += nums[i] // Continue the current subarray
        } else {
            currentSum = nums[i] // Start a new subarray
            tempStart = i // Potential new start index
        }
        
        if currentSum > largestSum {
            largestSum = currentSum // Update largestSum if currentSum is greater
            start = tempStart // Confirm the new start index
            end = i // Update the end index
        }
    }
    
    return Array(nums[start...end]) // Return the subarray with the largest sum
}

let array = [1, 2, 3, 4, 5]

print("Using reversed() with enumerated():")
for (index, element) in array.reversed().enumerated() {
    let reversedIndex = array.count - 1 - index
    print("Index: \(reversedIndex), Element: \(element)")
}

print("\nUsing stride loop:")
for index in stride(from: array.count - 1, through: 0, by: -1) {
    let element = array[index]
    print("Index: \(index), Element: \(element)")
}

print("\nUsing indices.reversed():")
for index in array.indices.reversed() {
    let element = array[index]
    print("Index: \(index), Element: \(element)")
}

print("\nUsing enumerated() with reversed():")
for (index, element) in array.enumerated().reversed() {
    print("Index: \(index), Element: \(element)")
}
