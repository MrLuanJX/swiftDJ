//
//  LJX_ZXViewController.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ZXViewController: UIViewController {
    
    // 点击cell的block
    typealias seleteCellBlock = (LJX_ScheduleModel)->()
    var jumpScore:seleteCellBlock?
    
    var dataArray : Array<Any> = []
    
    var matchesArray : Array<Any> = []
    
    var pageInt = NSInteger()
    
    var currentIndex : NSInteger!
    
    var tableView = UITableView()
    
    var leftBtn = UIButton()
    
    var rightBtn = UIButton()
    
    var isLeftSeleted = Bool()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MobClick.beginLogPageView(SuchedulePage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView(SuchedulePage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
        
        pageInt = 1
        
        isLeftSeleted = true
        
        createUI()
        
        if self.isLeftSeleted == true {
            self.requestScheduleData(isTopRefresh: "0" , baseURL: "\(zjsyBaseURL)number=5&")
        } else {
            self.requestScheduleData(isTopRefresh: "0" , baseURL: "\(zjsyBaseURL)number=7&")
        }
        refreshData()

        bottomRefreshData()
    }
    
    func refreshData() {
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            
            self.dataArray.removeAll()
            self.pageInt = 1
            
            if self.isLeftSeleted == true {
                self.requestScheduleData(isTopRefresh: "0" , baseURL: "\(zjsyBaseURL)number=5&")
            } else {
                self.requestScheduleData(isTopRefresh: "0" , baseURL: "\(zjsyBaseURL)number=7&")
            }
        }
    }
    
    func bottomRefreshData() {
        self.tableView.es.addInfiniteScrolling {
            [unowned self] in
            if self.isLeftSeleted == true {
                self.requestScheduleData(isTopRefresh: "1" , baseURL: "\(zjsyBaseURL)number=5&")
            } else {
                self.requestScheduleData(isTopRefresh: "1" , baseURL: "\(zjsyBaseURL)number=7&")
            }
        }
    }
    
    func requestScheduleData(isTopRefresh : String , baseURL :String) {
        
        if isTopRefresh == "0" {
            self.dataArray.removeAll()
        }
        
        let requestStr = "\(baseURL)game_id=\(String(currentIndex+1))&page=\(String(pageInt))"
        
        print("str = " , requestStr)
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:requestStr, params: nil, header: nil, success: { (data) in
            self.tableView.es.stopPullToRefresh()
            self.tableView.es.stopLoadingMore()

            print("data = ",data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
            
            let dataArray : Array<LJX_ScheduleModel> = LJX_ScheduleModel.mj_objectArray(withKeyValuesArray: resopnse["match_series"]) as! [LJX_ScheduleModel]
            
            if dataArray.count > 0{
                self.dataArray += dataArray
                self.pageInt += 1
            } else {
                self.tableView.es.noticeNoMoreData()
            }
            
            self.tableView.reloadData()
        }) { (error) in
            print(error)
            self.tableView.es.stopPullToRefresh()
            self.tableView.es.stopLoadingMore()
        }
    }
    
    func createUI() {
        
        initTableView()
        
        createTopView()
    }
    
    func initTableView() {
        tableView = UITableView.init()
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:"scheduleCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EAEAEA")

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(50)
            make.bottom.equalTo(-41)
        }
    }
    
    func createTopView () {
        let topView = UIView()
        topView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EBEBEB")
        self.view.addSubview(topView)
        
        leftBtn = UIButton()
        leftBtn.backgroundColor = UIColor.white
        leftBtn.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#3D79FD").cgColor
        leftBtn.layer.borderWidth = 1.0
        leftBtn.layer.cornerRadius = 5.0
        leftBtn.setTitle("赛程", for: UIControl.State.normal)
        leftBtn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#3D79FD"), for: UIControl.State.normal)
        leftBtn.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftBtn.addTarget(self, action: #selector(leftAction), for: UIControl.Event.touchUpInside)
        topView.addSubview(leftBtn)
        
        rightBtn = UIButton()
        rightBtn.backgroundColor = UIColor.white
        rightBtn.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#ABABAB").cgColor
        rightBtn.layer.borderWidth = 1.0
        rightBtn.layer.cornerRadius = 5.0
        rightBtn.setTitle("赛果", for: UIControl.State.normal)
        rightBtn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#ABABAB"), for: UIControl.State.normal)
        rightBtn.setTitleColor(UIColor.green, for: UIControl.State.highlighted)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightBtn.addTarget(self, action: #selector(rightAction), for: UIControl.Event.touchUpInside)
        topView.addSubview(rightBtn)
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(50)
        }
        
        leftBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp_top).offset(10)
            make.centerX.equalTo(topView.snp_centerX).offset(-70)
            make.bottom.equalTo(topView.snp_bottom).offset(-10)
            make.width.equalTo(100)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp_top).offset(10)
            make.bottom.equalTo(topView.snp_bottom).offset(-10)
            make.centerX.equalTo(topView.snp_centerX).offset(70)
            make.width.equalTo(100)
        }
    }
    
    //设置按钮的点击方法
    @objc func leftAction() {
        
        print("您点击的左侧按钮");
        isLeftSeleted = true
        changeBtnColor()
    }

    //设置按钮的点击方法
    @objc func rightAction() {
        isLeftSeleted = false
        print("您点击的右侧按钮");
        changeBtnColor()
    }
    
    func changeBtnColor() {
        /*  赛程 */
        self.pageInt = 1
        self.dataArray.removeAll()

        if isLeftSeleted == true {
            leftBtn.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#3D79FD").cgColor
            leftBtn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#3D79FD"), for: UIControl.State.normal)
            rightBtn.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#ABABAB").cgColor
            rightBtn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#ABABAB"), for: UIControl.State.normal)
            self.requestScheduleData(isTopRefresh: "0",baseURL: scheduleListURL)
        } else {
            /*  赛果*/
            rightBtn.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#3D79FD").cgColor
            rightBtn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#3D79FD"), for: UIControl.State.normal)
            leftBtn.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: "#ABABAB").cgColor
            leftBtn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#ABABAB"), for: UIControl.State.normal)
            self.requestScheduleData(isTopRefresh: "0",baseURL: finalScoresListURL)
        }
    }
}

