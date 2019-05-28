//
//  LJX_TabBarViewController.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_TabBarViewController: UITabBarController {

    var signal = 0
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 12.1, *) {
            UITabBar.appearance().isTranslucent = false
        } else {
            UITabBar.appearance().isTranslucent = true
        }
        
        /*
        if signal == 0 {
            signal = 1
            if #available(iOS 11.0, *) {
                k_SafeInset = view.safeAreaInsets
            } else {
                k_SafeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        // tabBarController的主题颜色
        self.tabBar.tintColor = UIColor.hexadecimalColor(hexadecimal: "#333333")//hexadecimalColor(hexadecimal: "#f8c112")
        
        setupChildVC()
    }
    
    func setupChildVC() {
        let homeVC = LJX_HomePageViewController.init()//LJX_HomeViewController.init()
        let xzVC = LJX_ScheduleBaseViewController.init()//LJX_ZXViewController.init()
        let mineVC = LJX_MineViewController.init()
        let zjVC = LJX_ZJViewController.init()
        
        let expertVC = LJX_ExpertViewController.init()
        
        let homeNav = createChildVC(vc: homeVC, title: "首页", imageName: "首页-2", seleteImageName: "首页")
        
        let xzNav = createChildVC(vc: xzVC, title: "赛程", imageName:"智能-2" , seleteImageName:"智能")

        let zjNav = createChildVC(vc: zjVC, title: "专家", imageName:"信用卡-常规" , seleteImageName:"信用卡-点击" )
        
        let ycNav = createChildVC(vc: expertVC, title: "预测", imageName: "购物-2", seleteImageName: "购物")
        
        let mineNav = createChildVC(vc: mineVC, title: "我的", imageName: "我的-2", seleteImageName: "我的")
        
        self.viewControllers = [homeNav,xzNav,mineNav] // ,zjNav,ycNav
    }
    
    func createChildVC(vc:UIViewController,  title:String , imageName:String , seleteImageName:String) -> UINavigationController {
        
        let navigation = UINavigationController.init(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage.init(named: seleteImageName)?.withRenderingMode(.alwaysOriginal)
        
        return navigation
    }
}
