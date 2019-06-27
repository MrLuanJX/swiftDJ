//
//  LJX_HomeDetailViewController.swift
//  JJDS
//
//  Created by a on 2019/5/13.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import WisdomHUD

class LJX_HomeDetailViewController: UIViewController {

    var detailModel = LJX_HomeModel()
    
    var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        JANALYTICSService.startLogPageView(HomeDetailPage)
        MobClick.beginLogPageView(HomeDetailPage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView(HomeDetailPage)
        JANALYTICSService.stopLogPageView(HomeDetailPage)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        self.title = "资讯详情"

        requestDetailData()
        
        createUI()
    }
    
    func createUI() {
    
        tableView = UITableView.init()
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.scrollsToTop = true
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:"homeDetailCell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        WisdomHUD.showLoading(text: "正在加载...")
    }
    
    func requestDetailData() {
        
        let requestStr = "\(homeDetailNewsURL)\(String(detailModel.ID ?? ""))"
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:requestStr, params: nil, header: nil, success: { (data) in
           
            WisdomHUD.dismiss()
            
            print("",data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}

            let detailM : LJX_HomeModel = LJX_HomeModel.mj_object(withKeyValues:resopnse["data"])
            
            self.detailModel = detailM
            
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
}

extension LJX_HomeDetailViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//         return Int(self.detailModel.comment_count ?? "") ?? 0 > 0 ? 2 : 1
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "homeDetailCell"
        
        var homeDetailCell:LJX_HomeDetailCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_HomeDetailCell
        
        if homeDetailCell == nil {
            homeDetailCell = LJX_HomeDetailCell.init(style: .default, reuseIdentifier: indentifier)
        }
        
        homeDetailCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        homeDetailCell.cellIndex = indexPath

        homeDetailCell.detailModel = self.detailModel
        
        return homeDetailCell!
    }
}

extension LJX_HomeDetailViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollHeight = tableView.contentOffset.y

        if scrollHeight >= -44 {
            self.title = self.detailModel.title
        } else {
            self.title = "资讯详情"
        }
    }
    
}
