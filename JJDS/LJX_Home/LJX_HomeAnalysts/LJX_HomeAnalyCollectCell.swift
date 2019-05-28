//
//  LJX_HomeAnalyCollectCell.swift
//  JJDS
//
//  Created by a on 2019/5/22.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_HomeAnalyCollectCell: UICollectionViewCell {
    var bgView = UIView()
    
    var iconImg = UIImageView()
    
    var titleLabel = UILabel()
    
    var typeImg = UIImageView()
    
    // 赋值model
    private var _anaModel : LJX_HomeAnalystsModel?
    var anaModel : LJX_HomeAnalystsModel? {
        set {
            _anaModel = newValue
            
            self.iconImg.sd_setImage(with: URL.init(string: _anaModel?.avatar ?? String()), placeholderImage: UIImage.init())
            self.titleLabel.text = _anaModel?.name ?? String()
            
        }
        get {
            return _anaModel
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
        bgView.backgroundColor = UIColor.white
        bgView.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#C9C9C9").cgColor
        bgView.layer.borderWidth = 1.0
        bgView.layer.cornerRadius = 5.0
        
        iconImg = UIImageView.init()
        iconImg.layer.cornerRadius = 25
        iconImg.layer.masksToBounds = true
        iconImg.backgroundColor = UIColor.purple
        bgView.addSubview(iconImg)
        
        titleLabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.center
        
        typeImg = UIImageView.init()
        typeImg.backgroundColor = UIColor.white
        bgView.addSubview(typeImg)
        
        self.contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
    }
    
    func createConstrainte()  {
        self.contentView.snp.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        bgView.snp.remakeConstraints { (make) in
            make.edges.equalTo(0)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
        
        iconImg.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
            make.width.height.equalTo(50)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(iconImg.snp_bottom).offset(5)
            make.height.equalTo(30)
        }
        
        typeImg.snp.remakeConstraints { (make) in
            make.centerX.equalTo(iconImg)
            make.top.equalTo(titleLabel.snp_bottom)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
}
