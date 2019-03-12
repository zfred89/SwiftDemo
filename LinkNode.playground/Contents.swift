import UIKit

//定义一个链表
public class Node {
    //节点的值
    var value : String
    //指向下一节点
    var next: Node?
    //指向前一节点，为了避免重复引用，所以weak
    weak var previous: Node?
    
    init(value: String) {
        self.value = value
    }
}

//新建一个链表类
public class LinkedList {
    //定义链表的首尾
    fileprivate var head: Node?
    private var tail: Node?
    
    //判断这个链表是否为空(如果链表的头都是null，则该链表为空)
    public var isEmpty: Bool {
        return head == nil
    }
    
    //在链表的尾部添加节点
    //如果head有值，则添加在尾部。如果为null则说明是个空t链表，直接赋值给head
    public func append(value:String) {
        let newNode = Node(value: value)
        
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        }else{
            head = newNode
        }
        tail = newNode
    }
    //去除链表中index位置的节点
    public func node(atIndex index: Int) -> Node? {
        if index>=0 {
            var node = head
            var i = index
            
            while node != nil {
                if i==0 {return node}
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    //移出链表中所有的节点
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    //给链表中所有字符串倒序展示，并返回一个字符串
    public func reverseSort()-> String {
        var text = ""
        var node = head
        while node != nil {
            text = (node?.value)! + text
            node = node?.next
        }
        return text
    }
    
    //移出某一节点
    public func remove(node: Node)-> String {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        }else{
            head = next
        }
        next?.previous = prev
        if next == nil {
            tail = prev
        }
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}


//
let snakes = LinkedList()
snakes.append(value: "1")
snakes.append(value: "2")
snakes.append(value: "3")
snakes.append(value: "4")
print(snakes.reverseSort())

