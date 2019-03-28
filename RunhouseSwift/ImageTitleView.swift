//
//  ImageTitleView.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import UIKit
/// 一种跑马灯item视图
class ImageTitleView: UIView,UIRunHouseItemProtocol {

    let imageView = UIImageView.init(image: UIImage.init(named: "Image"))
    let label = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI(){
        
        self.addSubview(imageView)
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 20)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.width.equalTo(self.imageView.snp.height);
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(5);
            make.centerY.equalTo(self);
        }
        
    }
    func prepareForReuse() {
        label.text = nil
        imageView.image = nil
    }

}
