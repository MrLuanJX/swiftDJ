//
//  LJX_LoginViewController.swift
//  JJDS
//
//  Created by a on 2019/5/24.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import WisdomHUD

class LJX_LoginViewController: UIViewController {

    var nameLabel = UILabel()
    var nameTextF = UITextField()
    var nameBtmLine = UILabel()
    
    var pswLabel = UILabel()
    var pswTextF = UITextField()
    var pswBtmLine = UILabel()
    
    var loginNow = UIButton()
    var registBtn = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MobClick.beginLogPageView(LoginPage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView(LoginPage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let colors = [UIColor.hexadecimalColor(hexadecimal: "#191970").cgColor,
                      UIColor.hexadecimalColor(hexadecimal: "#4682B4").cgColor,
        ]
        LJX_LayerRadius.gradientColor(view: view,colors)
        
        self.navigationItem.title = "登录"

        setupUI()
    }
    
    func setupUI () {
        nameLabel = UILabel.init()
        nameLabel.text = "用户名:"
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(nameLabel)
        nameTextF = UITextField.init()
        nameTextF.backgroundColor = UIColor.clear
        nameTextF.font = nameLabel.font
        nameTextF.textColor = nameLabel.textColor
        view.addSubview(nameTextF)

        nameBtmLine = UILabel.init()
        nameBtmLine.backgroundColor = UIColor.white
        view.addSubview(nameBtmLine)
        
        pswLabel = UILabel.init()
        pswLabel.text = "密码:"
        pswLabel.textColor = UIColor.white
        pswLabel.textAlignment = NSTextAlignment.left
        pswLabel.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(pswLabel)
        pswTextF = UITextField.init()
        pswTextF.backgroundColor = UIColor.clear
        pswTextF.font = nameLabel.font
        pswTextF.textColor = nameLabel.textColor
        pswTextF.isSecureTextEntry = true
        view.addSubview(pswTextF)
        
        pswBtmLine = UILabel.init()
        pswBtmLine.backgroundColor = UIColor.white
        view.addSubview(pswBtmLine)

        loginNow = UIButton()
        loginNow.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#4169E1")
        loginNow.setTitle("立即登录", for: UIControl.State.normal)
        loginNow.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginNow.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loginNow.layer.cornerRadius = 8.0
        loginNow.addTarget(self, action: #selector(loginAction), for: UIControl.Event.touchUpInside)
        view.addSubview(loginNow)
        
        registBtn = UIButton()
        registBtn.backgroundColor = UIColor.clear
        registBtn.setTitle("注册", for: UIControl.State.normal)
        registBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        registBtn.addTarget(self, action: #selector(registAction), for: UIControl.Event.touchUpInside)
        registBtn.contentHorizontalAlignment = .left
        view.addSubview(registBtn)

        nameLabel.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        nameTextF.snp.remakeConstraints { (make) in
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            make.left.equalTo(nameLabel.snp_left)
            make.right.equalTo(-20)
        }
        nameBtmLine.snp.remakeConstraints { (make) in
            make.top.equalTo(nameTextF.snp_bottom)
            make.left.right.equalTo(nameTextF)
            make.height.equalTo(1)
        }
        pswLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(nameBtmLine.snp_bottom).offset(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        pswTextF.snp.remakeConstraints { (make) in
            make.top.equalTo(pswLabel.snp_bottom).offset(10)
            make.left.equalTo(pswLabel.snp_left)
            make.right.equalTo(-20)
        }
        pswBtmLine.snp.remakeConstraints { (make) in
            make.top.equalTo(pswTextF.snp_bottom)
            make.left.right.equalTo(pswTextF)
            make.height.equalTo(1)
        }
        
        registBtn.snp.remakeConstraints { (make) in
            make.top.equalTo(pswBtmLine.snp_bottom).offset(10)
            make.left.equalTo(pswBtmLine.snp_left)
            make.width.equalTo(pswBtmLine.snp_width).multipliedBy(0.5)
            make.height.equalTo(40)
        }

        loginNow.snp.remakeConstraints { (make) in
            make.top.equalTo(registBtn.snp_bottom).offset(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
    }
    
    @objc func loginAction()  {
        print("登录")
        
        if self.nameTextF.text == "test" && self.pswTextF.text == "123456" {
            let userDef = UserDefaults.standard
            userDef.setValue("login", forKey: "login")
            userDef.synchronize()
            self.navigationController?.popViewController(animated: true)
        } else {
            let def = UserDefaults.standard
            var nameStr = String()
            var pswStr = String()
            if def.object(forKey: "name") != nil && def.object(forKey: "psw") != nil {
                nameStr = def.object(forKey: "name") as! String
                pswStr = def.object(forKey: "psw") as! String
            } else {
                WisdomHUD.showError(text: "用户名或密码错误,请重新输入")
            }
            
            if self.nameTextF.text == nameStr && self.pswTextF.text == pswStr {
                let userDef = UserDefaults.standard
                userDef.setValue("login", forKey: "login")
                userDef.synchronize()
                
                self.navigationController?.popViewController(animated: true)
            } else {
                WisdomHUD.showError(text: "用户名或密码错误,请重新输入")
                return;
            }
        }
    }
    
    @objc func registAction()  {
        print("注册")
        self.navigationController?.pushViewController(LJX_RegistViewController.init(), animated: true)
    }
}
