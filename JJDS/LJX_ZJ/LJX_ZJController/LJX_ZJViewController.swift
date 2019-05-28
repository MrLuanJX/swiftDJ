//
//  LJX_ZJViewController.swift
//  JJDS
//
//  Created by a on 2019/5/17.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ZJViewController: UIViewController {

    var dataArray : Array<Any> = []
    
    var pageView : FSCPageView! = nil
    
    lazy var pageController: FSCPageView = {
        let titleArray = ["推荐","DOTA2","CSGO","LOL"]
        
        for (index,value) in titleArray.enumerated() {
            //index是下标，value是值
            var vc = LJX_ZJListViewController()
//            vc.jumpScore = {  (model)->() in
//
//            }
            
            vc.currentIndex = index
            
            self.dataArray.append(vc)
        }
        
        pageView = FSCPageView(frame: CGRect(x: 0, y:navHeight , width: view.frame.width, height: UIScreen.main.bounds.size.height - CGFloat(tabBarHeight) - navHeight), controllers: self.dataArray as! [LJX_ZJListViewController], titleArray: titleArray, selectIndex: 0, lineHeight: 2)
        
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let colors = [UIColor.hexadecimalColor(hexadecimal: "#191970").cgColor,
//                      UIColor.hexadecimalColor(hexadecimal: "#4682B4").cgColor,
//        ]
//        LJX_LayerRadius.gradientColor(view: view,colors)
//
        view.backgroundColor = UIColor.white
        self.view.addSubview(pageController)
        
        pageView.pageBlock = {(selectIndex : Int) -> () in
            print("点击了第 + \(selectIndex) + 个")
            let vc = self.dataArray[selectIndex]
            
            (vc as! LJX_ZJListViewController).currentIndex = selectIndex
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
//    }

    
   

}
