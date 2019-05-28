//
//  LJX_ZJCollectionCell.swift
//  JJDS
//
//  Created by a on 2019/5/17.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ZJTableViewCell: UITableViewCell {
    
    var cycleLabel = UILabel()
    
    var nameLabel = UILabel()
    
    var timeLabel = UILabel()
    
    var desLabel = UILabel()
    
    var iconImg = UIImageView()
    
    var titleLabel = UILabel()
    
    var tjLabel = UILabel()

    var grayView = UIView()

    var grayTitle = UILabel()
    
    var leftBtn = UIButton()
    
    var vsLabel = UILabel()
    
    var rightBtn = UIButton()
    
    var globTopLabel = UILabel()
    
    var globBottomLabel = UILabel()
    
    
    // 赋值model
    private var _zjModel : LJX_ZJListModel?
    var zjModel : LJX_ZJListModel? {
        set {
            _zjModel = newValue
            // 作者头像
            self.iconImg.sd_setImage(with: URL.init(string: _zjModel?.analystAvatar ?? String()), placeholderImage: UIImage.init())
            // 作者昵称
            self.nameLabel.text = _zjModel?.analystName
            // 标题
            self.titleLabel.text = _zjModel?.title
            // 灰色view
            // 标题
            self.grayTitle.text = "\(String(_zjModel?.seriesLeagueName ?? String()))  \(String(_zjModel?.seriesRound ?? String()))"
            // 左边战队
//            self.leftBtn.sd_setImage(with:URL(string: _zjModel?.seriesLeftLogo ?? ""), for: UIControl.State.normal, completed: nil)
            self.leftBtn.setTitle(_zjModel?.seriesLeftTag, for: UIControl.State.normal)
            
            self.rightBtn.setTitle(_zjModel?.seriesRightTag, for: UIControl.State.normal)
        }
        get {
            return _zjModel
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EAEAEA")
        
        self.contentView.backgroundColor = UIColor.white
        
        setupUI()
        
        createConstrainte()
    }
    
    func setupUI() {
        // 头像
        iconImg = UIImageView.init()
        iconImg.layer.cornerRadius = 20
        iconImg.layer.masksToBounds = true
        iconImg.backgroundColor = UIColor.red
        self.contentView.addSubview(iconImg)
        // 昵称
        nameLabel = UILabel.init()
        nameLabel.text = "饭老师"
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.contentView.addSubview(nameLabel)
        // 副标题
        desLabel = UILabel.init()
        desLabel.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#C6E2FF")
        desLabel.font = UIFont.systemFont(ofSize: 12)
        desLabel.textColor = UIColor.white
        desLabel.text = "近10中6"
        desLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(desLabel)
        
        //
        cycleLabel = UILabel.init()
        cycleLabel.textColor = UIColor.white
        cycleLabel.backgroundColor = UIColor.red
        cycleLabel.text = "红"
        cycleLabel.layer.cornerRadius = 15
        cycleLabel.layer.masksToBounds = true
        cycleLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(cycleLabel)
        
        // 标题
        titleLabel = UILabel.init()
        titleLabel.text = "赢一把啊"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.size.width - 30
        self.contentView.addSubview(titleLabel)
        
        // 推荐
        tjLabel = UILabel.init()
        tjLabel.textColor = UIColor.lightGray
        tjLabel.font = UIFont.systemFont(ofSize: 12)
        tjLabel.text = "推荐买点:大小分"
        self.contentView.addSubview(tjLabel)
        
        // 灰色view
        grayView = UIView.init()
        grayView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EBEBEB")
        self.contentView.addSubview(grayView)
        // 比赛标题
        grayTitle = UILabel.init()
        grayTitle.text = "SL-iMajor亚洲Minor东南亚封闭预选赛"
        grayTitle.font = UIFont.systemFont(ofSize: 12)
        grayTitle.textColor = UIColor.lightGray
        grayView.addSubview(grayTitle)
        
        // 左战队
        leftBtn = UIButton.init()
        leftBtn.setTitle("KeenGaming", for: UIControl.State.normal)
        leftBtn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        grayView.addSubview(leftBtn)
        
        vsLabel = UILabel.init()
        vsLabel.text = "VS"
        vsLabel.font = UIFont.systemFont(ofSize: 12)
        vsLabel.textColor = UIColor.lightGray
        vsLabel.textAlignment = NSTextAlignment.center
        grayView.addSubview(vsLabel)

        // 右战队
        rightBtn = UIButton.init()
        rightBtn.setTitle("KeenGaming", for: UIControl.State.normal)
        rightBtn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        grayView.addSubview(rightBtn)
        
        globTopLabel = UILabel.init()
        globTopLabel.backgroundColor = UIColor.black
        globTopLabel.textColor = UIColor.white
        globTopLabel.text = "9金币"
        globTopLabel.font = UIFont.systemFont(ofSize: 12)
        globTopLabel.textAlignment = NSTextAlignment.center
        grayView.addSubview(globTopLabel)
        
        globBottomLabel = UILabel.init()
        globBottomLabel.backgroundColor = UIColor.white
        globBottomLabel.textColor = UIColor.black
        globBottomLabel.layer.borderColor = UIColor.black.cgColor
        globBottomLabel.layer.borderWidth = 1.0
        globBottomLabel.text = "不中全退"
        globBottomLabel.font = UIFont.systemFont(ofSize: 12)
        globBottomLabel.textAlignment = NSTextAlignment.center
        grayView.addSubview(globBottomLabel)
        // 时间-阅读量
        timeLabel = UILabel.init()
        timeLabel.text = "发布于2019-10-19 | 阅读 0"
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = UIColor.gray
        self.contentView.addSubview(timeLabel)
    }
    
    func createConstrainte() {
        
        self.contentView.snp.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        iconImg.snp.remakeConstraints { (make) in
            make.top.left.equalTo(15)
            make.width.height.equalTo(40)
        }
        
        cycleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(iconImg.snp_centerY)
            make.right.equalTo(-15)
            make.width.height.equalTo(30)
        }
        
        nameLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(iconImg.snp_top)
            make.left.equalTo(iconImg.snp_right).offset(10)
            make.width.equalTo(self.contentView.snp_width).multipliedBy(0.5)
            make.height.equalTo(iconImg.snp_height).multipliedBy(0.5)
        }
        
        desLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(nameLabel.snp_bottom)
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(iconImg.snp_bottom)
            make.width.equalTo(60)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(iconImg.snp_bottom).offset(10)
            make.right.equalTo(-15)
            make.left.equalTo(iconImg)
        }
        
        tjLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom)
            make.left.right.equalTo(titleLabel)
        }
        
        grayView.snp.remakeConstraints { (make) in
            make.top.equalTo(tjLabel.snp_bottom).offset(10)
            make.left.equalTo(iconImg.snp_left)
            make.right.equalTo(titleLabel.snp_right)
        }
        
        grayTitle.snp.remakeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        leftBtn.snp.remakeConstraints { (make) in
            make.top.equalTo(grayTitle.snp_bottom)
            make.left.equalTo(grayTitle.snp_left)
            make.height.equalTo(30)
            
            make.bottom.equalTo(grayView.snp_bottom).offset(-10)
        }
        vsLabel.snp.remakeConstraints { (make) in
            make.height.top.equalTo(leftBtn)
            make.left.equalTo(leftBtn.snp_right).offset(5)
            make.width.equalTo(30)
        }
        rightBtn.snp.remakeConstraints { (make) in
            make.height.top.equalTo(leftBtn)
            make.left.equalTo(vsLabel.snp_right).offset(5)
        }
        
        globTopLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(grayTitle)
            make.height.equalTo(grayTitle.snp_height).offset(5)
            make.right.equalTo(-10)
            make.width.equalTo(70)
        }
        
        globBottomLabel.snp.remakeConstraints { (make) in
            make.width.height.right.equalTo(globTopLabel)
            make.top.equalTo(globTopLabel.snp_bottom)
        }
        
        timeLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(grayView.snp_bottom).offset(10)
            make.left.right.equalTo(grayView)
            
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)

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

