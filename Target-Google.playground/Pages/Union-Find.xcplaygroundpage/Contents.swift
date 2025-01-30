//: [Previous](@previous)

import Foundation

class UnionFind {
    private var parent: [Int]
    private var rank: [Int]
    private var count: Int // Number of connected components

    init(size: Int) {
        parent = Array(0..<size)
        rank = Array(repeating: 1, count: size)
        count = size
    }

    func find(_ p: Int) -> Int {
        var p = p
        while p != parent[p] {
            parent[p] = parent[parent[p]] // Path Compression
            p = parent[p]
        }
        return p
    }
    
    func _find(_ p: Int) -> Int {
        if parent[p] != p {
            parent[p] = _find(parent[p]) // Path compression
        }
        return parent[p]
    }


    func union(_ p: Int, _ q: Int) {
        let rootP = find(p)
        let rootQ = find(q)
        
        if rootP == rootQ {
            return
        }

        // Union by Rank
        if rank[rootP] < rank[rootQ] {
            parent[rootP] = rootQ
        } else if rank[rootP] > rank[rootQ] {
            parent[rootQ] = rootP
        } else {
            parent[rootQ] = rootP
            rank[rootP] += 1
        }

        count -= 1 // Decrease the number of components as two sets are merged
    }

    func connected(_ p: Int, _ q: Int) -> Bool {
        return find(p) == find(q)
    }

    func numberOfConnectedComponents() -> Int {
        return count
    }
}

// Example Usage
let n = 5 // Number of nodes
let edges = [(0, 1), (1, 2), (3, 4)] // Edges in the graph

let uf = UnionFind(size: n)

for (u, v) in edges {
    uf.union(u, v)
}

let numberOfComponents = uf.numberOfConnectedComponents()
print("Number of connected components: \(numberOfComponents)")


class _UnionFind<T: Hashable> {
    private var parent: [Int]
    private var rank: [Int]
    private var count: Int
    private var map: [T: Int]
    private var reverseMap: [Int: T]
    private var index: Int

    init(elements: [T]) {
        self.count = elements.count
        self.parent = Array(repeating: 0, count: count)
        self.rank = Array(repeating: 1, count: count)
        self.map = [T: Int]()
        self.reverseMap = [Int: T]()
        self.index = 0
        
        for element in elements {
            map[element] = index
            reverseMap[index] = element
            parent[index] = index
            index += 1
        }
    }

    func find(_ element: T) -> Int? {
        guard var idx = map[element] else { return nil }
        while idx != parent[idx] {
            parent[idx] = parent[parent[idx]]
            idx = parent[idx]
        }
        return idx
    }

    func union(_ element1: T, _ element2: T) {
        guard let root1 = find(element1), let root2 = find(element2) else { return }

        if root1 == root2 {
            return
        }

        if rank[root1] < rank[root2] {
            parent[root1] = root2
        } else if rank[root1] > rank[root2] {
            parent[root2] = root1
        } else {
            parent[root2] = root1
            rank[root1] += 1
        }

        count -= 1
    }

    func connected(_ element1: T, _ element2: T) -> Bool {
        return find(element1) == find(element2)
    }

    func numberOfConnectedComponents() -> Int {
        return count
    }
}

// Example Usage
let names = ["Alice", "Bob", "Charlie", "David", "Eve"]
let _uf = _UnionFind(elements: names)

_uf.union("Alice", "Bob")
_uf.union("Charlie", "David")

let _numberOfComponents = _uf.numberOfConnectedComponents()
print("Number of connected components: \(_numberOfComponents)") // Output: 3

let _isConnected = _uf.connected("Alice", "Charlie")
print("Are Alice and Charlie connected? \(_isConnected)") // Output: false
