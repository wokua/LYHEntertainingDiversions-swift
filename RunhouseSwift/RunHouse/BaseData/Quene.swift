//
//  Quene.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import Foundation

class Quene<T> {
    
    private var firstNode : Node<T>?
    private var lastNode : Node<T>?
    
    init(_ data : T? = nil) {
        self.firstNode = Node.init(data)
        self.lastNode = Node.init(data)
    }
    
    func enquene(_ data:T){
        let newNode = Node.init(data)
        if self.firstNode == nil {
            self.firstNode = newNode
            self.lastNode = newNode
        } else {
            self.lastNode?.setNext(newNode)
            self.lastNode = newNode
        }
    }
    
    func dequene() -> T? {
        guard let node = self.firstNode else{
            return nil
        }
        if node.getNext() == nil {
            self.lastNode = nil
        }
        self.firstNode = node.getNext()
        return node.getData()
    }
    
    func isEmpty() -> Bool {
        return self.firstNode == nil
    }
    
    func count() -> Int {
        var nextNode = self.firstNode
        var count = 0
        while nextNode != nil {
            count += 1
            nextNode = nextNode?.getNext()
        }
        return count
    }
    
    func top() -> T? {
        return self.firstNode?.getData()
    }
    
    func clear(){
        self.firstNode = nil
        self.lastNode = nil
    }
    
}
