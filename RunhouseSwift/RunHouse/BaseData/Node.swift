//
//  Node.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import Foundation


/// 基础链表节点数据
class Node<T> {
    
    private var next : Node<T>?
    private var data : T?
    
    init(){
        
    }
    
    
    /// 带数据初始化
    ///
    /// - Parameter data: 节点存储的数据
    init(_ data:T? = nil) {
        self.data = data
    }
    
    /// 设置当前节点数据
    ///
    /// - Parameter data: 当前节点数据
    func setData(_ data:T){
        self.data = data
    }
    
    /// 获取当前节点数据
    ///
    /// - Returns: 返回当前节点的数据
    func  getData() -> T?{
        return data
    }
    
    /// 设置下一个节点
    ///
    /// - Parameter next: 下一个节点对象
    func setNext(_ next:Node<T>?){
        self.next = next
    }
    
    /// 获取下一个节点
    ///
    /// - Returns: 下一个节点对象
    func getNext() -> Node<T>?{
        return next
    }
}

