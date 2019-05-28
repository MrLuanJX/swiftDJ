//
//  LJX_ZJCollectionCell.swift
//  JJDS
//
//  Created by a on 2019/5/17.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ZJCollectionCell: UITableViewCell {

    var collectionView : UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EAEAEA")
        
        self.contentView.backgroundColor = UIColor.white
        
        setupUI()
        
        createConstrainte()
    }
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        collectionView = UICollectionView.init(frame: CGRect(x:0, y:0, width:0, height:0), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.red
//        collectionView.delegate = self
//        collectionView.dataSource = self
        self.contentView.addSubview(collectionView!)
    }
    
    func createConstrainte() {
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(100)
            make.bottom.equalTo(self.contentView.snp_bottom)
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
