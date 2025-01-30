import Foundation

class Graph {
    //Adjacency List representation with dictionary
    var adjList: [Int: [Int]] = [:]
    
    // Add a node
    func addNode(_ node: Int) {
        adjList[node] = []
    }
    
    // Add an edge
    func addEdge(from source: Int, to destination: Int, bidirectional: Bool = false) {
        adjList[source]?.append(destination)
        if bidirectional {
            adjList[destination]?.append(source)
        }
    }
    
    // Remove an edge
    func removeEdge(from source: Int, to destination: Int, bidirectional: Bool = false) {
        adjList[source]?.removeAll { $0 == destination }
        if bidirectional {
            adjList[destination]?.removeAll { $0 == source }
        }
    }
    
    // Get adjacent nodes
    func getAdjacentNodes(of node: Int) -> [Int]? {
        return adjList[node]
    }
    
    // Display the graph
    func display() {
        for (node, edges) in adjList {
            print("\(node): \(edges)")
        }
    }
}

extension Graph {
    //BFS Uses Queue and Visited
    func bfs(start: Int) {
        var visited = Set<Int>()
        var queue = [Int]()
        
        queue.append(start)
        visited.insert(start)
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            print(node)
            
            if let neighbors = getAdjacentNodes(of: node) {
                for neighbor in neighbors {
                    if !visited.contains(neighbor) {
                        queue.append(neighbor)
                        visited.insert(neighbor)
                    }
                }
            }
        }
    }
    
    func dfs(start: Int) {
        var visited: Set<Int> = []
        var stack: [Int] = []
        stack.append(start)
        visited.insert(start)
        
        while !stack.isEmpty {
            let node = stack.removeLast()
            print(node, terminator: " ")
            
            if let neighbors = getAdjacentNodes(of: node) {
                for neighbor in neighbors {
                    if !visited.contains(neighbor) {
                        stack.append(neighbor)
                        visited.insert(neighbor)
                    }
                }
            }
        }
    }
    
    func recursiveDFS(start: Int) {
        var visited: Set<Int> = []
        dfsHelper(start: start, visited: &visited)
    }

    func dfsHelper(start: Int, visited: inout Set<Int>) {
        // Mark the node as visited
        visited.insert(start)
        print(start, terminator: " ")
        
        // Get the neighbors and recursively visit them
        if let neighbors = getAdjacentNodes(of: start) {
            for neighbor in neighbors {
                // Check if the neighbor has been visited
                if !visited.contains(neighbor) {
                    dfsHelper(start: neighbor, visited: &visited)
                }
            }
        }
    }
    
    //Using BFS because BFS traverse level by level
    // Shortest Path in an Unweighted Graph
    func shortestPathBFS(graph: [Int: [Int]], start: Int, end: Int) -> Int {
        var queue = [(node: Int, distance: Int)]()
        var visited = Set<Int>()
        queue.append((start, 0))
        visited.insert(start)
        
        while !queue.isEmpty {
            let (node, distance) = queue.removeFirst()
            if node == end {
                return distance
            }
            
            if let neighbors = graph[node] {
                for neighbor in neighbors {
                    if !visited.contains(neighbor) {
                        queue.append((neighbor, distance + 1))
                        visited.insert(neighbor)
                    }
                }
            }
        }
        return -1 // If no path found
    }
    
    //Basically Filling color in nodes via BFS Traversal
    func isBipartite(graph: [Int: [Int]], start: Int) -> Bool {
        var colors = [Int: Int]()
        var queue = [start]
        colors[start] = 0
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            let currentColor = colors[node]!
            
            if let neighbors = graph[node] {
                for neighbor in neighbors {
                    if colors[neighbor] == nil {
                        colors[neighbor] = 1 - currentColor
                        queue.append(neighbor)
                    } else if colors[neighbor] == currentColor {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    //. Number of Connected Components in an Undirected Graph
    func connectedComponents() -> (largest: Int, count: Int) {
        var visited: Set<Int> = []
        var count = 0
        var largest = 0
        var current = 0
        for node in adjList.keys {
            if !visited.contains(node) {
                traverse(start: node, visited: &visited, current: &current)
                count += 1
                largest = max(current, largest)
                current = 0
            }
        }
        return (largest, count)
    }

    func traverse(start: Int, visited: inout Set<Int>, current: inout Int) {
        if visited.contains(start) {
            return
        }
        visited.insert(start)
        current += 1
        if let neighbors = getAdjacentNodes(of: start) {
            for neighbor in neighbors {
                traverse(start: neighbor, visited: &visited, current: &current)
            }
        }
    }
    
//    3. Detect a Cycle in a Graph
//    Problem: Detect if a graph contains a cycle.
//    Approach:
//
//    For directed graphs, use DFS and track the recursion stack.
//    For undirected graphs, use DFS or BFS and track parent nodes to avoid trivial cycles.
    
    func hasCycleDFS(graph: [Int: [Int]]) -> Bool {
        var visited = Set<Int>()
        var stack = Set<Int>()
        
        for node in graph.keys {
            if !visited.contains(node) {
                if dfsCycleHelper(graph, node: node, visited: &visited, stack: &stack) {
                    return true
                }
            }
        }
        
        return false
    }

    func dfsCycleHelper(_ graph: [Int: [Int]], node: Int, visited: inout Set<Int>, stack: inout Set<Int>) -> Bool {
        visited.insert(node)
        stack.insert(node)
        
        if let neighbors = graph[node] {
            for neighbor in neighbors {
                if !visited.contains(neighbor) {
                    if dfsCycleHelper(graph, node: neighbor, visited: &visited, stack: &stack) {
                        return true
                    }
                } else if stack.contains(neighbor) {
                    return true
                }
            }
        }
        
        stack.remove(node)
        return false
    }
    
    //    1. Find All Paths Between Two Nodes
    //    Problem: Given a graph, find all paths between two nodes.
    //    Approach: Use DFS to explore all possible paths from the source to the destination. Keep track of the current path and backtrack when needed, The graph could be directed or undirected.
    func findAllPathsDFS(graph: [Int: [Int]], start: Int, end: Int) -> [[Int]] {
        var result = [[Int]]()
        var path = [Int]()
        var visited = Set<Int>()
        dfsHelper(graph, current: start, destination: end, visited: &visited, path: &path, result: &result)
        return result
    }
    
    func dfsHelper(_ graph: [Int: [Int]], current: Int, destination: Int, visited: inout Set<Int>, path: inout [Int], result: inout [[Int]]) {
        visited.insert(current)
        path.append(current)
        
        if current == destination {
            result.append(path)
        } else {
            if let neighbors = graph[current] {
                for neighbor in neighbors {
                    if !visited.contains(neighbor) {
                        dfsHelper(graph, current: neighbor, destination: destination, visited: &visited, path: &path, result: &result)
                    }
                }
            }
        }
        
        path.removeLast()
        visited.remove(current)
    }

}

let graph = Graph()

// Adding nodes
graph.addNode(1)
graph.addNode(2)
graph.addNode(3)

// Adding edges
graph.addEdge(from: 1, to: 2)
graph.addEdge(from: 1, to: 3, bidirectional: true)
graph.addEdge(from: 2, to: 3)

// Displaying the graph
graph.display()

graph.bfs(start: 1)

graph.dfs(start: 1)
print("")
graph.recursiveDFS(start: 1)

func numIslands(_ grid: [[Character]]) -> Int {
    var visited: Set<(Int, Int)> = []
    var count: Int = .zero
    for r in 0..<grid.count {
        for c in 0..<grid[0].count {
            if explore(grid, pos: (r, c), visited: &visited) {
                count += 1
            }
        }
    }
    return count
}

func explore(_ grid: [[Character]], pos: (row: Int, col: Int), visited: inout Set<(Int, Int)>) -> Bool {
    var rowInBounds: Bool {
        pos.row >= 0 && pos.row < grid.count
    }
    
    var colInBounds: Bool {
        pos.col >= 0 && pos.col < grid[0].count
    }
    
    if !rowInBounds || !colInBounds {
        return false
    }
    
    if grid[pos.row][pos.col] == "0" {
        return false
    }
    
    if visited.contains(grid[pos.row][pos.col]) {
        return false
    }
    
    visited.insert(pos)
    
    explore(grid, pos: (pos.row - 1, pos.col), visited: &visited)
    explore(grid, pos: (pos.row + 1, pos.col), visited: &visited)
    explore(grid, pos: (pos.row, pos.col - 1), visited: &visited)
    explore(grid, pos: (pos.row, pos.col + 1), visited: &visited)
    
    return true
}


//Surrounded Regions.

func solve(_ board: inout [[Character]]) {
    guard !board.isEmpty else { return }
    
    let rows = board.count
    let cols = board[0].count
    var visited: Set<(Int, Int)> = []
    
    // Mark all 'O's connected to the border
    for r in 0..<rows {
        for c in [0, cols - 1] where board[r][c] == "O" {
            markBorderConnected(&board, pos: (r, c), visited: &visited)
        }
    }
    for c in 0..<cols {
        for r in [0, rows - 1] where board[r][c] == "O" {
            markBorderConnected(&board, pos: (r, c), visited: &visited)
        }
    }
    
    // Flip all unmarked 'O's to 'X' and revert '#' back to 'O'
    for r in 0..<rows {
        for c in 0..<cols {
            if board[r][c] == "O" {
                board[r][c] = "X"
            } else if board[r][c] == "#" {
                board[r][c] = "O"
            }
        }
    }
}

func markBorderConnected(_ board: inout [[Character]], pos: (row: Int, col: Int), visited: inout Set<(Int, Int)>) {
    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    var stack: [(Int, Int)] = [pos]
    
    while !stack.isEmpty {
        let (row, col) = stack.removeLast()
        
        if visited.contains((row, col)) {
            continue
        }
        
        visited.insert((row, col))
        board[row][col] = "#"
        
        for direction in directions {
            let newRow = row + direction.0
            let newCol = col + direction.1
            if newRow >= 0 && newRow < board.count && newCol >= 0 && newCol < board[0].count && board[newRow][newCol] == "O" {
                stack.append((newRow, newCol))
            }
        }
    }
}

//Interesting BFS Question since it's minimum Mutation ?
func minMutation(_ startGene: String, _ endGene: String, _ bank: [String]) -> Int {
    // Set of allowed mutations
    let bankSet = Set(bank)
    guard bankSet.contains(endGene) else { return -1 }
    
    // Characters that can be used in mutations
    let genes: [Character] = ["A", "C", "G", "T"]
    
    // BFS queue initialized with the start gene and mutation count
    var queue = [(startGene, 0)]
    var visited = Set<String>()
    visited.insert(startGene)
    
    while !queue.isEmpty {
        let (currentGene, mutations) = queue.removeFirst()
        
        // Check if we've reached the end gene
        if currentGene == endGene {
            return mutations
        }
        
        // Try mutating each character in the gene
        for i in currentGene.indices {
            for gene in genes {
                let e = i
                var mutatedGene = Array(currentGene)
                mutatedGene[currentGene.distance(from: currentGene.startIndex, to: i)] = gene
                let mutatedGeneStr = String(mutatedGene)
                
                // If the mutated gene is in the bank and hasn't been visited, enqueue it
                if bankSet.contains(mutatedGeneStr) && !visited.contains(mutatedGeneStr) {
                    visited.insert(mutatedGeneStr)
                    queue.append((mutatedGeneStr, mutations + 1))
                }
            }
        }
    }
    
    // If we exhaust the BFS without finding the end gene, return -1
    return -1
}
