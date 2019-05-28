//
//  LJX_HomeTableViewCell.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import SDWebImage

class LJX_HomeTableViewCell: UITableViewCell {
    
    var titleLabel : UILabel!
    
    var timeLabel : UILabel!
    
    var subImageView: UIImageView!
    
    var newsType : UILabel!
    
    var commentBtn : UIButton!
    
    // 赋值model
    private var _homeModel : LJX_HomeModel?
    var homeModel : LJX_HomeModel? {
        set {
            _homeModel = newValue
            self.titleLabel.text = _homeModel?.title
            self.timeLabel.text = _homeModel?.created_at
            self.newsType.text = _homeModel?.tag_name == nil ? "" : _homeModel?.tag_name
            self.commentBtn.setTitle(_homeModel?.comment_count, for: UIControl.State.normal)
            self.subImageView?.sd_setImage(with:URL(string: _homeModel?.cover_image ?? ""), placeholderImage: nil)
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
        
        setupUI()
        
        createConstrainte()
    }
    
    func setupUI() {
        // 标题
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#333333")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.text = "5月10日主播解析天天有，精彩赛事不容错过"
//        titleLabel.preferredMaxLayoutWidth = self.contentView.frame.size.width - 130.0
        self.contentView.addSubview(titleLabel)
        
        // 缩略图
        subImageView = UIImageView.init()
        subImageView.backgroundColor = UIColor.blue
        self.contentView.addSubview(subImageView)
        
        // 发布时间
        timeLabel = UILabel.init()
        timeLabel.text = "2019-05-10 10:22:57"
        timeLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#666666")
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        timeLabel.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(timeLabel)
        
        // 类型
        newsType = UILabel.init()
        newsType.text = "赛事回顾"
        newsType.textColor = timeLabel.textColor
        newsType.font = timeLabel.font
        self.contentView.addSubview(newsType)
        
        // 评论数
        commentBtn = UIButton.init()
        commentBtn.setTitle("0", for: UIControl.State.normal)
        commentBtn.setTitleColor(timeLabel.textColor, for: UIControl.State.normal)
        commentBtn.titleLabel?.font = timeLabel.font
        commentBtn.setImage(UIImage.init(named: "comment_feed"), for: UIControl.State.normal)
        self.contentView.addSubview(commentBtn)
    }
    
    func createConstrainte() {
        // contentView
        self.contentView.snp.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        // 缩略图
        subImageView.snp.remakeConstraints { (make) in
            make.left.top.equalTo(10)
            make.width.equalTo(70*1.7)
            make.height.equalTo(70)
        }
        
        // 标题
        titleLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(subImageView.snp_right).offset(10)
            make.right.equalTo(-10)
        }

        // 时间
        timeLabel.snp.remakeConstraints { (make) in
            make.bottom.equalTo(subImageView.snp_bottom).offset(40)
            make.right.equalTo(titleLabel.snp_right)
            make.height.equalTo(20)
            make.width.equalTo(self.contentView.snp_width).multipliedBy(0.45)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-10)
        }
        // 类型
        newsType.snp.remakeConstraints { (make) in
            make.centerY.equalTo(timeLabel.snp_centerY)
            make.left.equalTo(subImageView.snp_left)
            make.height.equalTo(timeLabel.snp_height)
            make.width.equalTo(self.contentView.snp_width).multipliedBy(0.25)
        }
        // 评论数
        commentBtn.snp.remakeConstraints { (make) in
            make.left.equalTo(newsType.snp_right)
            make.right.equalTo(timeLabel.snp_left)
            make.height.equalTo(timeLabel.snp_height)
            make.centerY.equalTo(timeLabel.snp_centerY)
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

//        LJX_LayerRadius.configSideRadius(iv: subImageView)
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
