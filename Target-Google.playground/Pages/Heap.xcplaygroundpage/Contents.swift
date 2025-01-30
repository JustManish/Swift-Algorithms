import Foundation

struct Heap<Element: Equatable> {
    var elements: [Element] = []
    let priorityFunction: (Element, Element) -> Bool

    init(sort: @escaping (Element, Element) -> Bool) {
        self.priorityFunction = sort
    }

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    func peek() -> Element? {
        return elements.first
    }

    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }

    mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }

        elements.swapAt(0, elements.count - 1)
        let removedElement = elements.removeLast()
        siftDown(from: 0)
        return removedElement
    }

    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }

        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            let removedElement = elements.removeLast()
            siftDown(from: index)
            siftUp(from: index)
            return removedElement
        }
    }

    func index(of element: Element) -> Int? {
        return elements.firstIndex(of: element)
    }

    mutating func siftUp(from index: Int) {
        var childIndex = index
        let child = elements[childIndex]
        var parentIndex = self.parentIndex(of: childIndex)

        while childIndex > 0 && priorityFunction(child, elements[parentIndex]) {
            elements[childIndex] = elements[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(of: childIndex)
        }

        elements[childIndex] = child
    }

    mutating func siftDown(from index: Int) {
        var parentIndex = index
        let count = elements.count

        while true {
            let leftChildIndex = self.leftChildIndex(of: parentIndex)
            let rightChildIndex = self.rightChildIndex(of: parentIndex)
            var candidateIndex = parentIndex

            if leftChildIndex < count && priorityFunction(elements[leftChildIndex], elements[candidateIndex]) {
                candidateIndex = leftChildIndex
            }

            if rightChildIndex < count && priorityFunction(elements[rightChildIndex], elements[candidateIndex]) {
                candidateIndex = rightChildIndex
            }

            if candidateIndex == parentIndex {
                return
            }

            elements.swapAt(parentIndex, candidateIndex)
            parentIndex = candidateIndex
        }
    }

    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }

    func leftChildIndex(of index: Int) -> Int {
        return (2 * index) + 1
    }

    func rightChildIndex(of index: Int) -> Int {
        return (2 * index) + 2
    }
}

extension Heap {
    mutating func heapify(_ array: [Element]) {
        elements = array
        for index in stride(from: (elements.count / 2) - 1, through: 0, by: -1) {
            siftDown(from: index)
        }
    }
}

extension Heap {
    mutating func heapSort() -> [Element] {
        var sortedArray: [Element] = []
        while !isEmpty {
            if let maxElement = remove() {
                sortedArray.append(maxElement)
            }
        }
        return sortedArray
    }
}

var maxHeap = Heap<Int>(sort: >)

maxHeap.heapify([25, 14, 16, 13, 10, 8, 12])

print("Heap: \(maxHeap.elements)", terminator: " ")

let sorted = maxHeap.heapSort()

print("Sorted: \(sorted)", terminator: " ")

func findKthLargestNum(_ nums: [Int], k: Int) -> Int {
    var minHeap = Heap<Int>(sort: <)
    
    for n in nums {
        minHeap.insert(n)
        if minHeap.count > k {
            minHeap.remove()
        }
    }
    return minHeap.peek() ?? .zero
}

let kthLargest = findKthLargestNum([25, 14, 16, 13, 10, 8, 12], k: 1)
print("Kth largest: ",kthLargest)
