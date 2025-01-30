import Foundation

func dfs(_ graph: [Int: [Int]], start: Int) {
    var visited: Set<Int> = [start]
    var stack: [Int] = [start]
    
    while !stack.isEmpty {
        let node = stack.removeLast()
        
        print(node, terminator: " ")
        
        if let neighbors = graph[node] {
            for neighbor in neighbors.reversed() {
                if !visited.contains(neighbor) {
                    stack.append(neighbor)
                    visited.insert(neighbor)
                }
            }
        }
    }
}

func recurssiveDFS(_ graph: [Int: [Int]], start: Int, visited: inout [Int]) {
    visited.append(start)
    print(start, terminator: " ")
    
    if let neighbors = graph[start] {
        for neighbor in neighbors {
            if !visited.contains(neighbor) {
                recurssiveDFS(graph, start: neighbor, visited: &visited)
            }
        }
    }
}

let graph = 
[
    0: [1, 2],
    1: [2, 3],
    2: [1, 3],
    3: [2]
]
