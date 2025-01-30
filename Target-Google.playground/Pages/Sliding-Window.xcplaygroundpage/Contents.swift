import Foundation

//Sliding Window Algorithm


//You are given an integer array nums consisting of n elements, and an integer k.
//
//Find a contiguous subarray whose length is equal to k that has the maximum average value and return this value. Any answer with a calculation error less than 10-5 will be accepted.

 
func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
    var currentSum = 0
    
    for j in 0..<k {
        currentSum += nums[j]
    }
    
    var maxSum = currentSum
    
    for i in 1..<nums.count - k + 1 {
        let nextSum = currentSum - nums[i - 1] + nums[k + i]
        maxSum = max(nextSum, maxSum)
        currentSum = nextSum
    }
    
    return Double(maxSum / nums.count)
}

//Given a string s and an integer k, return the maximum number of vowel letters in any substring of s with length k.
//
//Vowel letters in English are 'a', 'e', 'i', 'o', and 'u'.

func maxVowels(_ s: String, _ k: Int) -> Int {
    // Helper function to count vowels in a given string
    func vowelCount(in input: Substring) -> Int {
        var count = 0
        for c in input {
            switch c {
            case "a", "e", "i", "o", "u", "A", "E", "I", "O", "U":
                count += 1
            default:
                continue
            }
        }
        return count
    }
    
    // Initial count of vowels in the first substring of length k
    var startIndex = s.startIndex
    var endIndex = s.index(startIndex, offsetBy: k)
    var currentSubstring = s[startIndex..<endIndex]
    var maxVowelsCount = vowelCount(in: currentSubstring)
    var currentVowelsCount = maxVowelsCount
    
    // Sliding window approach to find maximum number of vowels in any substring of length k
    for i in 1..<(s.count - k + 1) {
        // Move the window one character to the right
        let previousStartIndex = s.index(startIndex, offsetBy: 0)
        startIndex = s.index(s.startIndex, offsetBy: i)
        endIndex = s.index(startIndex, offsetBy: k)
        
        // Adjust the count for the character that is sliding out of the window
        if ["a", "e", "i", "o", "u"].contains(s[previousStartIndex].lowercased()) {
            currentVowelsCount -= 1
        }
        
        // Adjust the count for the character that is sliding into the window
        if endIndex < s.endIndex {
            let newCharIndex = s.index(endIndex, offsetBy: -1)
            if ["a", "e", "i", "o", "u"].contains(s[newCharIndex].lowercased()) {
                currentVowelsCount += 1
            }
        }
        
        // Update the maximum vowel count if necessary
        maxVowelsCount = max(maxVowelsCount, currentVowelsCount)
    }
    
    return maxVowelsCount
}

// Example usage:
let s = "weallloveyou"
let k = 7
print(maxVowels(s, k)) // Output: 3

func _maxVowels(_ s: String, _ k: Int) -> Int {
    let vowels = Set("aeiouAEIOU")
    
    // Helper function to check if a character is a vowel
    func isVowel(_ char: Character) -> Bool {
        return vowels.contains(char)
    }
    
    var maxVowelsCount = 0
    var currentVowelsCount = 0
    
    // Convert the string to an array of characters to avoid repeated index calculations
    let characters = Array(s)
    
    // Initial count of vowels in the first substring of length k
    for i in 0..<k {
        if isVowel(characters[i]) {
            currentVowelsCount += 1
        }
    }
    maxVowelsCount = currentVowelsCount
    
    // Sliding window approach to find maximum number of vowels in any substring of length k
    for i in 1..<(characters.count - k + 1) {
        if isVowel(characters[i - 1]) {
            currentVowelsCount -= 1
        }
        if isVowel(characters[i + k - 1]) {
            currentVowelsCount += 1
        }
        maxVowelsCount = max(maxVowelsCount, currentVowelsCount)
    }
    
    return maxVowelsCount
}

func findSubstring(_ s: String, _ words: [String]) -> [Int] {
    var wordDict: [String: Int] = [:]
    for word in words {
        wordDict[word, default: 0] += 1
    }
    
    let wordLength = words[0].count
    let totalWords = words.count
    let totalLength = wordLength * totalWords
    
    var result: [Int] = []
    
    for i in 0..<(s.count - totalLength + 1) {
        var seenWords: [String: Int] = [:]
        var j = 0
        
        while j < totalWords {
            let start = s.index(s.startIndex, offsetBy: i + j * wordLength)
            let end = s.index(start, offsetBy: wordLength)
            let word = String(s[start..<end])
            
            if let count = wordDict[word] {
                seenWords[word, default: 0] += 1
                
                if seenWords[word]! > count {
                    break
                }
            } else {
                break
            }
            
            j += 1
        }
        
        if j == totalWords {
            result.append(i)
        }
    }
    
    return result
}

func longestSubstringWithKDistinct(_ str: String, _ k: Int) -> Int {
    var windowStart = str.startIndex
    var maxLength = 0
    var charFrequency = [Character: Int]()
    
    for windowEnd in str.indices {
        let endChar = str[windowEnd]
        charFrequency[endChar, default: 0] += 1
        
        // Shrink the sliding window, until we are left with 'k' distinct characters in the frequency dictionary
        while charFrequency.keys.count > k {
            let startChar = str[windowStart]
            charFrequency[startChar, default: 0] -= 1
            if charFrequency[startChar] == 0 {
                charFrequency.removeValue(forKey: startChar)
            }
            windowStart = str.index(after: windowStart)
        }
        
        // Update the maximum length found so far
        maxLength = max(maxLength, str.distance(from: windowStart, to: windowEnd) + 1)
    }
    
    return maxLength
}

// Example usage
print(longestSubstringWithKDistinct("araaci", 2)) // 4
print(longestSubstringWithKDistinct("araaci", 1)) // 2
print(longestSubstringWithKDistinct("cbbebi", 3)) // 5


func maxFrequency(_ nums: [Int], _ k: Int) -> Int {
    // Step 1: Sort the array
    var sortedNums = nums.sorted()
    var maxFrequency = 0
    var left = 0
    var totalOperations = 0

    // Step 2: Use a sliding window to find the maximum frequency
    for right in 0..<sortedNums.count {
        // Add the current element to total operations
        totalOperations += sortedNums[right]

        // Step 3: Calculate the number of operations needed to make all elements in the window equal to sortedNums[right]
        while (right - left + 1) * sortedNums[right] - totalOperations > k {
            // Step 4: If operations exceed k, shrink the window from the left
            totalOperations -= sortedNums[left]
            left += 1
        }

        // Step 5: Update the maximum frequency
        maxFrequency = max(maxFrequency, right - left + 1)
    }

    return maxFrequency
}

// Example Usage
let nums = [1, 2, 4]
let result = maxFrequency(nums, k)
print("Maximum frequency is \(result)")  // Output: Maximum frequency is 3


let _r: [Int] = []

let a = [1, 2]

let b = [3]

let _s = a + b + _r
