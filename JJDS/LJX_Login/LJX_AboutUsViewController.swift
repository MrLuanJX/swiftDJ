//
//  LJX_AboutUsViewController.swift
//  JJDS
//
//  Created by a on 2019/5/27.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_AboutUsViewController: UIViewController {

    var iconImage = UIImageView()
    
    var titleLabel = UILabel()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MobClick.beginLogPageView(AboutPage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView(AboutPage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = [UIColor.hexadecimalColor(hexadecimal: "#191970").cgColor,
                      UIColor.hexadecimalColor(hexadecimal: "#4682B4").cgColor,
        ]
        LJX_LayerRadius.gradientColor(view: view,colors)
        
        self.navigationItem.title = "关于我们"
        
        createUI()
    }
    
    func createUI() {
        iconImage = UIImageView.init()
        iconImage.image = UIImage.init(named: "djdr")
        view.addSubview(iconImage)
        
        titleLabel = UILabel.init()
        titleLabel.text = "做属于电竞爱好者最喜爱的APP"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#999999")
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        iconImage.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.width.height.equalTo(100)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(iconImage.snp_bottom).offset(30)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
    }

}
