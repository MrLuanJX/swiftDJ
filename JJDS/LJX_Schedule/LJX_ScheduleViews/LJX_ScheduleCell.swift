//
//  LJX_ScheduleCell.swift
//  JJDS
//
//  Created by a on 2019/5/14.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ScheduleCell: UITableViewCell {
    // 左侧队伍
    var leftView = UIView()
    var leftBtn = UIButton()
    var leftTitle = UILabel()

    var rightView = UIView()
    var rightTitle = UILabel()
    var rightBtn = UIButton()
    var midView = UIView()
    var titleLabel = UILabel()
    var leftScoreLabel = UILabel()
    var rightScoreLabel = UILabel()
    var stausLabel = UILabel()
    var timeLabel = UILabel()
    
    // 赋值model
    private var _scheduleModel : LJX_ScheduleModel?
    var scheduleModel : LJX_ScheduleModel? {
        set {
            _scheduleModel = newValue
            // 标题
            titleLabel.text = "\(String(_scheduleModel?.league_name ?? ""))   \(String(_scheduleModel?.round ?? ""))"
            // 时间
            let dateStr = _scheduleModel?.start_time
            let dateString = dateStr?[5,5] ?? ""
            let timeString = dateStr?[11,5] ?? ""
            timeLabel.text = "\(dateString)  \(timeString)"
            
            // 左侧队伍
            leftTitle.text = _scheduleModel?.left_tag
            leftBtn.sd_setImage(with:URL(string: _scheduleModel?.left_logo ?? ""), for: UIControl.State.normal, completed: nil)
            // 右侧队伍
            rightTitle.text = _scheduleModel?.right_tag
            rightBtn.sd_setImage(with:URL(string: _scheduleModel?.right_logo ?? ""), for: UIControl.State.normal, completed: nil)
            
            let status = _scheduleModel?.status
            let statusInt = Int(status!)
            switch  statusInt{
            case 0:
                self.stausLabel.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#87CEFA")
                self.stausLabel.text = "未开始"
                leftAndRightScore(leftScore: "-", rightScore: "-")
                break
            case 1:
                self.stausLabel.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#4169E1")
                self.stausLabel.text = "进行中"
                leftAndRightScore(leftScore: _scheduleModel?.left_score ?? "", rightScore:_scheduleModel?.right_score ?? "")
                break
            case 2:
                self.stausLabel.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#C9C9C9")
                self.stausLabel.text = "已结束"
                leftAndRightScore(leftScore: _scheduleModel?.left_score ?? "", rightScore:_scheduleModel?.right_score ?? "")
                break
            case -1:
                self.stausLabel.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#C9C9C9")
                self.stausLabel.text = "已取消"
                leftAndRightScore(leftScore: "-", rightScore: "-")
                break
            default:
                break
            }
        }
        get {
            return _scheduleModel
        }
    }
    // 左 右侧队伍比分
    func leftAndRightScore(leftScore:String , rightScore:String) {
        self.leftScoreLabel.text = leftScore
        self.rightScoreLabel.text = rightScore
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
    
    func setupUI()  {
        
        leftView = UIView.init()
        leftView.backgroundColor = UIColor.white
        self.contentView.addSubview(leftView)
        
        leftBtn = UIButton.init()
        leftBtn.backgroundColor = UIColor.white
        leftBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        leftBtn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        leftView.addSubview(leftBtn)
        
        leftTitle = UILabel.init()
        leftTitle.backgroundColor = UIColor.white
        leftTitle.textColor = UIColor.black
        leftTitle.font = UIFont.systemFont(ofSize: 12)
        leftTitle.textAlignment = NSTextAlignment.center
        leftView.addSubview(leftTitle)
        
        rightView = UIView.init()
        rightView.backgroundColor = UIColor.white
        self.contentView.addSubview(rightView)
        
        rightBtn = UIButton.init()
        rightBtn.backgroundColor = UIColor.white
        rightView.addSubview(rightBtn)
        
        rightTitle = UILabel.init()
        rightTitle.backgroundColor = leftTitle.backgroundColor
        rightTitle.textColor = leftTitle.textColor
        rightTitle.font = leftTitle.font
        rightTitle.textAlignment = leftTitle.textAlignment
        rightView.addSubview(rightTitle)
        
        midView = UIView.init()
        midView.backgroundColor = UIColor.white
        self.contentView.addSubview(midView)
        
        titleLabel = UILabel.init()
        titleLabel.text = "红雨杯第一赛季 BO2"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.textAlignment = NSTextAlignment.center
        midView.addSubview(titleLabel)
        
        leftScoreLabel = UILabel.init()
        leftScoreLabel.text = "0"
        leftScoreLabel.font = UIFont.boldSystemFont(ofSize: 16)
        leftScoreLabel.textColor = UIColor.black
        leftScoreLabel.textAlignment = titleLabel.textAlignment
        midView.addSubview(leftScoreLabel)
        
        rightScoreLabel = UILabel.init()
        rightScoreLabel.text = "2"
        rightScoreLabel.font = leftScoreLabel.font
        rightScoreLabel.textColor = leftScoreLabel.textColor
        rightScoreLabel.textAlignment = titleLabel.textAlignment
        midView.addSubview(rightScoreLabel)
        
        stausLabel = UILabel.init()
        stausLabel.font = leftScoreLabel.font
        stausLabel.textColor = UIColor.white
        stausLabel.textAlignment = titleLabel.textAlignment
        midView.addSubview(stausLabel)
        
        timeLabel = UILabel.init()
        timeLabel.text = "05月15日 17:00"
        timeLabel.font = titleLabel.font
        timeLabel.textColor = titleLabel.textColor
        timeLabel.textAlignment = titleLabel.textAlignment
        midView.addSubview(timeLabel)
    }
    
    func createConstrainte ()  {
        
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        leftView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalTo(self.contentView.snp_bottom)
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
        }
        
        rightView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(leftView)
            make.right.equalTo(-10)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(rightBtn.snp_width)
        }
        
        rightTitle.snp.makeConstraints { (make) in
            make.top.equalTo(rightBtn.snp_bottom)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        midView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(leftView)
            make.left.equalTo(leftView.snp_right)
            make.right.equalTo(rightView.snp_left)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(10)
            make.height.equalTo(midView.snp_height).multipliedBy(0.2)
        }
        
        leftScoreLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp_left)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
            make.height.equalTo(midView.snp_height).multipliedBy(0.35)
            make.width.equalTo(titleLabel.snp_width).multipliedBy(0.2)
        }
        
        rightScoreLabel.snp.makeConstraints { (make) in
            make.width.height.top.equalTo(leftScoreLabel)
            make.right.equalTo(titleLabel)
        }
        
        stausLabel.snp.makeConstraints { (make) in
            make.height.top.equalTo(leftScoreLabel)
            make.left.equalTo(leftScoreLabel.snp_right)
            make.right.equalTo(rightScoreLabel.snp_left)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stausLabel.snp_bottom).offset(10)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(midView.snp_bottom).offset(-10)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        LJX_LayerRadius.configSideRadius(iv: stausLabel , width: stausLabel.frame.size.width/2 , height: stausLabel.frame.size.width/2)
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
