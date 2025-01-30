import Foundation

public class BinarySearchTree<T: Comparable> {
  private(set) public var value: T
  private(set) public var parent: BinarySearchTree?
  private(set) public var left: BinarySearchTree?
  private(set) public var right: BinarySearchTree?

  public init(value: T) {
    self.value = value
  }

  public var isRoot: Bool {
    return parent == nil
  }

  public var isLeaf: Bool {
    return left == nil && right == nil
  }

  public var isLeftChild: Bool {
    return parent?.left === self
  }

  public var isRightChild: Bool {
    return parent?.right === self
  }

  public var hasLeftChild: Bool {
    return left != nil
  }

  public var hasRightChild: Bool {
    return right != nil
  }

  public var hasAnyChild: Bool {
    return hasLeftChild || hasRightChild
  }

  public var hasBothChildren: Bool {
    return hasLeftChild && hasRightChild
  }

  public var count: Int {
    return (left?.count ?? 0) + 1 + (right?.count ?? 0)
  }
}

//convinience initializer
extension BinarySearchTree {
    
    public convenience init(array: [T]) {
      precondition(array.count > 0)
      self.init(value: array.first!)
      for v in array.dropFirst() {
        insert(value: v)
      }
    }
}

//Insert, Search
extension BinarySearchTree {
    public func insert(value: T) {
      if value < self.value {
        if let left = left {
          left.insert(value: value)
        } else {
          left = BinarySearchTree(value: value)
          left?.parent = self
        }
      } else {
        if let right = right {
          right.insert(value: value)
        } else {
          right = BinarySearchTree(value: value)
          right?.parent = self
        }
      }
    }
    
    public func search(value: T) -> BinarySearchTree? {
      if value < self.value {
        return left?.search(value)
      } else if value > self.value {
        return right?.search(value)
      } else {
        return self  // found it!
      }
    }
    
    public func searchIterative(_ value: T) -> BinarySearchTree? {
      var node: BinarySearchTree? = self
      while let n = node {
        if value < n.value {
          node = n.left
        } else if value > n.value {
          node = n.right
        } else {
          return node
        }
      }
      return nil
    }
}

extension BinarySearchTree {
    public func minimum() -> BinarySearchTree {
      var node = self
      while let next = node.left {
        node = next
      }
      return node
    }

    public func maximum() -> BinarySearchTree {
      var node = self
      while let next = node.right {
        node = next
      }
      return node
    }
    
    private func deleteNode(_ root: BSTNode<T>?, _ value: T) -> BSTNode<T>? {
        guard let root = root else { return nil }

        if value < root.value {
            // Value to be deleted is in the left subtree
            root.leftChild = deleteNode(root.leftChild, value)
        } else if value > root.value {
            // Value to be deleted is in the right subtree
            root.rightChild = deleteNode(root.rightChild, value)
        } else {
            // Node to be deleted found
            if root.leftChild == nil {
                // Node with only right child or no child
                return root.rightChild
            } else if root.rightChild == nil {
                // Node with only left child
                return root.leftChild
            }

            // Node with two children: Get the inorder successor (smallest in the right subtree)
            root.value = minValue(root.rightChild!)

            // Delete the inorder successor
            root.rightChild = deleteNode(root.rightChild, root.value)
        }
        return root
    }

    private func minValue(_ node: BSTNode<T>) -> T {
        var current = node
        while let next = current.leftChild {
            current = next
        }
        return current.value
    }

    public func isBST(minValue: T, maxValue: T) -> Bool {
      if value < minValue || value > maxValue { return false }
      let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
      let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
      return leftBST && rightBST
    }
}

let tree = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])
