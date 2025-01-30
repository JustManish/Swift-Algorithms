import Foundation

// Define a typealias for clarity
typealias WeightedEdge = (node: Int, weight: Int)

struct PriorityQueue<Elements> {
    var edges: [Elements] = []
}

struct UnionFind {
    private var parent: [Int]
    private var rank: [Int]
    
    init(size: Int) {
        parent = Array(0..<size)
        rank = Array(repeating: 0, count: size)
    }
    
    mutating func find(_ node: Int) -> Int {
        if parent[node] != node {
            parent[node] = find(parent[node]) //Path Compression
        }
        return parent[node]
    }
    
    mutating func union(_ node1: Int, _ node2: Int) {
        let root1 = find(node1)
        let root2 = find(node2)
        
        if root1 != root2 {
            if rank[root1] > rank[root2] {
                parent[root2] = root1
            } else if rank[root1] < rank[root2] {
                parent[root1] = root2
            } else {
                parent[root2] = root1
                rank[root1] += 1
            }
        }
    }
}

//G: [(node1, node2, cost/weight)]
func kruskal(graph: [(Int, Int, Int)], vertexCount: Int) -> [(Int, Int, Int)] {
    var mst: [(Int, Int, Int)] = []
    var unionFind = UnionFind(size: vertexCount)
    
    let sortedEdges = graph.sorted { $0.2 < $1.2 }
    
    for edge in sortedEdges {
        let (node1, node2, weight) = edge
        if unionFind.find(node1) != unionFind.find(node2) {
            mst.append(edge)
            unionFind.union(node1, node2)
        }
    }
    
    return mst
}


func prim(graph: [Int: [WeightedEdge]], start: Int) -> [(Int, Int, Int)] {
    var mst: [(Int, Int, Int)] = [] // Stores the MST edges (node1, node2, weight)
    var visited = Set<Int>()
    var priorityQueue = PriorityQueue<(node1: Int, node2: Int, weight: Int)> { $0.weight < $1.weight
    }
    
    // Start with the first node
    visited.insert(start)
    if let edges = graph[start] {
        for edge in edges {
            priorityQueue.enqueue((node1: start, node2: edge.node, weight: edge.weight))
        }
    }
    
    while let (node1, node2, weight) = priorityQueue.dequeue() {
        if !visited.contains(node2) {
            visited.insert(node2)
            mst.append((node1, node2, weight))
            
            if let edges = graph[node2] {
                for edge in edges {
                    if !visited.contains(edge.node) {
                        priorityQueue.enqueue((node1: node2, node2: edge.node, weight: edge.weight))
                    }
                }
            }
        }
    }
    
    return mst
}
