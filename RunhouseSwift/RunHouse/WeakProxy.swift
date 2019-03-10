//
//  WeakProxy.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//
import Foundation

class WeakProxy: NSObject {
    weak var target: NSObjectProtocol?
    
    init(target: NSObjectProtocol) {
        self.target = target
        super.init()
    }
    
    override func responds(to aSelector: Selector!) -> Bool {
        return (target?.responds(to: aSelector) ?? false) || super.responds(to: aSelector)
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return target
    }
}
