//
//  LJX_HomeMatchTableCell.swift
//  JJDS
//
//  Created by a on 2019/5/21.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_HomeMatchTableCell: UITableViewCell {
    
    var idenStr = String()
    
    var careLabel = UILabel()

    var lineLabel = UILabel()
    
    var collDataArray : Array<Any> = []

    var _collectionView : UICollectionView?
    var collectionView : UICollectionView? {
        set {
            _collectionView = newValue
        }
        get {
            return _collectionView
        }
    }
    
    func showAnalystsWithArray ( modelArray : Array<LJX_HomeCollectModel>) {
        
        self.collDataArray = modelArray
        
        self.collectionView?.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setupUI()
        
        createConstrainte()
        
        idenStr = reuseIdentifier ?? String()
        
        if reuseIdentifier == "mCell" {
            self.backgroundColor = UIColor.white
            careLabel.text = "热门比赛"
            lineLabel.isHidden = false
        } else {
            self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EDEDED")
            careLabel.text = "下午好！今日共有20场重要比赛"
            lineLabel.isHidden = true
        }
    }
    
    func setupUI()  {
        
        lineLabel = UILabel.init()
        lineLabel.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#436EEE")
        lineLabel.isHidden = true
        self.contentView.addSubview(lineLabel)
        
        careLabel = UILabel.init()
        careLabel.text = "下午好！今日共有20场重要比赛"
        careLabel.textColor = UIColor.hexadecimalColor(hexadecimal: "#666666")
        careLabel.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(careLabel)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 70)/2, height: 100)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 20, bottom: 5, right: 20)

        collectionView = UICollectionView.init(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:140), collectionViewLayout: layout)
        collectionView?.backgroundColor = self.backgroundColor//UIColor.gray
        collectionView?.register(LJX_HomeCollectionCell.self, forCellWithReuseIdentifier: "collectionCell")

        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(collectionView!)
    }
    
    func createConstrainte()  {
        self.contentView.snp.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        careLabel.snp.remakeConstraints { (make) in
            make.top.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
        }
        
        collectionView?.snp.remakeConstraints { (make) in
            make.top.equalTo(careLabel.snp_bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(120)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
        
        lineLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(5)
            make.top.equalTo(15)
            make.height.equalTo(20)
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


extension LJX_HomeMatchTableCell : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.collDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:LJX_HomeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! LJX_HomeCollectionCell
      
        cell.collModel = self.collDataArray[indexPath.row] as? LJX_HomeCollectModel

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var headview = TSMHomeTopCollectionReusable();
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            headview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEAD_ID, for: indexPath as IndexPath) as! TSMHomeTopCollectionReusable;
        }
        return headview;
    }

    //每个分区区头尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize (width: UIScreen.main.bounds.size.width, height: 40)
    }
    */
    
    func armColor()->UIColor{
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


class TSMHomeTopCollectionReusable: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height));
        
        label.text = "标题";
        
        self.addSubview(label);
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder) has not been implemented")
    }
}
