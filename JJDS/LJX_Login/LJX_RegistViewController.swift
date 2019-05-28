//
//  LJX_RegistViewController.swift
//  JJDS
//
//  Created by a on 2019/5/24.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import WisdomHUD

class LJX_RegistViewController: UIViewController {

    var nameLabel = UILabel()
    var nameTextF = UITextField()
    var nameBtmLine = UILabel()
    
    var pswLabel = UILabel()
    var pswTextF = UITextField()
    var pswBtmLine = UILabel()
    
    var registNow = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MobClick.beginLogPageView(RegistPage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView(RegistPage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = [UIColor.hexadecimalColor(hexadecimal: "#191970").cgColor,
                      UIColor.hexadecimalColor(hexadecimal: "#4682B4").cgColor,
        ]
        LJX_LayerRadius.gradientColor(view: view,colors)
        
        self.navigationItem.title = "注册"
        
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
        
        registNow = UIButton()
        registNow.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#4169E1")
        registNow.setTitle("立即注册", for: UIControl.State.normal)
        registNow.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registNow.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        registNow.layer.cornerRadius = 8.0
        registNow.addTarget(self, action: #selector(registAction), for: UIControl.Event.touchUpInside)
        view.addSubview(registNow)
        
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
        
        registNow.snp.remakeConstraints { (make) in
            make.top.equalTo(pswBtmLine.snp_bottom).offset(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
    }

    @objc func registAction()  {
        print("注册")
        let userDef = UserDefaults.standard
        userDef.setValue(self.nameTextF.text, forKey: "name")
        userDef.setValue(self.pswTextF.text, forKey: "psw")
        userDef.setValue("login", forKey: "login")
        userDef.synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name("loginSuccess"), object: nil, userInfo: nil)
        
        WisdomHUD.showSuccess(text: "注册成功", delay: 2.0)
        
        perform(#selector(popVC), with: nil, afterDelay: 2.0)
    }

    @objc func popVC()  {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
