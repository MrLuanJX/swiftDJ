//
//  LJX_ExpertListViewController.swift
//  JJDS
//
//  Created by a on 2019/5/16.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import WisdomHUD

class LJX_ExpertListViewController: UIViewController {
    
    var currentIndex : NSInteger!

    var tableView = UITableView()

    var dataArray : Array<Any> = []
    
    var pageInt = NSInteger()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WisdomHUD.showLoading(text: "正在加载...")
        
        pageInt = 1

        createUI()
        
        refreshData()
        
        bottomRefreshData()
        
        self.requestScheduleData(isTopRefresh: "0" , currentIndex: self.currentIndex)
    }
    
    func refreshData() {
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            
            self.dataArray.removeAll()
            self.pageInt = 1
            
            self.requestScheduleData(isTopRefresh: "0" , currentIndex: self.currentIndex)
        }
    }
    
    func bottomRefreshData() {
        self.tableView.es.addInfiniteScrolling {
            [unowned self] in
            
            self.requestScheduleData(isTopRefresh: "1" , currentIndex: self.currentIndex)
        }
    }
    
    func requestScheduleData(isTopRefresh : String , currentIndex : NSInteger) {
        
        if isTopRefresh == "0" {
            self.dataArray.removeAll()
        }
        
        print("index = ",currentIndex)
        
        let requestStr = currentIndex == 0 ? "\(seriesListURL)page=\(String(pageInt))" : "\(zjsyBaseURL)number=9&game_id=\(String(currentIndex))&page=\(String(pageInt))"
        
        print("str = " , requestStr)
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:requestStr, params: nil, header: nil, success: { (data) in
            WisdomHUD.dismiss()

            self.tableView.es.stopPullToRefresh()
            self.tableView.es.stopLoadingMore()
            
            print("data = ",data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
            
            let dataArray : Array<LJX_ExpertModel> = LJX_ExpertModel.mj_objectArray(withKeyValuesArray: resopnse["match_series"]) as! [LJX_ExpertModel]
            
            if dataArray.count > 0{
                self.dataArray += dataArray
                self.pageInt += 1
            } else {
                self.tableView.es.noticeNoMoreData()
            }
            
            self.tableView.reloadData()
        }) { (error) in
            print(error)
            WisdomHUD.dismiss()

            self.tableView.es.stopPullToRefresh()
            self.tableView.es.stopLoadingMore()
        }
    }
    
    func createUI() {
        
        initTableView()        
    }
    
    func initTableView() {
        tableView = UITableView.init()
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:"expertCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EAEAEA")

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(-41)
        }
    }
}

extension LJX_ExpertListViewController : UITableViewDelegate , UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "expertCell"
        
        var expertCell:LJX_ExpertCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_ExpertCell
        
        if expertCell == nil {
            expertCell = LJX_ExpertCell.init(style: .default, reuseIdentifier: indentifier)
        }
        
        expertCell.selectionStyle = UITableViewCell.SelectionStyle.none

        expertCell.homeModel = self.dataArray[indexPath.row] as? LJX_ExpertModel
                
        return expertCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let homeModel = self.dataArray[indexPath.row] as? LJX_HomeModel
//
//        self.jumpScore!(homeModel!)
    }
}
