import Foundation

func frequencyCount(_ nums: [Int], _ n: Int) -> [Int] {
    //nums contains from 1 to p
    
    var frequency: [Int] = Array(repeating: 0, count: n)
        
    for num in nums {
        // Check if the number is within the valid range (1 to n)
        if num >= 1 && num <= n {
            // Increment the corresponding index in frequency array
            frequency[num - 1] += 1
        }
    }
    return frequency
}


let frequencyCounts = frequencyCount([1, 1, 2, 2, 3, 3, 4, 9], 8)
print("freq: ",frequencyCounts)
