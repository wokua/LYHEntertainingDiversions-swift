//
//  Quene.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import Foundation


/// 基础队列数据类型
class Quene<T> {
    
    private var firstNode : Node<T>?
    private var lastNode : Node<T>?
    
    
    /// 初始化
    ///
    /// - Parameter data:队列存储的当前节点数据
    init(_ data : T? = nil) {
        let node = Node.init(data)
        self.firstNode = node
        self.lastNode = node
    }
    
    /// 入队
    ///
    /// - Parameter data: 需要进入队列的数据
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
    
    /// 出队
    ///
    /// - Returns: 返回队列中最先入队的数据
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
    
    /// 当前队列是否为空
    ///
    /// - Returns: 布尔值，判断结果
    func isEmpty() -> Bool{
        return self.firstNode == nil
    }
    
    /// 队列元素个数
    ///
    /// - Returns: 元素的个数
    func count() -> Int {
        var nextNode = self.firstNode
        var count = 0
        while nextNode != nil {
            count += 1
            nextNode = nextNode?.getNext()
        }
        return count
    }
    
    /// 返回队列最顶的元素
    ///
    /// - Returns: 队列最顶的数据
    func top() -> T? {
        return self.firstNode?.getData()
    }
    
    /// 清空队列
    func clear(){
        self.firstNode = nil
        self.lastNode = nil
    }
    
}
