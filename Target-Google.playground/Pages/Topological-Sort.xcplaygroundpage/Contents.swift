import Foundation

//BFS Approach to find topological ordering
/*
 1. find In-Degrees of each vertices
 2. enqueue vertices with in-degree 0's
 3.
 */
func kahnTopologicalSort(_ graph: [Int: [Int]]) -> [Int]? {
    var inDegree = [Int: Int]()
    var queue = [Int]()
    var topoOrder = [Int]()
    
    // Initialize in-degree of each vertex
    for (node, neighbors) in graph {
        inDegree[node, default: 0] += 0
        for neighbor in neighbors {
            inDegree[neighbor, default: 0] += 1
        }
    }
    
    // Enqueue vertices with 0 in-degree
    for (node, degree) in inDegree {
        if degree == 0 {
            queue.append(node)
        }
    }
    
    // Process queue
    while !queue.isEmpty {
        let node = queue.removeFirst()
        topoOrder.append(node)
        
        // Reduce in-degree of adjacent vertices
        for neighbor in graph[node] ?? [] {
            inDegree[neighbor]! -= 1
            if inDegree[neighbor]! == 0 {
                queue.append(neighbor)
            }
        }
    }
    
    // Check if topological sort includes all nodes
    return topoOrder.count == graph.count ? topoOrder : nil
}

//DFS Post order traversal
func dfsTopologicalSort(_ graph: [Int: [Int]]) -> [Int] {
    var visited = Set<Int>()
    var stack = [Int]()
    
    for node in graph.keys {
        if !visited.contains(node) {
            dfs(node)
        }
    }
    
    func dfs(_ node: Int) {
        visited.insert(node)
        for neighbor in graph[node] ?? [] {
            if !visited.contains(neighbor) {
                dfs(neighbor)
            }
        }
        stack.append(node)
    }
    return stack.reversed()
}
