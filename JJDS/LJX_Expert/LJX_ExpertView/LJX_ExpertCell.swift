//
//  LJX_ExpertCell.swift
//  JJDS
//
//  Created by a on 2019/5/16.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ExpertCell: UITableViewCell {    
    
    var titleLabel = UILabel()
    var lineView = UILabel()
    // 左侧队伍
    var leftView = UIView()
    var leftBtn = UIButton()
    var leftTitle = UILabel()
    // 右侧队伍
    var rightView = UIView()
    var rightTitle = UILabel()
    var rightBtn = UIButton()
    // 中间
    var midView = UIView()
    var midTitleLabel = UILabel()
    var leftScoreLabel = UILabel()
    var rightScoreLabel = UILabel()
    var stausLabel = UILabel()
    var timeLabel = UILabel()
    
    // 赋值model
    private var _homeModel : LJX_ExpertModel?
    var homeModel : LJX_ExpertModel? {
        set {
            _homeModel = newValue
            
            // 标题
            self.titleLabel.text = "\(String(_homeModel?.league_name ?? String()))  \(String(_homeModel?.round ?? String()))"
            // 左侧队伍
            leftTitle.text = _homeModel?.leftTeamTag
            leftBtn.sd_setImage(with:URL(string: _homeModel?.leftTeamLogo ?? ""), for: UIControl.State.normal, completed: nil)
            // 右侧队伍
            rightTitle.text = _homeModel?.rightTeamTag
            rightBtn.sd_setImage(with:URL(string: _homeModel?.rightTeamLogo ?? ""), for: UIControl.State.normal, completed: nil)
            // 中间view
            if _homeModel?.mainBetTopicGameNo?.isEmpty == nil  {
                self.midTitleLabel.text = ""
            } else {
                let titleL = Int(_homeModel?.mainBetTopicGameNo ?? String()) == 2 ? "地图" : "第"
                let titleR = Int(_homeModel?.mainBetTopicGameNo ?? String()) == 2 ? "获胜者" : "局获胜者"
                midTitleLabel.text = Int(_homeModel?.mainBetTopicGameNo ?? String()) == 0 ? "全场获胜者" : "\(String(titleL))\(String(_homeModel?.mainBetTopicGameNo ?? String()))\(String(titleR))"
            }
            if _homeModel?.mainBetTopicLeftOdd?.isEmpty == nil {
                leftScoreLabel.text = ""
                rightScoreLabel.text = ""
                leftScoreLabel.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#666666").cgColor
            } else {
                // 左右比分
                leftScoreLabel.text = _homeModel?.mainBetTopicLeftOdd
                rightScoreLabel.text = _homeModel?.mainBetTopicRightOdd
            }
            // 时间
            let dateStr = _homeModel?.start_time
            let dateString = dateStr?[5,5] ?? ""
            let timeString = dateStr?[11,5] ?? ""
            timeLabel.text = "\(dateString)  \(timeString)"
        }
        get {
            return _homeModel
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
        // 标题
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#333333")
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.text = "5月10日主播解析天天有，精彩赛事不容错过"
        titleLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.size.width - 30.0
        self.contentView.addSubview(titleLabel)
        // 线
        lineView = UILabel.init()
        lineView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#DEDEDE")
        self.contentView.addSubview(lineView)
        // 左侧队伍
        leftView = UIView.init()
        leftView.backgroundColor = UIColor.white
        self.contentView.addSubview(leftView)
        // logo
        leftBtn = UIButton.init()
        leftBtn.backgroundColor = UIColor.white
        leftBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        leftBtn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        leftView.addSubview(leftBtn)
        // title
        leftTitle = UILabel.init()
        leftTitle.backgroundColor = UIColor.white
        leftTitle.textColor = UIColor.black
        leftTitle.font = UIFont.systemFont(ofSize: 12)
        leftTitle.textAlignment = NSTextAlignment.center
        leftView.addSubview(leftTitle)
        // 右侧队伍
        rightView = UIView.init()
        rightView.backgroundColor = UIColor.white
        self.contentView.addSubview(rightView)
        // logo
        rightBtn = UIButton.init()
        rightBtn.backgroundColor = leftBtn.backgroundColor
        rightView.addSubview(rightBtn)
        // title
        rightTitle = UILabel.init()
        rightTitle.backgroundColor = leftTitle.backgroundColor
        rightTitle.textColor = leftTitle.textColor
        rightTitle.font = leftTitle.font
        rightTitle.textAlignment = leftTitle.textAlignment
        rightView.addSubview(rightTitle)
        // 中间view
        midView = UIView.init()
        midView.backgroundColor = UIColor.white
        self.contentView.addSubview(midView)
        
        midTitleLabel = UILabel.init()
        midTitleLabel.text = "全场获胜者"
        midTitleLabel.font = UIFont.systemFont(ofSize: 14)
        midTitleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#666666")
        midTitleLabel.textAlignment = NSTextAlignment.center
        midView.addSubview(midTitleLabel)
        
        leftScoreLabel = UILabel.init()
        leftScoreLabel.text = "0"
        leftScoreLabel.font = UIFont.boldSystemFont(ofSize: 16)
        leftScoreLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#3D79FD")
        leftScoreLabel.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#3D79FD").cgColor
        leftScoreLabel.layer.borderWidth = 1.0
        leftScoreLabel.layer.cornerRadius = 5
        leftScoreLabel.textAlignment = NSTextAlignment.center
        midView.addSubview(leftScoreLabel)
        
        rightScoreLabel = UILabel.init()
        rightScoreLabel.text = "2"
        rightScoreLabel.font = leftScoreLabel.font
        rightScoreLabel.textColor = leftScoreLabel.textColor
        rightScoreLabel.layer.borderColor = leftScoreLabel.layer.borderColor
        rightScoreLabel.layer.borderWidth = leftScoreLabel.layer.borderWidth
        rightScoreLabel.textAlignment = leftScoreLabel.textAlignment
        rightScoreLabel.layer.cornerRadius = leftScoreLabel.layer.cornerRadius
        midView.addSubview(rightScoreLabel)
        
        stausLabel = UILabel.init()
        stausLabel.text = "VS"
        stausLabel.textColor = UIColor.black
        stausLabel.font = midTitleLabel.font
        stausLabel.textAlignment = midTitleLabel.textAlignment
        midView.addSubview(stausLabel)
        
        timeLabel = UILabel.init()
        timeLabel.text = "05月15日 17:00"
        timeLabel.font = midTitleLabel.font
        timeLabel.textColor = midTitleLabel.textColor
        timeLabel.textAlignment = midTitleLabel.textAlignment
        midView.addSubview(timeLabel)
    }
    
    func createConstrainte()  {
        // contentView
        self.contentView.snp.remakeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(-10)
        }
        // 标题
        titleLabel.snp.remakeConstraints { (make) in
            make.left.top.equalTo(15)
        }
        // 线
        lineView.snp.remakeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(1)
        }
        // 左侧队伍
        leftView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp_bottom)
            make.left.equalTo(0)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(100)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
        }
        leftBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(leftBtn.snp_width)
        }
        leftTitle.snp.makeConstraints { (make) in
            make.top.equalTo(leftBtn.snp_bottom)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        // 右侧队伍
        rightView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(leftView)
            make.right.equalTo(-10)
            make.width.equalTo(leftView.snp_width)
        }
        rightBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(rightBtn.snp_width)
        }
        rightTitle.snp.makeConstraints { (make) in
            make.top.equalTo(rightBtn.snp_bottom)
            make.height.width.equalTo(leftTitle)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        // 中间view
        midView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(leftView)
            make.left.equalTo(leftView.snp_right)
            make.right.equalTo(rightView.snp_left)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
        }
        midTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(10)
            make.height.equalTo(midView.snp_height).multipliedBy(0.2)
        }
        
        leftScoreLabel.snp.makeConstraints { (make) in
            make.left.equalTo(midView.snp_left).offset(10)
            make.top.equalTo(midTitleLabel.snp_bottom).offset(10)
            make.height.equalTo(midView.snp_height).multipliedBy(0.3)
            make.width.equalTo(midTitleLabel.snp_width).multipliedBy(0.3)
        }
        
        rightScoreLabel.snp.makeConstraints { (make) in
            make.width.height.top.equalTo(leftScoreLabel)
            make.right.equalTo(midView.snp_right).offset((-10))
        }
        
        stausLabel.snp.makeConstraints { (make) in
            make.height.top.equalTo(leftScoreLabel)
            make.left.equalTo(leftScoreLabel.snp_right)
            make.right.equalTo(rightScoreLabel.snp_left)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(leftScoreLabel.snp_bottom).offset(10)
            make.left.right.equalTo(midTitleLabel)
            make.height.equalTo(20)
            make.bottom.equalTo(midView.snp_bottom)
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
