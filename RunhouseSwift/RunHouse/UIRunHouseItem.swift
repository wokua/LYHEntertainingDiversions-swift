//
//  UIRunHouseItem.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import UIKit


/// 重用刷新协议，需要在重用时刷新的，只需要自己的item实现这个协议即可
protocol UIRunHouseItemProtocol {
    func prepareForReuse()
}
