import Foundation

func maxProfit(_ prices: [Int], _ fee: Int) -> Int {
    // If prices array is empty, return 0 as no transactions can be made
    if prices.isEmpty {
        return 0
    }
    
    // Initialize states
    var cash = 0          // Max profit if we do not own a stock
    var hold = -prices[0] // Max profit if we own a stock (bought on the first day)
    
    // Iterate through each day's price
    for price in prices {
        // Calculate new cash and hold values using the state transition equations
        cash = max(cash, hold + price - fee) // Sell stock, transitioning from hold to cash
        hold = max(hold, cash - price)       // Buy stock, transitioning from cash to hold
    }
    
    // The result is the maximum profit if we do not own any stock at the end
    return cash
}

print(maxProfit([1, 3, 2, 8, 4, 9], 2)) // Output: 8



func maxProfit(_ prices: [Int]) -> Int {
    var minPrice = Int.max
    var maxProfit = 0
    for price in prices {
        minPrice = min(minPrice, price)
        maxProfit = max(maxProfit, price - minPrice)
    }
    return maxProfit
}

func maxProfit(_ prices: [Int]) -> Int {
    var maxProfit = 0
    for i in 1..<prices.count {
        if prices[i] > prices[i - 1] {
            maxProfit += prices[i] - prices[i - 1]
        }
    }
    return maxProfit
}
/*
Best Time to Buy and Sell Stock with Cooldown
Problem: You cannot buy stock on the day after you sell it (cooldown period).
Approach: Use dynamic programming with three states (holding, not holding, and in cooldown).
*/

func maxProfit(_ prices: [Int]) -> Int {
    guard prices.count > 1 else { return 0 }
    
    var hold = -prices[0]
    var sell = 0
    var rest = 0
    
    for i in 1..<prices.count {
        let prevHold = hold
        let prevSell = sell
        hold = max(hold, rest - prices[i])
        rest = max(rest, prevSell)
        sell = prevHold + prices[i]
    }
    
    return max(sell, rest)
}

