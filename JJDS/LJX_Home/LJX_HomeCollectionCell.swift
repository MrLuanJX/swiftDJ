//
//  LJX_HomeCollectionCell.swift
//  JJDS
//
//  Created by a on 2019/5/21.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_HomeCollectionCell: UICollectionViewCell {
    
    var bgView = UIView()
    
    var titleLabel = UILabel()
    
    var leftLogo = UIImageView()
    
    var leftName = UILabel()
    
    var rightLogo = UIImageView()
    
    var rightName = UILabel()
    
    var leftScroe = UILabel()

    var rightScroe = UILabel()
    
    // 赋值model
    private var _collModel : LJX_HomeCollectModel?
    var collModel : LJX_HomeCollectModel? {
        set {
            _collModel = newValue
            
            self.titleLabel.text = "\(String(_collModel?.league_name ?? String()))  \(String(_collModel?.round ?? String()))"
            self.leftScroe.text = _collModel?.left_score
            self.rightScroe.text = _collModel?.right_score
            self.leftLogo.sd_setImage(with: URL.init(string: _collModel?.leftLogo ?? String()), placeholderImage: UIImage.init())
             self.rightLogo.sd_setImage(with: URL.init(string: _collModel?.rightLogo ?? String()), placeholderImage: UIImage.init())
            self.leftName.text = _collModel?.leftTag
            self.rightName.text = _collModel?.rightTag
        }
        get {
            return _collModel
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        createConstrainte()
    }
    
    func setupUI()  {
        bgView = UIView.init()
        bgView.layer.cornerRadius = 5.0
        bgView.backgroundColor = UIColor.white
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.borderWidth = 1.0
        self.contentView.addSubview(bgView)

        titleLabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#666666")
        titleLabel.textAlignment = NSTextAlignment.left
//        titleLabel.backgroundColor = UIColor .black
        bgView.addSubview(titleLabel)

        leftLogo = UIImageView.init()
//        leftLogo.backgroundColor = UIColor.yellow
        leftLogo.layer.cornerRadius = 15/2
        leftLogo.layer.masksToBounds = true
        bgView.addSubview(leftLogo)
        
        leftName = UILabel.init()
        leftName.text = "EHOME"
        leftName.textColor = titleLabel.textColor
        leftName.font = UIFont.boldSystemFont(ofSize: 15)
        bgView.addSubview(leftName)
        
        rightLogo = UIImageView.init()
//        rightLogo.backgroundColor = UIColor.yellow
        rightLogo.layer.cornerRadius = 15/2
        rightLogo.layer.masksToBounds = true
        bgView.addSubview(rightLogo)
        
        rightName = UILabel.init()
        rightName.text = "EHOME"
        rightName.textColor = titleLabel.textColor
        rightName.font = leftName.font
        bgView.addSubview(rightName)
        
        leftScroe = UILabel.init()
        leftScroe.textColor = UIColor.hexadecimalColor(hexadecimal: "#4169E1")
        leftScroe.font = UIFont.systemFont(ofSize: 16)
        leftScroe.textAlignment = NSTextAlignment.right
        leftScroe.text = "0"
        bgView.addSubview(leftScroe)
        
        rightScroe = UILabel.init()
        rightScroe.textColor = leftScroe.textColor
        rightScroe.font = leftScroe.font
        rightScroe.textAlignment = NSTextAlignment.right
        rightScroe.text = "2"
        bgView.addSubview(rightScroe)
    }
    
    func createConstrainte()  {
        self.contentView.snp.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        bgView.snp.remakeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.equalTo(bgView.snp_right).offset(-10)
            
//            make.bottom.equalTo(bgView.snp_bottom).offset(-10)
        }
        
        leftLogo.snp.remakeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.left.equalTo(titleLabel)
            make.width.height.equalTo(15)
        }
        
        leftName.snp.remakeConstraints { (make) in
            make.top.equalTo(leftLogo)
            make.left.equalTo(leftLogo.snp_right).offset(5)
        }
        
        rightLogo.snp.remakeConstraints { (make) in
            make.top.equalTo(leftName.snp_bottom).offset(5)
            make.width.height.left.equalTo(leftLogo)
        }
        
        rightName.snp.remakeConstraints { (make) in
            make.top.equalTo(rightLogo)
            make.left.equalTo(rightLogo.snp_right).offset(5)
        }
        
        leftScroe.snp.remakeConstraints { (make) in
            make.top.equalTo(leftLogo)
            make.right.equalTo(-15)
        }
        
        rightScroe.snp.remakeConstraints { (make) in
            make.top.equalTo(rightLogo)
            make.right.equalTo(-15)
        }
    }
}
