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
    /*
    lazy var pageController: FSCPageView = {
        
        let titleArray = ["DOTA2","LOL","CSGO","王者荣耀"]
        
        for (index,value) in titleArray.enumerated() {
            //index是下标，value是值
            var vc = LJX_HomeViewController()
            vc.jumpScore = {  (model)->() in
                let detailVC = LJX_HomeDetailViewController.init()
                
                detailVC.detailModel = model
                
                detailVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            
            vc.currentIndex = index
            
            self.dataArray.append(vc)
        }
        
        pageView = FSCPageView(frame: CGRect(x: 0, y:stateheight , width: view.frame.width, height: UIScreen.main.bounds.height - CGFloat(tabBarHeight) - stateheight), controllers: self.dataArray as! [LJX_HomeViewController], titleArray: titleArray, selectIndex: 0, lineHeight: 2)
        
        return pageView
    }()
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let titleArray = ["DOTA2","LOL","CSGO","王者荣耀"]
        for (index,_) in titleArray.enumerated() {
            //index是下标，value是值
            let vc = LJX_HomeViewController()
            vc.jumpScore = {  (model)->() in
                let detailVC = LJX_HomeDetailViewController.init()
                detailVC.detailModel = model
                detailVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            vc.currentIndex = index
            self.dataArray.append(vc)
        }
        
        pageView = FSCPageView(frame: CGRect(x: 0, y:stateheight , width: view.frame.width, height: UIScreen.main.bounds.height - CGFloat(tabBarHeight) - stateheight), controllers: self.dataArray as! [LJX_HomeViewController], titleArray: titleArray, selectIndex: 0, lineHeight: 2)
        
        self.view.addSubview(pageView)
        
        pageView.pageBlock = {(selectIndex : Int) -> () in
            print("点击了第 + \(selectIndex) + 个")
            let vc = self.dataArray[selectIndex]
            (vc as! LJX_HomeViewController).currentIndex = selectIndex
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetTitles), name: NSNotification.Name(rawValue:"resetTitles"), object: nil)
    }
    
    // 排序回调
    @objc func resetTitles(notif: NSNotification)  {
        let resetArray = (notif.userInfo!["resetArray"])!
        self.pageView.removeFromSuperview()
        self.pageView = FSCPageView(frame: CGRect(x: 0, y:stateheight , width: view.frame.width, height: UIScreen.main.bounds.height - CGFloat(tabBarHeight) - stateheight), controllers: self.dataArray as! [LJX_HomeViewController], titleArray: resetArray as! [String], selectIndex: 0, lineHeight: 2)
        
        NotificationCenter.default.post(name: NSNotification.Name("reloadTableView"), object: nil, userInfo: ["resetArray":resetArray])

        self.view.addSubview(pageView)
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
