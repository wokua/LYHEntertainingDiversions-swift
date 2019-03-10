//
//  Node.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import Foundation

class Node<T> {
    
    private var next : Node<T>?
    private var data : T?
    
    init(){
        
    }
    
    init(_ data:T? = nil) {
        self.data = data
    }
    
    func setData(_ data:T){
        self.data = data
    }
    
    func  getData() -> T?{
        return data
    }
    
    func setNext(_ next:Node<T>?){
        self.next = next
    }
    
    func getNext() -> Node<T>?{
        return next
    }
}

