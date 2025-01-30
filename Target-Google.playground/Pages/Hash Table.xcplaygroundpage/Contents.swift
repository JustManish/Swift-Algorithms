import Foundation

struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]

    private var buckets: [Bucket]
    private(set) var count: Int = 0

    init(size: Int) {
        assert(size > 0)
        buckets = Array(repeating: [], count: size)
    }

    private func index(for key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }

    mutating func insert(_ value: Value, forKey key: Key) {
        let index = self.index(for: key)
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index][i].value = value
                return
            }
        }
        buckets[index].append((key: key, value: value))
        count += 1
    }

    mutating func removeValue(forKey key: Key) -> Value? {
        let index = self.index(for: key)
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                count -= 1
                return element.value
            }
        }
        return nil
    }

    func value(forKey key: Key) -> Value? {
        let index = self.index(for: key)
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil
    }
}

// Usage example:
var hashTable = HashTable<String, Int>(size: 10)
hashTable.insert(42, forKey: "answer")
print(hashTable.value(forKey: "answer")!) // Output: 42
hashTable.removeValue(forKey: "answer")
print(hashTable.value(forKey: "answer")) // Output: nil

let originalString = "Hello, World! 123 #Swift"

let allowedCharacters = CharacterSet.alphanumerics // This includes letters and numbers
let filteredString = originalString.filter { character in
    return character.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
}

print(filteredString) // Output: "HelloWorld123Swift"