extension LJX_ZXViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let mas : LJX_ScheduleModel = self.dataArray[section] as! LJX_ScheduleModel

        let arr : Array<LJX_Matches> = mas.matches ?? Array.init()
        
        return arr.count > 0 && self.currentIndex != 3 ? arr.count + 2 : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row == 0 {
            let indentifier = "scheduleCell"
            var scheduleCell:LJX_ScheduleCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_ScheduleCell
            if scheduleCell == nil {
                scheduleCell = LJX_ScheduleCell.init(style: .default, reuseIdentifier: indentifier)
            }
            scheduleCell.selectionStyle = UITableViewCell.SelectionStyle.none
            scheduleCell.scheduleModel = self.dataArray[indexPath.section] as? LJX_ScheduleModel
            return scheduleCell!
        } else {
            let mas : LJX_ScheduleModel = self.dataArray[indexPath.section] as! LJX_ScheduleModel

            if self.currentIndex == 0 {
                let indentifier = "finishCell"
                var finishCell:LJX_FinishCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_FinishCell
                if finishCell == nil {
                    finishCell = LJX_FinishCell.init(style: .default, reuseIdentifier: indentifier)
                }
                finishCell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                finishCell?.showAppInfoWithModel(index: indexPath.row , bigModel:mas , modelArray: mas.matches!)

                return finishCell!
            } else if self.currentIndex == 1 {
                let indentifier = "csCell"
                var csCell:LJX_CSCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_CSCell
                if csCell == nil {
                    csCell = LJX_CSCell.init(style: .default, reuseIdentifier: indentifier)
                }
                csCell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                csCell?.showAppInfoWithModel(index: indexPath.row , bigModel:mas , modelArray: mas.matches!)

                return csCell!
            } else {
                let indentifier = "lolCell"
                var lolCell:LJX_LOLCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_LOLCell
                if lolCell == nil {
                    lolCell = LJX_LOLCell.init(style: .default, reuseIdentifier: indentifier)
                }
                lolCell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                lolCell?.showAppInfoWithModel(index: indexPath.row , bigModel:mas , modelArray: mas.matches!)
                
                return lolCell!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index : NSInteger = indexPath.section
        
        print("index - ",index)
        
        let scheduleModel = self.dataArray[index] as? LJX_ScheduleModel
        
        self.jumpScore!(scheduleModel!)
    }
}
