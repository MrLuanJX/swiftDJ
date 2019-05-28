//
//  LJX_ZJListViewController.swift
//  JJDS
//
//  Created by a on 2019/5/17.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import JCyclePictureView

class LJX_ZJListViewController: UIViewController {
    
    var currentIndex : NSInteger!

    var homeTableView : UITableView!
    
    var pageInt : NSInteger!
    
    var dataArray : Array<Any> = []
        
    var bannerImageArray : Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageInt = 1
        
        view.backgroundColor = UIColor.white
        
        createUI()
        
        refreshData()
        
        bottomRefreshData()
        
        requestBanner()
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

    func bannerView() -> UIView {
        
        let cyclePictureView : JCyclePictureView = JCyclePictureView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), pictures: self.bannerImageArray as? [String])
        // 滚动方向
        cyclePictureView.direction = .left
        // 自动滚动时间
        cyclePictureView.autoScrollDelay = 5
        // 标题
        cyclePictureView.titles = Array.init()
        // 点击回调
        cyclePictureView.didTapAtIndexHandle = { index in
            print("点击了第 \(index + 1) 张图片")
        }
        // 自定义 cell
        cyclePictureView.register([CustomCell.self], identifiers: ["CustomCell"]) { (collectionView, indexPath, picture) -> UICollectionViewCell in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
            
            if picture.hasPrefix("http") {
                cell.imageView.kf.setImage(with: URL(string: picture), placeholder: nil)
            } else {
                cell.imageView.image = UIImage(named: picture)
            }
            cell.label.text = ""
            cell.label.textColor = UIColor.white
            return cell
        }
        return cyclePictureView
    }

    // banner图
    func requestBanner()  {
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:zjBannerURL, params: nil, header: nil, success: { (data) in
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
            
            let bannerArray : Array<LJX_BannerModel> = LJX_BannerModel.mj_objectArray(withKeyValuesArray: resopnse["data"]) as! [LJX_BannerModel]
            
            for bannerModel in bannerArray {
                
                self.bannerImageArray.append(bannerModel.cover_image ?? String())
            }
            
            self.homeTableView.tableHeaderView = self.currentIndex == 0 ? self.bannerView() : UIView.init()            
        }) { (error) in
            print(error)
        }
    }
    
    // 列表
    func requestData(isTopRefresh : String) {
        
        if isTopRefresh == "0" {
            self.dataArray.removeAll()
        }
        
        let requestStr = "\(homeNewsURL)game_id=\(String(currentIndex+1))&page=\(String(pageInt))"
        
        print("str = " , requestStr)
        
        LJXRequestSwiftTool.shareInstance.getRequest(urlString:requestStr, params: nil, header: nil, success: { (data) in
            self.homeTableView.es.stopPullToRefresh()
            self.homeTableView.es.stopLoadingMore()
            
            print("",data)
            
            guard let resopnse = data as? Dictionary<String, Any> else {return}
            
            let dataArray : Array<LJX_HomeModel> = LJX_HomeModel.mj_objectArray(withKeyValuesArray: resopnse["data"]) as! [LJX_HomeModel]
            
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
        homeTableView = UITableView.init()
        homeTableView.estimatedRowHeight = 50
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:"homeCell")
        homeTableView.tableFooterView = UIView()
        
        view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(-tabBarHeight)
        }
    }
}

extension LJX_ZJListViewController : UITableViewDelegate , UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "homeCell"
        
        var homeCell:LJX_HomeTableViewCell! = tableView.dequeueReusableCell(withIdentifier:indentifier) as? LJX_HomeTableViewCell
        
        if homeCell == nil {
            homeCell = LJX_HomeTableViewCell.init(style: .default, reuseIdentifier: indentifier)
        }
        
        homeCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        homeCell.homeModel = self.dataArray[indexPath.row] as? LJX_HomeModel
        
        return homeCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let homeModel = self.dataArray[indexPath.row] as? LJX_HomeModel
        
    }
}

