//
//  LJX_HomeDetailCell.swift
//  JJDS
//
//  Created by a on 2019/5/14.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_HomeDetailCell: UITableViewCell {

    var titleLabel = UILabel()
    
    var timeLabel = UILabel()
    
    var textView = UITextView()
    
    var _cellIndex : IndexPath?
    var cellIndex : IndexPath? {
        set {
            _cellIndex = newValue
        }
        get {
            return _cellIndex
        }
    }
    
    // 赋值model
    private var _detailModel : LJX_HomeModel?
    var detailModel : LJX_HomeModel? {
        set {
            _detailModel = newValue
            
            self.titleLabel.text = _detailModel?.title
            self.timeLabel.text = _detailModel?.created_at
            
            let str = _detailModel?.content
            
            self.textView.text = str?.replacingOccurrences(of: "max-width:100%;\"", with: "max-width:50%;\"")
            
            let attrStr = try! NSMutableAttributedString(
                data: (textView.text.data(using: .unicode, allowLossyConversion: true)!),
                options:[.documentType: NSAttributedString.DocumentType.html,
                         .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            //行高
            let paraph = NSMutableParagraphStyle()
            paraph.lineSpacing = 10
            attrStr.addAttributes([NSAttributedString.Key.paragraphStyle:paraph],
                                  range: NSMakeRange(0, attrStr.length))
            
            textView.attributedText = attrStr
            //计算高度
            let size:CGRect = attrStr.boundingRect(with:  CGSize(width: k_WIDTH - 20, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue), context: nil)
            
            textView.frame.size.height = size.height
            
            textView.snp.updateConstraints { (make) in
                make.top.equalTo(timeLabel.snp_bottom).offset(15)
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.height.equalTo(size.height)
                make.bottom.equalTo(contentView.snp_bottom).offset(-10)
            }
            
            if cellIndex?.section == 1 {
                print("----------1---------")
            }
        }
        get {
            return _detailModel
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
        
        createConstrainte()
    }
    
    func configUI()  {
        
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.size.width - 20.0
        titleLabel.text = "五五开黑答题赢好礼活动开启公告：可获得五五狂欢荣耀播报"
        self.contentView.addSubview(titleLabel)
        
        timeLabel = UILabel.init()
        timeLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#666666")
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        timeLabel.text = "电竞大师官方  \("2019-05-13 16:49:55")"
        self.contentView.addSubview(timeLabel)
        
        textView = UITextView.init()
        textView.backgroundColor = UIColor.white
        textView.sizeToFit()
        textView.isUserInteractionEnabled = false
        self.contentView.addSubview(textView)
    }
    
    func createConstrainte()  {
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    
        // 标题
        titleLabel.snp.remakeConstraints { (make) in
            make.left.top.equalTo(10)
            make.right.equalTo(-10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
            make.right.left.equalTo(titleLabel)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp_bottom).offset(15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(1000)
            make.bottom.equalTo(contentView.snp_bottom).offset(-10)
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


