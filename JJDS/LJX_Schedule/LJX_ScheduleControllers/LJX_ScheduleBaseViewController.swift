//
//  LJX_ScheduleBaseViewController.swift
//  JJDS
//
//  Created by a on 2019/5/14.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ScheduleBaseViewController: UIViewController {

    var dataArray : Array<Any> = []
    
    var pageView : FSCPageView! = nil
    
    lazy var pageController: FSCPageView = {
        let titleArray = ["DOTA2","CSGO","LOL","王者荣耀"]
        
        for (index,value) in titleArray.enumerated() {
            //index是下标，value是值
            var zxVC = LJX_ZXViewController()
             zxVC.jumpScore = {  (model)->() in
                let detailVC = LJX_ScheduleDetailViewController.init()
                
                print("-----------")
                
                detailVC.detailModel = model
                
                detailVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            
            zxVC.currentIndex = index
            
            self.dataArray.append(zxVC)
        }
        
        pageView = FSCPageView(frame: CGRect(x: 0, y:stateheight , width: view.frame.width, height: UIScreen.main.bounds.height - stateheight - CGFloat(tabBarHeight)), controllers: self.dataArray as! [LJX_ZXViewController], titleArray: titleArray, selectIndex: 0, lineHeight: 2)
        
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(pageController)
        
        pageView.pageBlock = {(selectIndex : Int) -> () in
            print("点击了第 + \(selectIndex) + 个")
            let vc = self.dataArray[selectIndex]
            
            (vc as! LJX_ZXViewController).currentIndex = selectIndex
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.navigationBar.isHidden = false
    }
}
