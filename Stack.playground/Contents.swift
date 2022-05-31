import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []
    public init() { }
    
}
extension Stack: CustomStringConvertible {
    public var description: String {
    """
  ----top----\n\(storage.map { "\($0)" }.reversed().joined(separator:
                                                    "\n"))
  -----------
  """ }
}
extension Stack {
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    public func peek() -> Element? {
     storage.last
    }
    public var isEmpty: Bool {
      peek() == nil
    }
}
extension Stack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    storage = elements
  }
}

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
print(stack)
if let poppedElement = stack.pop() {
    assert(4 == poppedElement)
    print("Popped: \(poppedElement)")
  }
