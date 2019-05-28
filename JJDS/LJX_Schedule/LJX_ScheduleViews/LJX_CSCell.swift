//
//  LJX_CSCell.swift
//  JJDS
//
//  Created by a on 2019/5/16.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_CSCell: UITableViewCell {
    
    var bgView = UIView()
    
    var titleLabel = UILabel()
    
    var secondLabel = UILabel()
    var secondImg = UIImageView()
    
    var thirdLabel = UILabel()
    
    var fourLabel = UILabel()
    var fourImg = UIImageView()
    
    var fiveLabel = UILabel()
    var fiveImg = UIImageView()
    
    func showAppInfoWithModel( index: NSInteger , bigModel : LJX_ScheduleModel , modelArray : Array<LJX_Matches>) {
        
        self.titleLabel.text = index == 1 ? "局数" : "第\(String(index-1))局"
        if index == 1 {
            self.secondLabel.isHidden = false
            self.secondImg.isHidden = true
            self.secondLabel.text = "胜负"
            
            self.thirdLabel.isHidden = false
            self.thirdLabel.text = "比分"
            
            self.fourLabel.isHidden = false
            self.fourImg.isHidden = true
            self.fourLabel.text = "手枪局(上)"
            
            self.fiveLabel.text = "手枪局(下)"
            self.fiveLabel.isHidden = false
            self.fiveImg.isHidden = true
        } else {
            for (i,model) in modelArray.enumerated() {
                //index是下标，value是值
                if index == i+2 {
                    // 胜负
                    if model.left_team_win?.isEmpty == nil {
                        self.secondLabel.isHidden = false
                        self.secondImg.isHidden = true
                        self.secondLabel.text = "--"
                    } else {
                        self.secondLabel.isHidden = true
                        self.secondImg.isHidden = false
                        self.secondImg.sd_setImage(with: URL.init(string: String(model.left_team_win ?? String()) == "1" ?  bigModel.left_logo ?? "" : bigModel.right_logo ?? ""), placeholderImage: UIImage.init())
                    }
                    // 比分
                    self.thirdLabel.text = "\(String(model.left_score ?? String())) - \(String(model.right_score ?? String()))"
                    // 手枪局(上)
                    if model.first_half_pistol_left_win?.isEmpty == nil {
                        self.fourLabel.isHidden = false
                        self.fourImg.isHidden = true
                        self.fourLabel.text = "--"
                    } else {
                        self.fourLabel.isHidden = true
                        self.fourImg.isHidden = false
                        self.fourImg.sd_setImage(with: URL.init(string: String(model.first_half_pistol_left_win ?? String()) == "1" ?  bigModel.left_logo ?? "" : bigModel.right_logo ?? ""), placeholderImage: UIImage.init())
                    }
                    // 手枪局(下)
                    if model.second_half_pistol_left_win?.isEmpty == nil {
                        self.fiveLabel.isHidden = false
                        self.fiveImg.isHidden = true
                        self.fiveLabel.text = "--"
                    } else {
                        self.fiveLabel.isHidden = true
                        self.fiveImg.isHidden = false
                        self.fiveImg.sd_setImage(with: URL.init(string: String(model.second_half_pistol_left_win ?? String()) == "1" ?  bigModel.left_logo ?? "" : bigModel.right_logo ?? ""), placeholderImage: UIImage.init())
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        setupUI()
        
        createConstrainte()
    }
    
    func setupUI()  {
        bgView = UIView.init()
        bgView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EAEAEA")
        self.contentView.addSubview(bgView)
        
        titleLabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.center
        bgView.addSubview(titleLabel)
        
        secondLabel = UILabel.init()
        secondLabel.font = titleLabel.font
        secondLabel.textColor = titleLabel.textColor
        secondLabel.textAlignment = titleLabel.textAlignment
        bgView.addSubview(secondLabel)
        
        secondImg = UIImageView.init()
        bgView.addSubview(secondImg)
        
        thirdLabel = UILabel.init()
        thirdLabel.font = titleLabel.font
        thirdLabel.textColor = titleLabel.textColor
        thirdLabel.textAlignment = titleLabel.textAlignment
        bgView.addSubview(thirdLabel)
        
        fourLabel = UILabel.init()
        fourLabel.font = titleLabel.font
        fourLabel.textColor = titleLabel.textColor
        fourLabel.textAlignment = titleLabel.textAlignment
        bgView.addSubview(fourLabel)
        
        fourImg = UIImageView.init()
        bgView.addSubview(fourImg)
        
        fiveLabel = UILabel.init()
        fiveLabel.font = titleLabel.font
        fiveLabel.textColor = titleLabel.textColor
        fiveLabel.textAlignment = titleLabel.textAlignment
        bgView.addSubview(fiveLabel)
        
        fiveImg = UIImageView.init()
        bgView.addSubview(fiveImg)
    }
    
    func createConstrainte()  {
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.height.equalTo(50)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(0)
            make.left.equalTo(10)
            make.width.equalTo(bgView.snp_width).multipliedBy(0.19)
        }
        
        secondLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp_right)
            make.width.equalTo(titleLabel.snp_width)
        }
        
        secondImg.snp.makeConstraints { (make) in
            make.center.equalTo(secondLabel.snp_center)
            make.height.width.equalTo(titleLabel.snp_width).multipliedBy(0.4)
        }
        
        thirdLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(titleLabel)
            make.left.equalTo(secondLabel.snp_right)
            make.width.equalTo(titleLabel.snp_width)
        }
        
        fourLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(titleLabel)
            make.left.equalTo(thirdLabel.snp_right)
            make.width.equalTo(titleLabel.snp_width)
        }
        
        fourImg.snp.makeConstraints { (make) in
            make.center.equalTo(fourLabel.snp_center)
            make.height.width.equalTo(secondImg)
        }
        
        fiveLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(titleLabel)
            make.left.equalTo(fourLabel.snp_right)
            make.width.equalTo(titleLabel.snp_width)
        }
        
        fiveImg.snp.makeConstraints { (make) in
            make.center.equalTo(fiveLabel.snp_center)
            make.height.width.equalTo(secondImg)
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
