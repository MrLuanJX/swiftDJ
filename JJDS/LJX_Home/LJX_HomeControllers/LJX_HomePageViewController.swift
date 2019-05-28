//
//  LJX_HomePageViewController.swift
//  JJDS
//
//  Created by a on 2019/5/13.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_HomePageViewController: UIViewController {
    
    var dataArray : Array<Any> = []
    
    var pageView : FSCPageView! = nil
    
    lazy var pageController: FSCPageView = {
        let titleArray = ["DOTA2","CSGO","LOL","王者荣耀"]
        
        for (index,value) in titleArray.enumerated() {
            //index是下标，value是值
            var vc = LJX_HomeViewController()
            vc.jumpScore = {  (model)->() in
                let detailVC = LJX_HomeDetailViewController.init()
                
                detailVC.detailModel = model
                
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            
            vc.currentIndex = index
            
            self.dataArray.append(vc)
        }
        
        pageView = FSCPageView(frame: CGRect(x: 0, y:navHeight , width: view.frame.width, height: UIScreen.main.bounds.height - navHeight - CGFloat(tabBarHeight)), controllers: self.dataArray as! [LJX_HomeViewController], titleArray: titleArray, selectIndex: 0, lineHeight: 2)
        
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pageController)
        
        pageView.pageBlock = {(selectIndex : Int) -> () in
            print("点击了第 + \(selectIndex) + 个")
            let vc = self.dataArray[selectIndex]
            
            (vc as! LJX_HomeViewController).currentIndex = selectIndex
        }
        
    
        
        
    }

    
    

}
