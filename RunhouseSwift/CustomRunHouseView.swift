//
//  CustomRunHouseView.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import UIKit

class CustomRunHouseView: UIView,UIRunHouseItemProtocol {

    let label = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI(){
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 20)
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func prepareForReuse() {
        label.text = nil
    }
}
