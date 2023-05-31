// Linked list of points implementation

import Foundation

// Node class for linked list
public class Node{
    var position: CGPoint
    var next: Node?
    
    init(position: CGPoint) {
        self.position = position
        self.next = nil
    }
}

public class linkedList : ObservableObject{
    var head:Node?
    
    // Create linked list
    init(pos:CGPoint) {
        self.head = Node(position: pos)
        self.head?.next = nil
    }
    
    // Returns the number of nodes in the list
    func count() -> Int {
        var current = head
        var counter: Int = 0
        while current != nil {
            counter = counter + 1
            current = current?.next
        }
        return counter
    }
    
    // Adds a new node to the end of the list
    func addToList(pos: CGPoint) {
        var current = head
        let newNode:Node = Node(position: pos)
        while (current?.next != nil) {
            current = current?.next
        }
        current?.next = newNode
    }
    
    // Finds the position of a node at a certain index
    func positionAt(index: Int) -> CGPoint{
        var current = head
        var i = index
        if index == 0 {
            return current!.position
        }
        else {
            while (i > 0) {
                i = i - 1
                current = current?.next
            }
            return current!.position
        }
    }
    
    // Removes everything after the head node
    func remove() {
        head?.next = nil
    }
    
    // Prints the list
    func printList() {
        print("new list ")
        var current = head
        while (current != nil) {
            print(current!.position)
            current = current?.next
        }
    }
}
