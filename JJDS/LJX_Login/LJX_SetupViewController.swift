//
//  LJX_SetupViewController.swift
//  JJDS
//
//  Created by a on 2019/5/24.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_SetupViewController: UIViewController {

    var setTableView : UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //重置导航栏背景
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationItem.title = "设置"
        MobClick.beginLogPageView(SetupPage)
        JANALYTICSService.startLogPageView(SetupPage)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //设置导航栏背景透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        MobClick.endLogPageView(SetupPage)
        JANALYTICSService.stopLogPageView(SetupPage)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    func createUI() {
        initTableView()
    }
    
    func initTableView() {
        setTableView = UITableView.init(frame: CGRect(x: 0, y:0 , width: view.frame.width, height: view.frame.size.height), style: UITableView.Style.grouped)
        setTableView.estimatedRowHeight = 50
        setTableView.delegate = self
        setTableView.dataSource = self
        setTableView.tableFooterView = UIView()
        setTableView.estimatedSectionHeaderHeight = 0
        setTableView.estimatedSectionFooterHeight = 0
        setTableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(setTableView)
        setTableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
}

extension LJX_SetupViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let def = UserDefaults.standard
        var isLogin = String()
        if def.object(forKey: "login") != nil {
            isLogin = def.object(forKey: "login") as! String
            if isLogin == "logout" {
                return 1
            } else {
                return 2
            }
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "setupCell"
        
        var mineCell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:indentifier)
        
        if mineCell == nil {
            mineCell = UITableViewCell.init(style: .value1, reuseIdentifier: indentifier)
        }
        
        mineCell.accessoryType = indexPath.section == 0 ? UITableViewCell.AccessoryType.disclosureIndicator : UITableViewCell.AccessoryType.none
        mineCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        mineCell.textLabel?.text = indexPath.section == 0 ? "关于我们" : "退出登录"
        
        return mineCell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 0 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
           let aboutVC = LJX_AboutUsViewController.init()
            aboutVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }
        
        if indexPath.section == 1 {
            let userDef = UserDefaults.standard
            userDef.setValue("logout", forKey: "login")
            userDef.synchronize()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
