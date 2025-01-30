import Foundation

extension Array {
    
    func myMap<U>(_ transform: (Element) -> U) -> [U] {
        var transformed: [U] = []
        self.forEach { e in
            transformed.append(transform(e))
        }
        return transformed
    }
}

let t = [11, 22, 33].myMap { e in
    "\(e)"
}

print(t)
