import Foundation

//Array should be sorted for this Algorithm
func binarySearch(_ key: Int, in items: [Int]) -> Int? {
    var lower = 0
    var upper = items.count - 1
    
    while lower <= upper {
        let midIndex = lower + (upper - lower) / 2
        if items[midIndex] == key {
            return midIndex
        }
        if key > items[midIndex] {
            lower = midIndex + 1
        } else {
            upper = midIndex - 1
        }
    }
    return nil
}

binarySearch(4, in: [2, 4, 5, 6, 9])

func searchInRotatedArray(_ array: [Int], target: Int) -> Int? {
    var low = 0
    var high = array.count - 1
    
    while low <= high {
        let mid = low + (high - low) / 2
        if array[mid] == target {
            return mid
        }
        
        //Left Sorted
        if array[low] <= array[mid] {
            if target >= array[low] && target < array[mid] {
                high = mid - 1
            } else {
                low = mid + 1
            }
        } else {
            if target > array[mid] && target <= array[high] {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
    }
    
    return nil
}

// Example Usage
let array = [4, 5, 6, 7, 0, 1, 2]
if let index = searchInRotatedArray(array, target: 0) {
    print("Element 0 is at index \(index)")
} else {
    print("Element 0 not found in the array")
}

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard !matrix.isEmpty, !matrix[0].isEmpty else {
        return false
    }
    
    let rows = matrix.count
    let couloumns = matrix[0].count
    
    var lastColumn = [Int](repeating: 0, count: rows)
    
    for row in 0..<rows {
        lastColumn[row] = matrix[row][couloumns - 1]
    }
    
    var lower = 0
    var upper = lastColumn.count - 1
    
    while lower <= upper {
        let mid = lower + (upper - lower) / 2
        
        if target == lastColumn[mid] {
            return true
        } else if target > lastColumn[mid] {
            lower = mid + 1
        } else {
            upper = mid - 1
        }
    }
    
    // If lower goes out of bounds, return false
    if lower >= rows {
        return false
    }
    
    var whichRow = lower
    
    lower = 0
    upper = couloumns - 1
    
    while lower <= upper {
        let mid = lower + (upper - lower) / 2
        
        if target == matrix[whichRow][mid] {
            return true
        } else if target > matrix[whichRow][mid] {
            lower = mid + 1
        } else {
            upper = mid - 1
        }
    }
    return false
}

let matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]]

let isExist = searchMatrix(matrix, 3)
print("Exist: ",isExist)
