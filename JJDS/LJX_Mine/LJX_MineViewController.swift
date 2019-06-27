//
//  LJX_MineViewController.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import WisdomHUD

class LJX_MineViewController: UIViewController {
    
    var mineTableView : UITableView!
    
    var loginBtn = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //设置导航栏背景透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = ""
        
        let def = UserDefaults.standard
        var isLogin = String()
        if def.object(forKey: "login") != nil {
            isLogin = def.object(forKey: "login") as! String
            if isLogin == "logout" {
                self.loginBtn.isHidden = false
            } else {
                self.loginBtn.isHidden = true
            }
        } else {
            self.loginBtn.isHidden = false
        }
        
        MobClick.beginLogPageView(MinePage)
        JANALYTICSService.startLogPageView(MinePage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView(MinePage)
        JANALYTICSService.stopLogPageView(MinePage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        createUI()
        
        mineTableView.contentInset = UIEdgeInsets.init(top: -navHeight, left: 0, bottom: 0, right: 0)
    }
    
    func createUI() {
        initTableView()
    }
    
    func initTableView() {
        mineTableView = UITableView.init(frame: CGRect(x: 0, y:0 , width: view.frame.width, height: view.frame.size.height), style: UITableView.Style.grouped)
        mineTableView.estimatedRowHeight = 50
        mineTableView.delegate = self
        mineTableView.dataSource = self
        mineTableView.tableFooterView = UIView()
        mineTableView.estimatedSectionHeaderHeight = 0
        mineTableView.estimatedSectionFooterHeight = 0
        mineTableView.rowHeight = UITableView.automaticDimension
        mineTableView.tableHeaderView = tableHeadView()

        view.addSubview(mineTableView)
        mineTableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func tableHeadView() -> UIView {
        // 应用程序信息
        let appName: String = (Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName")as!String?)!

        let mineHeadView = UIImageView()
        mineHeadView.image = UIImage.init(named: "DJDS_BGView.jpg")
        mineHeadView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width/1.5)
        mineHeadView.contentMode = UIView.ContentMode.scaleAspectFill
        mineHeadView.clipsToBounds = true
        mineHeadView.isUserInteractionEnabled = true
        
        let setBtn = UIButton()
        setBtn.setTitle("设置", for: UIControl.State.normal)
        setBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        setBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setBtn.addTarget(self, action: #selector(setBtnAction), for: UIControl.Event.touchUpInside)
        mineHeadView.addSubview(setBtn)
        
        setBtn.snp.remakeConstraints { (make) in
            make.top.equalTo(navHeight)
            make.right.equalTo(-25)
            make.width.height.equalTo(40)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "\(String("欢迎来到")+String(appName))"
        mineHeadView.addSubview(titleLabel)
        
        titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        let desLabel = UILabel()
        desLabel.font = UIFont.systemFont(ofSize: 16)
        desLabel.text = "电竞玩家聚集地"
        desLabel.textColor = titleLabel.textColor
        mineHeadView.addSubview(desLabel)
        
        desLabel.snp.remakeConstraints { (make) in
            make.right.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
        }
        
        loginBtn = UIButton()
        loginBtn.setTitle("登录/注册", for: UIControl.State.normal)
        loginBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loginBtn.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
        loginBtn.addTarget(self, action: #selector(loginAction), for: UIControl.Event.touchUpInside)
        mineHeadView.addSubview(loginBtn)
        
        loginBtn.snp.remakeConstraints { (make) in
            make.top.equalTo(desLabel.snp_bottom).offset(20)
            make.left.equalTo(titleLabel.snp_left)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        return mineHeadView
    }
    
    @objc func loginAction() {
        let loginVC = LJX_LoginViewController.init()
        loginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func setBtnAction()  {
        print("设置")
        
        self.navigationController?.pushViewController(LJX_SetupViewController.init(), animated: true)
    }
}

extension LJX_MineViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "mineCell"
        
        // 获取App的build版本
        let infoDic = Bundle.main.infoDictionary
        let appVersion:String = infoDic?["CFBundleShortVersionString"]! as! String
        
        var mineCell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:indentifier)
        
        if mineCell == nil {
            mineCell = UITableViewCell.init(style: .value1, reuseIdentifier: indentifier)
        }
        
        mineCell.accessoryType = indexPath.section == 0 ? UITableViewCell.AccessoryType.disclosureIndicator : UITableViewCell.AccessoryType.none
        mineCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        mineCell.textLabel?.text = indexPath.section == 0 ? "清除缓存" : "当前版本"
        mineCell.detailTextLabel?.text = indexPath.section == 0 ? "" : appVersion
        return mineCell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 30 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            clean()
        }
    }
    
    func clean(){
        
        DispatchQueue.global().async {
            // 取出cache文件夹路径
            let cachePath = NSSearchPathForDirectoriesInDomains(
                .cachesDirectory, .userDomainMask, true).first
            
            // 取出文件夹下所有文件数组
            let files = FileManager.default.subpaths(atPath: cachePath!)
            
            // 用于统计文件夹内所有文件大小
            var big = Int();
            
            // 快速枚举取出所有文件名
            for p in files!{
                // 把文件名拼接到路径中
                let path = cachePath!.appendingFormat("/\(p)")
                
                // 取出文件属性
                if let floder = try? FileManager.default.attributesOfItem(atPath: path){
                    
                    // 用元组取出文件大小属性
                    for (abc,bcd) in floder {
                        // 只去出文件大小进行拼接
                        if abc == FileAttributeKey.size{
                            big += (bcd as AnyObject).integerValue
                        }
                    }
                }
            }
            
            // 提示框
            let message = "\(big/(1024*1024))M缓存"
            
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "清除缓存", message: message, preferredStyle: UIAlertController.Style.alert)
                
                let alertConfirm = UIAlertAction(title: "确定", style: UIAlertAction.Style.default) { (alertConfirm) -> Void in
                    
                    if let files = files{
                        
                        if files.isEmpty{
                            WisdomHUD.showSuccess(text: "清除成功~")
                        }
                        // 点击确定时开始删除
                        for p in files{
                            // 拼接路径
                            let path = cachePath!.appendingFormat("/\(p)")
                            
                            if(FileManager.default.fileExists(atPath: path) && FileManager.default.isDeletableFile(atPath: path)){
                                do {
                                    try FileManager.default.removeItem(atPath: path as String)
                                    WisdomHUD.showSuccess(text: "清除成功~")
                                } catch {
                                    print("removeItemAtPath err"+path)
                                }
                            }
                        }
                        
                    }else{
                        WisdomHUD.showSuccess(text: "清除成功~")
                    }
                }
                
                alert.addAction(alertConfirm)
                
                let cancle = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (cancle) -> Void in
                    
                }
                alert.addAction(cancle)
                // 提示框弹出
                self.present(alert, animated: true) { () -> Void in
                    
                }
            }
        }
    }
}
