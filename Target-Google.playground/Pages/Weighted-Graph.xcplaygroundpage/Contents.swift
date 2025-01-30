import Foundation

// Define a typealias for clarity
typealias WeightedEdge = (node: Int, weight: Int)

// Adjacency list representation
let graph: [Int: [WeightedEdge]] = [
    0: [(1, 2), (2, 4)], // Node 0 connects to Node 1 with weight 2, Node 2 with weight 4
    1: [(2, 1), (3, 7)], // Node 1 connects to Node 2 with weight 1, Node 3 with weight 7
    2: [(3, 3)],         // Node 2 connects to Node 3 with weight 3
    3: []                // Node 3 has no outgoing edges
]

// Example: Access and print all edges and weights from the graph
for (node, edges) in graph {
    for edge in edges {
        print("Node \(node) connects to Node \(edge.node) with weight \(edge.weight)")
    }
}

/*
 Dijkstra's Algorithm
 Detailed Explanation
 Dijkstra's algorithm is a greedy algorithm that finds the shortest path from a starting node to all other nodes in a weighted graph. It uses a priority queue to select the node with the smallest known distance, explores its neighbors, and updates their distances if a shorter path is found.

 Initialization:

 Set the distance to the source node as 0 and all other nodes as infinity.
 Use a priority queue (min-heap) to keep track of the next node with the shortest known distance.
 Algorithm:

 Extract the node with the smallest distance from the priority queue.
 For each neighbor of the extracted node, calculate the distance from the source node. If the calculated distance is less than the known distance, update the distance and push the neighbor into the priority queue.
 Termination:

 The algorithm terminates when all nodes have been visited or the queue is empty.
 
 Analysis:
 
 Time Complexity
 The time complexity of Dijkstra's algorithm depends on the data structures used to implement the priority queue and adjacency list:

 Using a Binary Heap:

 Inserting a vertex into the priority queue takes
 𝑂(log𝑉)
 O(logV) time.
 Extracting the minimum vertex takes
 𝑂(log𝑉)
 O(logV) time.
 Updating the distance (decrease-key operation) for each vertex takes
 O(logV) time.
 For each vertex, we perform these operations once, and for each edge, we may perform a decrease-key operation once.
 Therefore, the time complexity using a binary heap is

 O((V+E)logV), where
 V is the number of vertices and
 E is the number of edges.

 Using an Unordered Array:

 Inserting and updating the array takes
 O(1) time.
 Extracting the minimum vertex takes
 O(V) time.
 The time complexity using an unordered array is
 O(V2).

 Using a Fibonacci Heap:

 Decrease-key and insertion operations can be done in
 O(1) amortized time.
 Extracting the minimum takes
 O(logV) amortized time.
 The time complexity using a Fibonacci heap is
 O(E+VlogV), which is the most efficient for dense graphs.

 4. Space Complexity
 The space complexity is
 O(V+E), which includes the space needed to store the graph and the priority queue.
 */

// Define a typealias for readability
//typealias WeightedEdge = (node: Int, weight: Int)

struct _WeightedEdge<Node: Comparable, Weight: Comparable>: Comparable {
    var node: Node
    var weight: Weight
    
    static func < (lhs: _WeightedEdge<Node, Weight>, rhs: _WeightedEdge<Node, Weight>) -> Bool {
        lhs.weight < rhs.weight
    }
}

func dijkstra(graph: [Int: [_WeightedEdge<Int, Int>]], source: Int) -> [Int: Int] {
    var distances = [Int: Int]() // Dictionary to store the shortest distance to each node
    var priorityQueue = PriorityQueue<_WeightedEdge<Int, Int>> { $0.weight < $1.weight }
    
    // Initialize distances and priority queue
    for node in graph.keys {
        distances[node] = Int.max // Infinity
    }
    distances[source] = 0
    priorityQueue.enqueue(_WeightedEdge(node: source, weight: 0))
    
    while let weigtedEdge = priorityQueue.dequeue() {
        guard weigtedEdge.weight <= distances[weigtedEdge.node]! else { continue }
        
        if let neighbors = graph[weigtedEdge.node] {
            for neighbor in neighbors {
                let distance = weigtedEdge.weight + neighbor.weight
                if distance < distances[neighbor.node]! {
                    distances[neighbor.node] = distance
                    priorityQueue.enqueue(_WeightedEdge(node: neighbor.node, weight: distance))
                }
            }
        }
    }
    
    return distances
}

// Priority Queue implementation using a heap
struct PriorityQueue<Element: Comparable> {
    private var elements: [Element]
    private let areInIncreasingOrder: (Element, Element) -> Bool
    
    init(areInIncreasingOrder: @escaping (Element, Element) -> Bool) {
        self.elements = []
        self.areInIncreasingOrder = areInIncreasingOrder
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    // Helper functions
    private func leftChildIndex(of i: Int) -> Int {
        return 2 * i + 1
    }
    
    private func rightChildIndex(of i: Int) -> Int {
        return 2 * i + 2
    }
    
    private func parentIndex(of i: Int) -> Int {
        return (i - 1) / 2
    }
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
        shiftUp(index: elements.count - 1)
    }
    
    mutating func shiftUp(index: Int) {
        var i = index
        while i > 0, areInIncreasingOrder(elements[i], elements[parentIndex(of: i)]) {
            elements.swapAt(parentIndex(of: i), i)
            i = parentIndex(of: i)
        }
    }
    
    mutating func shiftDown(index: Int) {
        var i = index
        while true {
            let leftIndex = leftChildIndex(of: i)
            let rightIndex = rightChildIndex(of: i)
            var candidate = i

            if leftIndex < elements.count && areInIncreasingOrder(elements[leftIndex], elements[candidate]) {
                candidate = leftIndex
            }
            if rightIndex < elements.count && areInIncreasingOrder(elements[rightIndex], elements[candidate]) {
                candidate = rightIndex
            }
            if candidate == i {
                return
            }
            elements.swapAt(i, candidate)
            i = candidate
        }
    }
    
    mutating func increaseKey(at index: Int, to key: Element) {
        guard areInIncreasingOrder(key, elements[index]) else {
            fatalError("New key must be in correct order relative to the current key.")
        }
        elements[index] = key
        shiftUp(index: index)
    }
    
    mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let element = elements.removeLast()
        if !isEmpty {
            shiftDown(index: 0)
        }
        return element
    }
}
