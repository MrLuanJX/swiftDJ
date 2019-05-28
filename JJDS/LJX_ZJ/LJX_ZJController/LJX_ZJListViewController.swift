//
//  LJX_ZJListViewController.swift
//  JJDS
//
//  Created by a on 2019/5/17.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import JCyclePictureView
import WisdomHUD

class LJX_ZJListViewController: UIViewController {
    
    var currentIndex : NSInteger!

    var homeTableView : UITableView!
    
    var pageInt : NSInteger!
    
    var dataArray : Array<Any> = []
        
    var bannerImageArray : Array<Any> = []
    
    var hotAnalystsArray : Array<Any> = []

    lazy var cycleScrollView:WRCycleScrollView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
        cycleView.pageControlAliment = .RightBottom
        cycleView.autoScrollInterval = 3.0
        return cycleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WisdomHUD.showLoading(text: "正在加载...")

        pageInt = 1
        
        view.backgroundColor = UIColor.white
        
        createUI()
        
        refreshData()
        
        bottomRefreshData()
        
//        requestBanner()
        
//        requestData(isTopRefresh: "0")
        
//        hotAnalysts()
        
        datasRequestGroup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTopAction), name: NSNotification.Name(rawValue:"statusBarSelected"), object: nil)
    }
    
    func datasRequestGroup() {  // private

        // 创建调度组
        let workingGroup = DispatchGroup()
        // 创建多列
        let workingQueue = DispatchQueue(label: "request_queue")
        
        // 模拟异步发送网络请求 A
        // 入组
        workingGroup.enter()
        workingQueue.async {
            
            self.requestBanner()
            
            print("接口 A 数据请求完成")
            // 出组
            workingGroup.leave()
        }
      
        // 模拟异步发送网络请求 A
        // 入组
        workingGroup.enter()
        workingQueue.async {
            
            self.hotAnalysts()
            
            print("接口 A 数据请求完成")
            // 出组
            workingGroup.leave()
        }
      
        // 模拟异步发送网络请求 B
        // 入组
        workingGroup.enter()
        workingQueue.async {
            //                Thread.sleep(forTimeInterval: 1)
            self.requestData(isTopRefresh: "0")
            
            print("接口 B 数据请求完成")
            // 出组
            workingGroup.leave()
        }
        
        print("我是最开始执行的，异步操作里的打印后执行")
        
        // 调度组里的任务都执行完毕
        workingGroup.notify(queue: workingQueue) {
            print("接口 A 和接口 B 的数据请求都已经完毕！, 开始合并两个接口的数据")
            DispatchQueue.main.sync {
                
                self.homeTableView.reloadData()
            }
        }
    }
    
    @objc func scrollToTopAction()  {
        self.homeTableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    func refreshData() {
        self.homeTableView.es.addPullToRefresh {
            [unowned self] in
            
            self.dataArray.removeAll()
            self.pageInt = 1
            
            self.requestData(isTopRefresh: "0")
        }
    }
    
    func bottomRefreshData() {
        self.homeTableView.es.addInfiniteScrolling {
            [unowned self] in
            
            self.requestData(isTopRefresh: "1")
            
        }
    }
    
    // banner图
    func requestBanner()  {
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:zjBannerURL, params: nil, header: nil, success: { (data) in
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
            
            let bannerArray : Array<LJX_ZJBannerModel> = LJX_ZJBannerModel.mj_objectArray(withKeyValuesArray: resopnse["app_banners"]) as! [LJX_ZJBannerModel]
            
            for bannerModel in bannerArray {
                
                self.bannerImageArray.append(bannerModel.full_image_url ?? String())
            }
           
            self.cycleScrollView.serverImgArray = self.bannerImageArray as? [String]
            
//            self.homeTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    // 热门专家
    func hotAnalysts() {
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:zjHotAnalystsURL, params: nil, header: nil, success: { (data) in
            
            print(data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
            
             let dataArray : Array<LJX_HomeAnalystsModel> = LJX_HomeAnalystsModel.mj_objectArray(withKeyValuesArray: resopnse["analysts"]) as! [LJX_HomeAnalystsModel]
            
            if  dataArray.count > 0 {
                self.hotAnalystsArray += dataArray
            }
            
//            self.homeTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    // 列表
    func requestData(isTopRefresh : String) {
        
        if isTopRefresh == "0" {
            self.dataArray.removeAll()
        }
        
        let requestStr = currentIndex == 0 ? "\(zjsyBaseURL)number=8&page=\(String(pageInt))" : "\(zjsyBaseURL)number=8&game_id=\(String(currentIndex))&page=\(String(pageInt))"
        
        print("str = " , requestStr)
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:requestStr, params: nil, header: nil, success: { (data) in
            WisdomHUD.dismiss()

            self.homeTableView.es.stopPullToRefresh()
            self.homeTableView.es.stopLoadingMore()
            
            print("",data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
            
            let dataArray : Array<LJX_ZJListModel> = LJX_ZJListModel.mj_objectArray(withKeyValuesArray: resopnse["data"]) as! [LJX_ZJListModel]
            
            if dataArray.count > 0{
                self.dataArray += dataArray
            } else {
                self.homeTableView.es.noticeNoMoreData()
            }
            
            self.homeTableView.reloadData()
            
            self.pageInt += 1
            
        }) { (error) in
            print(error)
            self.homeTableView.es.stopPullToRefresh()
            self.homeTableView.es.stopLoadingMore()
        }
    }
    
    func createUI() {
        
        initTableView()
    }
    
    func initTableView() {
        homeTableView = UITableView.init(frame: CGRect(x: 0, y:0 , width: view.frame.width, height: view.frame.size.height), style: UITableView.Style.grouped)
        homeTableView.estimatedRowHeight = 50
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.tableFooterView = UIView()
        homeTableView.estimatedSectionHeaderHeight = 0
        homeTableView.estimatedSectionFooterHeight = 0
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView.tableHeaderView = self.currentIndex == 0 ? self.cycleScrollView : nil
        
        if currentIndex != 0 {
            homeTableView.contentInset = UIEdgeInsets.init(top: -40, left: 0, bottom: 0, right: 0)
        }
        
        view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(-41)
        }
    }
    
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

extension LJX_ZJListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currentIndex == 0 ? 2 : 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentIndex == 0 {
            return  section == 0 ? 1 : self.dataArray.count
        } else {
            return self.dataArray.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && currentIndex == 0 {
            let indentifier = "analyCell"
            var analyCell:LJX_AnalystsCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_AnalystsCell
            if analyCell == nil {
                analyCell = LJX_AnalystsCell.init(style: .default, reuseIdentifier: indentifier)
            }
            analyCell.selectionStyle = UITableViewCell.SelectionStyle.none
            if self.hotAnalystsArray.count > 0  {
                analyCell.showAnalystsWithArray(modelArray: self.hotAnalystsArray as! Array<LJX_HomeAnalystsModel>)
            }
            return analyCell!
        } else {
            let indentifier = "zjCell"
            
            var zjCell:LJX_ZJTableViewCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_ZJTableViewCell
            
            if zjCell == nil {
                zjCell = LJX_ZJTableViewCell.init(style: .default, reuseIdentifier: indentifier)
            }
            
            zjCell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            zjCell.zjModel = self.dataArray[indexPath.row] as? LJX_ZJListModel
            
            return zjCell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            let hView = UIView()
            hView.backgroundColor = UIColor.white

            let lineLabel = UILabel.init()
            lineLabel.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#436EEE")
            hView.addSubview(lineLabel)
            
            let careLabel = UILabel.init()
            careLabel.text = "精选推荐"
            careLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#666666")
            careLabel.font = UIFont.systemFont(ofSize: 14)
            hView.addSubview(careLabel)

            lineLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(10)//(grayView.snp_bottom).offset(10)
                make.left.equalTo(0)
                make.width.equalTo(5)
                make.bottom.equalTo(-10)
            }
            
            careLabel.snp.remakeConstraints { (make) in
                make.top.bottom.equalTo(lineLabel)
                make.left.equalTo(lineLabel.snp_right).offset(10)
                make.right.equalTo(-10)
            }
        
            return hView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return  section == 1 ? 40 : 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let homeModel = self.dataArray[indexPath.row] as? LJX_HomeModel
        
    }
}

