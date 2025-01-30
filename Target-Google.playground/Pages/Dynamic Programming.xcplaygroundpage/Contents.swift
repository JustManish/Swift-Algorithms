import Foundation

func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
    let n = text1.count, m = text2.count
    let text1 = Array(text1), text2 = Array(text2)
    var dp = Array(repeating: Array(repeating: 0, count: m + 1), count: n + 1)
    
    for i in 1...n {
        for j in 1...m {
            if text1[i - 1] == text2[j - 1] {
                dp[i][j] = dp[i - 1][j - 1] + 1
            } else {
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
            }
        }
    }
    return dp[n][m]
}

let count = longestCommonSubsequence("abcabc", "abc")
print(count)
