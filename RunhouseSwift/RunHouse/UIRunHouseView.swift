//
//  UIRunHouseView.swift
//  RunhouseSwift
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import UIKit

protocol UIRunHouseViewDatasourse {
    func numberOfItemsInRunHouseView(view:UIRunHouseView) -> Int;
    func runHouseView(runHouseView:UIRunHouseView,widthForIndex index:Int) -> CGFloat;
    func runHouseView(runHouseView:UIRunHouseView,itemForIndex index:Int) -> UIView;
}

protocol UIRunHouseViewDelegate {
    
}

class UIRunHouseView: UIView {
 
    var dataSourse : UIRunHouseViewDatasourse?
    var space : CGFloat  = 30 //item间距 默认30
    private var offset : CGFloat = 100 //
    private var currentIndex = 0 //当前最后一个角标
    private var oldFrame : CGRect? //上一次的frame
    
    private  var visibleViewArr : [UIView] = [UIView](); //可视view数组
    private var reuseViewCache : [String:Quene<UIView>] = [String:Quene<UIView>]() //重用view缓存
    private var idCache : [String:String] = [String:String]() //重用id和class对应关系缓存
    private var timer : CADisplayLink?  //定时器
    private var itemCount : Int = 0 //条目个数
    private var widthCache : [Int:CGFloat] = [Int:CGFloat]()  //宽度缓存
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initTimer()
    }
    
    init() {
        super.init(frame:CGRect.zero)
         self.initTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    清空缓存
    func clearCache(){
        self.reuseViewCache.removeAll()
        self.idCache.removeAll()
        self.widthCache.removeAll()
    }
    
    //初始化定时器
    private func initTimer(){
        self.clipsToBounds = true
//        self.timer = CADisplayLink.init(target: WeakProxy.init(target: self), selector: #selector(run))
        self.timer = CADisplayLink.init(target:self, selector: #selector(run))
        self.timer?.add(to: RunLoop.main, forMode: RunLoop.Mode.tracking)
        self.timer?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    //定时器事件
    @objc func run(){
        self.visibleViewArr.forEach { (view) in
            view.transform = view.transform.translatedBy(x: -1, y: 0)
        }
       self.updateView()
    }
    //更新view
    private func updateView(){
        
        let frameWidth = self.frame.size.width
        guard let firstShowView = self.visibleViewArr.first,
              let lastShowView = self.visibleViewArr.last else {
            return
        }
        if firstShowView.frame.origin.x + firstShowView.frame.size.width < 0{
            self.visibleViewArr.remove(at: 0)
            self.saveViewToCache(firstShowView)
        }
        let lastViewRight = lastShowView.frame.size.width + lastShowView.frame.origin.x
        if lastViewRight <= frameWidth + offset {
            if currentIndex < itemCount - 1{
                currentIndex += 1
            }else{
                currentIndex = 0
            }
            _ = self.addItem(originx: lastViewRight+self.space)
        }
        
    }
    
   // 刷新布局
    func reloadData(){
        let frame = self.frame;
        self.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        self.clearCache()
        let frameWidth = frame.size.width
        var currentWidth : CGFloat = 0
        
        guard let dataSourse = self.dataSourse else{
            print("UIRunHouseViewError:Datasourse Nil");
            return;
        }
        
        while currentWidth < frameWidth + self.offset{
            self.itemCount = dataSourse.numberOfItemsInRunHouseView(view: self)
            let itemWidth = self.addItem(originx: currentWidth)
            self.currentIndex += 1
            if self.currentIndex == self.itemCount{
                self.currentIndex = 0
            }
            currentWidth += itemWidth + self.space
        }
        
    }
    //添加条目 返回新增item的宽度
    private func addItem(originx : CGFloat) -> CGFloat {
        
        let frame = self.frame
        let frameHeight = frame.size.height
        var itemWidth = self.widthCache[currentIndex]
        
        guard let dataSourse = self.dataSourse else {
            print("UIRunHouseViewError:Datasourse Nil");
            return 0;
        }
        
        if itemWidth == nil || itemWidth == 0{
            itemWidth = dataSourse.runHouseView(runHouseView: self,widthForIndex: self.currentIndex)
            self.widthCache[currentIndex] = itemWidth ?? 0
        }
        
        let item = dataSourse.runHouseView(runHouseView: self,itemForIndex: currentIndex)
        item.frame = CGRect.init(x: originx, y: 0, width: itemWidth ?? 0, height: frameHeight)
        self.addSubview(item)
        self.visibleViewArr.append(item)
        return itemWidth ?? 0
    }
    
    //刷新布局
    override func layoutSubviews() {
        let frame = self.frame
    
        if oldFrame?.origin.x == frame.origin.x && frame.origin.y == oldFrame?.origin.y && frame.size.width == oldFrame?.size.width && frame.size.height == oldFrame?.size.height{
            return
        }
        oldFrame = frame
        self.reloadData()
    }
    
    // 注册View
    func registerClasse(classType:AnyClass,reuseIdentifier:String){
        self.idCache[NSStringFromClass(classType)] = reuseIdentifier
    }

//  获取重用view
    func dequeneItemViewResueIdentity(resueIdentity : String) -> UIView?{
        let view = self.getViewFromCache(resueIdentity)
        if let pro = view as? UIRunHouseItemProtocol{
            pro.prepareForReuse()
        }
        return view
    }
    
//重用View加入缓存
    private func saveViewToCache(_ view:UIView){
            guard let reuseIdentity = idCache[NSStringFromClass(view.classForCoder)] else{
                print("RunHOuseViewSaveError:\(view.classForCoder) reuseIdentity NO Register")
                return
            }
            guard let viewQuene = reuseViewCache[reuseIdentity] else {
                self.reuseViewCache[reuseIdentity] = Quene.init(view)
                return
            }
            viewQuene.enquene(view)
    }
//从缓存中读取重用view
    private func getViewFromCache(_ reuseIdentity : String) -> UIView?{
        let quene = self.reuseViewCache[reuseIdentity]
        return quene?.dequene()
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }

}
