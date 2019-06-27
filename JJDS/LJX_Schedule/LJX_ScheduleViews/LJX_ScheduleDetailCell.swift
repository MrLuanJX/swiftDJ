//
//  LJX_ScheduleDetailCell.swift
//  JJDS
//
//  Created by a on 2019/5/27.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ScheduleDetailCell: UITableViewCell {

    var leftTitle = UILabel()
    var leftProTitle = UILabel()
    var leftProgress = UIProgressView()
    
    var rightTitle = UILabel()
    var rightProTitle = UILabel()
    var rightProgress = UIProgressView()
    
    var midLabel = UILabel()
    
    // 赋值model
    private var _sDetailModel : LJX_ScheduleDetailModel?
    var sDetailModel : LJX_ScheduleDetailModel? {
        set {
            _sDetailModel = newValue
            
            self.leftTitle.text = "\(String("近")+String(sDetailModel?.number ?? String())+String("场"))"
            self.leftProTitle.text = "\(String(sDetailModel?.random ?? String())+String("%"))"
            var fR = Float()
            fR = Float(sDetailModel?.random ?? "0.00") as! Float
            let a = fR/100.0
            self.leftProgress.progress = a
            
            self.midLabel.text = sDetailModel?.name
            self.rightTitle.text = "\(String("近")+String(sDetailModel?.number2 ?? String())+String("场"))"
            self.rightProTitle.text = "\(String(sDetailModel?.random2 ?? String())+String("%"))"
            var fR2 = Float()
            fR2 = Float(sDetailModel?.random2 ?? "0.00") as! Float
            let b = fR/100.0
            self.rightProgress.progress = b
        }
        get {
            return _sDetailModel
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
        createConstrainte()
    }
    
    func setupUI()  {
        leftTitle = UILabel.init()
        leftTitle.textColor = UIColor.black
        leftTitle.font = UIFont.systemFont(ofSize: 14)
        leftTitle.text = "近8场"
        self.contentView.addSubview(leftTitle)
        
        leftProTitle = UILabel.init()
        leftProTitle.textColor = leftTitle.textColor
        leftProTitle.font = leftTitle.font
        leftProTitle.text = "80%"
        self.contentView.addSubview(leftProTitle)
        
        leftProgress = UIProgressView.init()
        leftProgress.tintColor = UIColor.blue
        leftProgress.progress = 0.8
        self.contentView.addSubview(leftProgress)
        
        midLabel = UILabel.init()
        midLabel.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        midLabel.font = leftTitle.font
        midLabel.textColor = UIColor.white
        midLabel.text = "adsetge"
        midLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(midLabel)
        
        rightTitle = UILabel.init()
        rightTitle.textColor = leftTitle.textColor
        rightTitle.font = leftTitle.font
        rightTitle.text = "近12场"
        self.contentView.addSubview(rightTitle)
        
        rightProTitle = UILabel.init()
        rightProTitle.textColor = leftTitle.textColor
        rightProTitle.font = leftTitle.font
        rightProTitle.text = "30%"
        self.contentView.addSubview(rightProTitle)
        
        rightProgress = UIProgressView.init()
        rightProgress.tintColor = UIColor.blue
        rightProgress.progress = 0.3
        self.contentView.addSubview(rightProgress)
        
    }
    
    func createConstrainte()  {
        self.contentView.snp.remakeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        
        midLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
        }
        
        leftTitle.snp.remakeConstraints { (make) in
            make.centerY.equalTo(midLabel.snp_centerY).offset(-10)
            make.left.equalTo(10)
            make.height.equalTo(20)
        }
        
        leftProTitle.snp.remakeConstraints { (make) in
            make.top.height.equalTo(leftTitle)
            make.right.equalTo(midLabel.snp_left).offset(-20)
        }
        
        leftProgress.snp.remakeConstraints { (make) in
            make.top.equalTo(leftTitle.snp_bottom).offset(10)
            make.right.equalTo(leftProTitle.snp_right)
            make.left.equalTo(leftTitle.snp_left)
        }
        
        rightTitle.snp.remakeConstraints { (make) in
            make.left.equalTo(midLabel.snp_right).offset(20)
            make.top.height.equalTo(leftTitle)
        }
        
        rightProTitle.snp.remakeConstraints { (make) in
            make.top.height.equalTo(leftProTitle)
            make.right.equalToSuperview().offset(-20)
        }
        
        rightProgress.snp.remakeConstraints { (make) in
            make.left.equalTo(rightTitle.snp_left)
            make.right.equalTo(rightProTitle.snp_right)
            make.centerY.equalTo(leftProgress.snp_centerY)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
