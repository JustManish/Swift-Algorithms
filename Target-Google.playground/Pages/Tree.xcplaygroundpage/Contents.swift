import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

func preorderTraversal(_ root: TreeNode?) -> [Int] {
    var result = [Int]()
    func dfs(_ node: TreeNode?) {
        guard let node = node else { return }
        result.append(node.val)  // Visit the root
        dfs(node.left)           // Visit the left subtree
        dfs(node.right)          // Visit the right subtree
    }
    dfs(root)
    return result
}

func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var result = [Int]()
    func dfs(_ node: TreeNode?) {
        guard let node = node else { return }
        dfs(node.left)           // Visit the left subtree
        result.append(node.val) // Visit the root
        dfs(node.right)          // Visit the right subtree
    }
    dfs(root)
    return result
}

func postorderTraversal(_ root: TreeNode?) -> [Int] {
    var result = [Int]()
    func dfs(_ node: TreeNode?) {
        guard let node = node else { return }
        dfs(node.left)           // Visit the left subtree
        dfs(node.right)          // Visit the right subtree
        result.append(node.val) // Visit the root
    }
    dfs(root)
    return result
}

func preorderTraversalIterative(_ root: TreeNode?) -> [Int] {
    var result = [Int]()
    var stack = [TreeNode]()
    if let root = root {
        stack.append(root)
    }
    
    while !stack.isEmpty {
        let node = stack.removeLast()
        result.append(node.val)
        if let right = node.right {
            stack.append(right)
        }
        if let left = node.left {
            stack.append(left)
        }
    }
    
    return result
}

func bfsTraversal(_ root: TreeNode?) -> [Int] {
    guard let root = root else { return [] }
    
    var result = [Int]()
    var queue = [TreeNode]()
    
    queue.append(root)
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        result.append(node.val)
        
        if let left = node.left {
            queue.append(left)
        }
        
        if let right = node.right {
            queue.append(right)
        }
    }
    
    return result
}

func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    guard let root = root else { return false }
    return _targetSum(root, targetSum)
}

private func _targetSum(_ node: TreeNode?, _ target: Int) -> Bool {
    guard let node = node else { return false }
    
    // Check if the current node is a leaf node
    if node.left == nil && node.right == nil {
        return target == node.val
    }
    
    // Recursively check the left and right subtrees
    return _targetSum(node.left, target - node.val) || _targetSum(node.right, target - node.val)
}

func sumNumbers(_ root: TreeNode?) -> Int {
    return sumNumbersHelper(root, 0)
}

//TODO: Sum of path --
private func sumNumbersHelper(_ node: TreeNode?, _ currentSum: Int) -> Int {
    guard let node = node else { return 0 }
    
    let newSum = currentSum * 10 + node.val
    
    if node.left == nil && node.right == nil {
        // This is a leaf node
        return newSum
    }
    
    // Continue to sum the values of the left and right subtrees
    return sumNumbersHelper(node.left, newSum) + sumNumbersHelper(node.right, newSum)
}
