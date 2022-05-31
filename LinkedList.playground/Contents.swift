import Foundation

public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    public init() {}
    public var isEmpty: Bool {
        head == nil }
    
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        if tail == nil {
            tail = head
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value,
                                after node: Node<Value>) -> Node<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    @discardableResult
    public mutating func removeLast() -> Value? {
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        return current.value
    }
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node }
            node.next = node.next?.next
        }
        return node.next?.value
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

// MARK: -Testing the nodes

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)
node1.next = node2
node2.next = node3
print(node1)

// MARK: -Testing the linked list operations

var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)

print("Before inserting: \(list)")
let middleNode = list.node(at: 1)!
list.insert(-1, after: middleNode)
print("After inserting: \(list)")

print("Before popping list: \(list)")
let poppedValue = list.pop()
print("After popping list: \(list)")
print("Popped value: " + String(describing: poppedValue))

print("Before removing last node: \(list)")
let lastRemovedValue = list.removeLast()
print("After removing last node: \(list)")
print("Removed value: " + String(describing: lastRemovedValue))

print("Before removing at particular index: \(list)")
let index = 1
let node = list.node(at: index - 1)!
let removedValue = list.remove(after: node)
print("After removing at index \(index): \(list)")
print("Removed value: " + String(describing: removedValue))
