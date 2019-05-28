//
//  LJX_HomeViewController.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

/*
 * 00008020-000A1C200C30003A
 */

import UIKit
import ESPullToRefresh
import JCyclePictureView

class LJX_HomeViewController: UIViewController {
    // 点击cell的block
    typealias seleteCellBlock = (LJX_HomeModel)->()
    var jumpScore:seleteCellBlock?
    
    var selectIndex : NSInteger!
    
    var currentIndex : NSInteger!
    
    var homeTableView : UITableView!
    
    var pageInt : NSInteger!
    
    var dataArray : Array<Any> = []
    
    var fArray : Array<Any> = []

    var sArray : Array<Any> = []

    var bannerTitleArray : Array<Any> = []
    
    var bannerImageArray : Array<Any> = []
    
    var scroeArray : Array<Any> = []
    
    var hotAnalysts : Array<Any> = []
    
    lazy var cycleScrollView:WRCycleScrollView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs:nil, descs: nil)
        cycleView.pageControlAliment = .RightBottom
        cycleView.placeholderImage = UIImage.init(named: "DJDS_BGView.jpg")
        cycleView.autoScrollInterval = 3.0
        cycleView.imageContentModel = UIView.ContentMode.scaleToFill

        return cycleView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MobClick.beginLogPageView(HomePage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView(HomePage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageInt = 1
        
        view.backgroundColor = UIColor.white
        
        createUI()
        
        refreshData()
        
        bottomRefreshData()

        datasRequestGroup()

        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTopAction), name: NSNotification.Name(rawValue:"statusBarSelected"), object: nil)
    }
    
    func datasRequestGroup() {  // private
        
        // 创建调度组
        let workingGroup = DispatchGroup()
        // 创建多列
        let workingQueue = DispatchQueue(label: "request_queue")

        // 入组
        workingGroup.enter()
        workingQueue.async {
            self.requestHotAnalysts()
            // 出组
            workingGroup.leave()
        }
        
        // 模拟异步发送网络请求 B
        // 入组
        workingGroup.enter()
        workingQueue.async {
            self.requestData(isTopRefresh: "0")
            // 出组
            workingGroup.leave()
        }
        workingGroup.enter()
        workingQueue.async {
            self.requestScroeData()
            // 出组
            workingGroup.leave()
        }
        // 调度组里的任务都执行完毕
        workingGroup.notify(queue: workingQueue) {
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
            
            self.scroeArray.removeAll()
            self.dataArray.removeAll()
            self.pageInt = 1
            self.requestScroeData()
            self.requestData(isTopRefresh: "0")
        }
    }
    
    func bottomRefreshData() {
        self.homeTableView.es.addInfiniteScrolling {
            [unowned self] in
            self.requestData(isTopRefresh: "1")
        }
    }
    
    // 专家
    func requestHotAnalysts()  {
        
        let requestStr = "\(zjsyBaseURL)number=4&game_id=\(String(currentIndex+1))&page=1&per=3"
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:requestStr, params: nil, header: nil, success: { (data) in
            
            print(data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
            let analystsArray : Array<LJX_HomeAnalystsModel> = LJX_HomeAnalystsModel.mj_objectArray(withKeyValuesArray: resopnse["analysts"]) as! [LJX_HomeAnalystsModel]
            
            if analystsArray.count > 0 {
                self.hotAnalysts += analystsArray
            }
            
            self.homeTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    // 列表
    func requestData(isTopRefresh : String) {
        
        if isTopRefresh == "0" {
            self.dataArray.removeAll()
        }
        
        var num = String()
        switch currentIndex {
        case 0:
            num = pageInt == 1 ? "3" : "3"
        case 1:
            num = pageInt == 1 ? "11" : "3"
        case 2:
            num = pageInt == 1 ? "12" : "3"
        case 3:
            num = pageInt == 1 ? "13" : "3"
        default:
            break
        }
        
        let requestStr = "\(zjsyBaseURL)number=\(String(num))&game_id=\(String(currentIndex+1))&page=\(String(pageInt))&per=\("")"
        
        print("str = " , requestStr)
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:requestStr, params: nil, header: nil, success: { (data) in
            
            self.homeTableView.es.stopPullToRefresh()
            self.homeTableView.es.stopLoadingMore()
            
            print("",data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}

            let dataArray : Array<LJX_HomeModel> = LJX_HomeModel.mj_objectArray(withKeyValuesArray: resopnse["data"]) as! [LJX_HomeModel]   // resopnse["data"]   zjsy (resultDict["data"])
            
            if dataArray.count > 0 {
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
    
    // 比赛
    func requestScroeData() {

        let requestStr = "\(zjsyBaseURL)number=2&game_id=\("")&page=\("")&per=\("")"

        print("str = " , requestStr)
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:requestStr, params: nil, header: nil, success: { (data) in
        
            print("",data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
     
            let dataArray : Array<LJX_HomeCollectModel> = LJX_HomeCollectModel.mj_objectArray(withKeyValuesArray: resopnse["data"]) as! [LJX_HomeCollectModel]   // resopnse["data"]   zjsy (resultDict["data"])
            
            if dataArray.count > 0 {
                self.scroeArray += dataArray
            }
            
            self.homeTableView.reloadData()
            
        }) { (error) in
            print(error)
            self.homeTableView.es.stopPullToRefresh()
            self.homeTableView.es.stopLoadingMore()
        }
    }
    func createUI() {
        
        initHomeTableView()
    }
    
    func initHomeTableView() {
        homeTableView = UITableView.init()
        homeTableView.estimatedRowHeight = 50
        homeTableView.estimatedSectionHeaderHeight = 0;
        homeTableView.estimatedSectionFooterHeight = 0;
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:"homeCell")
        homeTableView.tableFooterView = UIView()
//        homeTableView.tableHeaderView = self.currentIndex == 0 ? tableHeadView() : nil
        
        view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func tableHeadView() -> UIView {
        let homeHeadView = UIImageView()
        homeHeadView.image = UIImage.init(named: "banner.jpg")
        homeHeadView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width/2)
        homeHeadView.contentMode = UIView.ContentMode.scaleAspectFill
        homeHeadView.clipsToBounds = true
        
        return homeHeadView
    }
    
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

extension LJX_HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.dataArray.count + 1//?  currentIndex == 3 ? self.dataArray.count + 1 : self.dataArray.count + 2 : 0   self.dataArray.count > 0 ？
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if  indexPath.row == 0 {
            
            let indentifier = self.currentIndex == 0 ? "matchCell" : "mCell"
            
            var matchCell:LJX_HomeMatchTableCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_HomeMatchTableCell
            if matchCell == nil {
                matchCell = LJX_HomeMatchTableCell.init(style: .default, reuseIdentifier: indentifier)
            }
            matchCell.selectionStyle = UITableViewCell.SelectionStyle.none
            if self.scroeArray.count > 0  {
                matchCell.showAnalystsWithArray(modelArray: self.scroeArray as! Array<LJX_HomeCollectModel>)
            }
            return matchCell!
        }
//        if indexPath.row == 5  && currentIndex != 3 {  // && currentIndex != 0
//            let indentifier = "analyCell"
//            var analyCell:LJX_AnalystsCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_AnalystsCell
//            if analyCell == nil {
//                analyCell = LJX_AnalystsCell.init(style: .default, reuseIdentifier: indentifier)
//            }
//            analyCell.selectionStyle = UITableViewCell.SelectionStyle.none
//            if self.hotAnalysts.count > 0  {
//                analyCell.showAnalystsWithArray(modelArray: self.hotAnalysts as! Array<LJX_HomeAnalystsModel>)
//            }
//            return analyCell!
//        } else {
            let indentifier = "homeCell"
            
            var homeCell:LJX_HomeTableViewCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_HomeTableViewCell
            
            if homeCell == nil {
                homeCell = LJX_HomeTableViewCell.init(style: .default, reuseIdentifier: indentifier)
            }
            
            homeCell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            if self.dataArray.count > 0 {
//                if indexPath.row < 5 || currentIndex == 3 {
                    homeCell.homeModel = self.dataArray[indexPath.row - 1] as? LJX_HomeModel
//                } else {
//                    homeCell.homeModel = self.dataArray[indexPath.row - 2] as? LJX_HomeModel
//                }
            }
                
            return homeCell!
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("-----index ",indexPath.row)

        var index : NSInteger = indexPath.row
        
        index = indexPath.row - 1
      
        if indexPath.row != 0 {
            let homeModel = self.dataArray[index] as? LJX_HomeModel

            self.jumpScore!(homeModel!)
        }
    }
}

class CustomCell: UICollectionViewCell {
    
    let imageView: UIImageView = UIImageView()
    let label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.addSubview(imageView)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

