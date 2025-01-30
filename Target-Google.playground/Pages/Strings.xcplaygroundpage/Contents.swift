import Foundation

//Input: nums = [0,1,2,2,3,0,4,2], val = 2
//Output: 5, nums = [0,1,4,0,3,_,_,_]  "[0, 1, 4, 0, 2, 3, 2, 2]
//Explanation: Your function should return k = 5, with the first five elements of nums containing 0, 0, 1, 3, and 4.
//Note that the five elements can be returned in any order.
//It does not matter what you leave beyond the returned k (hence they are underscores).

func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    var leftPointer = 0
    var rightPointer = nums.count - 1
    
    while leftPointer <= rightPointer {
        // Find the first occurrence of val from the left
        while leftPointer <= rightPointer && nums[leftPointer] != val {
            leftPointer += 1
        }
        
        // Find the last occurrence of non-val from the right
        while leftPointer <= rightPointer && nums[rightPointer] == val {
            rightPointer -= 1
        }
        
        if leftPointer < rightPointer {
            nums.swapAt(leftPointer, rightPointer)
        }
    }
    return leftPointer
}

var list: [Int] = [0,1,2,2,3,0,4,2]
removeElement(&list, 2)

print(list)

var str = "      abc manish patidar   "
func removeLeadingAndTrailingSpaces(_ s: String) -> String {
    var left = 0
    var right = s.count - 1
    
    var output: String = ""
    
    while s[s.index(s.startIndex, offsetBy: left)] == " " || s[s.index(s.startIndex, offsetBy: right)] == " " {
        if s[s.index(s.startIndex, offsetBy: left)] == " " {
            left += 1
        }
        
        if s[s.index(s.startIndex, offsetBy: right)] == " " {
            right -= 1
        }
    }
    
    for i in left...right {
        output.append(s[s.index(s.startIndex, offsetBy: i)])
    }
    return output
}

func seperateWords(_ s: String, _ delimiter: String) -> [String] {
    var str = removeLeadingAndTrailingSpaces(s)
    var words: [String] = []
    var word = ""
    
    for c in str {
        if c != " " {
            word.append(c)
        } else if !word.isEmpty {
            words.append(word)
            word = ""
        }
    }
    
    // Add the last word if it's not empty
    if !word.isEmpty {
        words.append(word)
    }
    
    return words
}

let output = removeLeadingAndTrailingSpaces(str)

let words = seperateWords(output, " ")

print(output)

print(words.reduce("") { $1 + " " + $0 })


func longestPalindrome(_ s: String) -> String {
    if s.isEmpty {
        return ""
    }
    
    let characters = Array(s)
    let count = characters.count
    var start = 0
    var end = 0
    
    for i in 0..<count {
        let len1 = expandAroundCenter(characters, left: i, right: i)
        let len2 = expandAroundCenter(characters, left: i, right: i + 1)
        let len = max(len1, len2)
        
        if len > end - start {
            start = i - (len - 1) / 2
            end = i + len / 2
        }
    }
    
    let startIdx = s.index(s.startIndex, offsetBy: start)
    let endIdx = s.index(s.startIndex, offsetBy: end + 1)
    
    return String(s[startIdx..<endIdx])
}

func expandAroundCenter(_ chars: [Character], left: Int, right: Int) -> Int {
    var left = left
    var right = right
    
    while left >= 0 && right < chars.count && chars[left] == chars[right] {
        left -= 1
        right += 1
    }
    
    return right - left - 1
}

// Example usage:
let input = "babad"
let result = longestPalindrome(input)
print("Longest palindromic substring of '\(input)' is '\(result)'")
