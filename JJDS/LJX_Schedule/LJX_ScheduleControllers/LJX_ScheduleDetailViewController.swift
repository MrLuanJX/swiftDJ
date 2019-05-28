//
//  LJX_ScheduleDetailViewController.swift
//  JJDS
//
//  Created by a on 2019/5/24.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ScheduleDetailViewController: UIViewController {
    var tableView = UITableView()
    var dataArray : Array<Any> = []

    var detailModel = LJX_ScheduleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        createUI()
        
        self.navigationItem.title = detailModel.league_name
        
        requestScheduleData()
    }
    
    // 列表
    func requestScheduleData() {
        
        print(scheduleDetailURL)
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:scheduleDetailURL, params: nil, header: nil, success: { (data) in
            
            print("",data)
            
            let dataArray : Array<LJX_ScheduleDetailModel> = LJX_ScheduleDetailModel.mj_objectArray(withKeyValuesArray: data) as! [LJX_ScheduleDetailModel]
            
            if dataArray.count > 0 {
                self.dataArray += dataArray
            }
            
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    func createUI() {
        
        initTableView()
    }
    
    func initTableView() {
        tableView = UITableView.init(frame: CGRect(x: 0, y:0 , width: view.frame.width, height: view.frame.size.height), style: UITableView.Style.plain)
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EAEAEA")
        tableView.tableHeaderView = headView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func headView() -> UIView {
        let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        headView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        
        let leftIcon = UIImageView.init()
        leftIcon.layer.cornerRadius = 30
        leftIcon.layer.borderColor = UIColor.white.cgColor
        leftIcon.layer.borderWidth = 1.0
        leftIcon.sd_setImage(with: URL(string: detailModel.left_logo ?? ""), placeholderImage: UIImage.init())
        headView.addSubview(leftIcon)

        let leftName = UILabel.init()
        leftName.font = UIFont.systemFont(ofSize: 15)
        leftName.textColor = UIColor.white
        leftName.text = detailModel.left_tag
        headView.addSubview(leftName)
        
        let stateLabel = UILabel.init()
        stateLabel.backgroundColor = UIColor.init(white: 1.0, alpha: 0.5)
        stateLabel.font = UIFont.systemFont(ofSize: 13)
        stateLabel.layer.cornerRadius = 20
        stateLabel.layer.masksToBounds = true
        stateLabel.textAlignment = NSTextAlignment.center
        stateLabel.textColor = UIColor.white
        let status = detailModel.status
        let statusInt = Int(status!)
        switch  statusInt{
        case 0:
            stateLabel.text = "未开始"
            break
        case 1:
            stateLabel.text = "进行中"
            break
        case 2:
            stateLabel.text = "已结束"
            break
        case -1:
            stateLabel.text = "已取消"
            break
        default:
            break
        }
        headView.addSubview(stateLabel)
        
        let timeLabel = UILabel.init()
        timeLabel.textColor = stateLabel.textColor
        timeLabel.font = stateLabel.font
        // 时间
        let dateStr = detailModel.start_time
        let dateString = dateStr?[5,5] ?? ""
        let timeString = dateStr?[11,5] ?? ""
        timeLabel.text = "\(dateString)  \(timeString)"
        headView.addSubview(timeLabel)
        
        let rightIcon = UIImageView.init()
        rightIcon.layer.cornerRadius = 30
        rightIcon.layer.borderColor = UIColor.white.cgColor
        rightIcon.layer.borderWidth = 1.0
        rightIcon.sd_setImage(with: URL(string: detailModel.right_logo ?? ""), placeholderImage: UIImage.init())
        headView.addSubview(rightIcon)
        
        let rightName = UILabel.init()
        rightName.font = UIFont.systemFont(ofSize: 15)
        rightName.textColor = UIColor.white
        rightName.text = detailModel.right_tag
        headView.addSubview(rightName)
        
        
        stateLabel.snp.remakeConstraints { (make) in
            make.centerX.equalTo(headView.snp_centerX)
            make.centerY.equalTo(leftIcon.snp_centerY)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        leftIcon.snp.remakeConstraints { (make) in
            make.centerY.equalTo(headView.snp_centerY)
            make.right.equalTo(stateLabel.snp_left).offset(-50)
            make.width.height.equalTo(60)
        }
        
        leftName.snp.remakeConstraints { (make) in
            make.top.equalTo(leftIcon.snp_bottom).offset(10)
            make.centerX.equalTo(leftIcon.snp_centerX)
            make.height.equalTo(20)
        }
        
        timeLabel.snp.remakeConstraints { (make) in
            make.centerX.equalTo(stateLabel.snp_centerX)
            make.centerY.equalTo(leftName.snp_centerY)
            make.height.equalTo(leftName.snp_height)
        }
        
        rightIcon.snp.remakeConstraints { (make) in
            make.centerY.equalTo(headView.snp_centerY)
            make.left.equalTo(stateLabel.snp_right).offset(50)
            make.width.height.equalTo(leftIcon)
        }
        
        rightName.snp.remakeConstraints { (make) in
            make.top.equalTo(rightIcon.snp_bottom).offset(10)
            make.centerX.equalTo(rightIcon.snp_centerX)
            make.height.equalTo(leftName)
        }
        
        return headView
    }
}

extension LJX_ScheduleDetailViewController : UITableViewDelegate , UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "sDCell"
        var sDCell:LJX_ScheduleDetailCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_ScheduleDetailCell
        if sDCell == nil {
            sDCell = LJX_ScheduleDetailCell.init(style: .default, reuseIdentifier: indentifier)
        }
        
        sDCell.sDetailModel = self.dataArray[indexPath.row] as? LJX_ScheduleDetailModel

        return sDCell!
    }
}
