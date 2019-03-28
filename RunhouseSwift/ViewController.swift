//
//  ViewController.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import UIKit


/// demoVC
class ViewController: UIViewController,UIRunHouseViewDatasourse{
    ///数据源
    let datas = ["gdshajkldlkfjhgjsakldlfksa","56152673891t74y1834y89","sdjhgajdga","ysadsdasa","sdhakshdsajkhdjashjdgahjdgasjgfhfgakfg","sadjbhjashdjashdfuhaskldaksdnklandasjlf"]
    
    /// 跑马灯页面
    var runhouseView : UIRunHouseView? = UIRunHouseView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        runhouseView?.dataSourse = self
        runhouseView?.backgroundColor = UIColor.green
        runhouseView?.registerClasse(classType: CustomRunHouseView.classForCoder(), reuseIdentifier: "CustomRunHouseView")
        runhouseView?.registerClasse(classType: ImageTitleView.classForCoder(), reuseIdentifier: "ImageTitleView")
        
        self.view .addSubview(runhouseView!)
        runhouseView!.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(100)
            make.height.equalTo(50)
        }
        
    }
    
    //MARK UIRunHouseViewDatasourse 跑马灯数据源
    ///跑马灯有多少个item
    func numberOfItemsInRunHouseView(view: UIRunHouseView) -> Int {
        return datas.count
    }
    
    /// 获取item
    ///
    /// - Parameters:
    ///   - runHouseView: 跑马灯视图
    ///   - index: 对应item的角标值
    /// - Returns:角标对应的视图
    func runHouseView(runHouseView: UIRunHouseView, itemForIndex index: Int) -> UIView {
        
        if index % 2 == 0 {
            var view = runHouseView.dequeneItemViewResueIdentity(resueIdentity: "CustomRunHouseView") as? CustomRunHouseView
            if view == nil {
                view = CustomRunHouseView()
            }
            view?.label.text = self.datas[index]
            return view!
        }else{
            var view = runHouseView.dequeneItemViewResueIdentity(resueIdentity: "ImageTitleView") as? ImageTitleView
            if view == nil {
                view = ImageTitleView()
            }
            view?.label.text = self.datas[index]
            return view!
        }
    }
    
    /// 获取item宽度
    ///
    /// - Parameters:
    ///   - runHouseView: 跑马灯视图
    ///   - index: 对应item的角标值
    /// - Returns: 返回对应item的宽度
    func runHouseView(runHouseView: UIRunHouseView, widthForIndex index: Int) -> CGFloat {
        let str = self.datas[index]
        let font = UIFont.systemFont(ofSize: 20)
        let rect = str.boundingRect(with:CGSize.init(width: CGFloat(MAXFLOAT), height: 50),options: NSStringDrawingOptions.usesLineFragmentOrigin,attributes: [NSAttributedString.Key.font:font],context:nil)
        if index % 2 == 0{
            return rect.size.width + 10
        }else{
            return rect.size.width + 50
        }
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.runhouseView?.removeFromSuperview()
//        self.runhouseView = nil
//    }
}

