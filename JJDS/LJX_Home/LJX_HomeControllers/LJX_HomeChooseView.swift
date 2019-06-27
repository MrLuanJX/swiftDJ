//
//  LJX_HomeChooseView.swift
//  JJDS
//
//  Created by a on 2019/5/29.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import FWPopupView

private let SCREEN_WIDTH = UIScreen.main.bounds.width
private let SCREEN_HEIGHT = UIScreen.main.bounds.height

private let ChannelViewCellIdentifier = "ChannelViewCellIdentifier"
private let ChannelViewHeaderIdentifier = "ChannelViewHeaderIdentifier"

let itemW: CGFloat = (SCREEN_WIDTH - 100) * 0.25

class LJX_HomeChooseView: FWPopupView {

    var resetArray : [String] = []
    var indexPath: IndexPath?
    var targetIndexPath: IndexPath?
    
    // 赋值model
    private var _dataArray : [String]?
    var dataArray : [String]? {
        set {
            _dataArray = newValue
            
            resetArray += dataArray ?? Array.init()
        }
        get {
            return _dataArray
        }
    }
   
    //MARK: - 懒加载collectionView
    private lazy var collectionView: UICollectionView = {
        let clv = UICollectionView(frame: self.frame, collectionViewLayout: ChannelViewLayout())
        clv.backgroundColor = UIColor.green
        clv.delegate = self
        clv.dataSource = self
        clv.register(ChannelViewCell.self, forCellWithReuseIdentifier: ChannelViewCellIdentifier)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
        clv.addGestureRecognizer(longPress)
        
        return clv
    }()
    
    private lazy var dragingItem: ChannelViewCell = {
        let cell = ChannelViewCell(frame: CGRect(x: 0, y: 0, width: itemW, height: itemW * 0.5))
        cell.isHidden = true
        return cell
    }()
    
    //MARK: - 长按动作
    @objc func longPressGesture(_ tap: UILongPressGestureRecognizer) {
        let point = tap.location(in: collectionView)
        
        switch tap.state {
        case UIGestureRecognizerState.began:
            dragBegan(point: point)
        case UIGestureRecognizerState.changed:
            drageChanged(point: point)
        case UIGestureRecognizerState.ended:
            drageEnded(point: point)
        case UIGestureRecognizerState.cancelled:
            drageEnded(point: point)
        default: break
            
        }
    }
    
    //MARK: - 长按开始
    private func dragBegan(point: CGPoint) {
        
        indexPath = collectionView.indexPathForItem(at: point)
        if indexPath == nil {return} // || indexPath?.item == 0  || (indexPath?.section)! > 0
        let item = collectionView.cellForItem(at: indexPath!) as? ChannelViewCell
        item?.isHidden = true
        dragingItem.isHidden = false
        dragingItem.frame = (item?.frame)!
        dragingItem.text = item!.text
        dragingItem.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    //MARK: - 长按过程
    private func drageChanged(point: CGPoint) {
        
        if indexPath == nil  {return}  // || (indexPath?.section)! > 0 || indexPath?.item == 0
        dragingItem.center = point
        targetIndexPath = collectionView.indexPathForItem(at: point)
        if targetIndexPath == nil || (targetIndexPath?.section)! > 0 || indexPath == targetIndexPath  {return}   // || targetIndexPath?.item == 0
        // 更新数据
        let obj = resetArray[indexPath!.item]
        resetArray.remove(at: indexPath!.row)
        resetArray.insert(obj, at: targetIndexPath!.item)
        //交换位置
        collectionView.moveItem(at: indexPath!, to: targetIndexPath!)
        indexPath = targetIndexPath
    }
    
    //MARK: - 长按结束
    private func drageEnded(point: CGPoint) {
        
        if indexPath == nil {return}  //  || (indexPath?.section)! > 0 || indexPath?.item == 0
        let endCell = collectionView.cellForItem(at: indexPath!)

        UIView.animate(withDuration: 0.25, animations: {
            self.dragingItem.transform = CGAffineTransform.identity
            self.dragingItem.center = (endCell?.center)!
        }, completion: {
            (finish) -> () in
            endCell?.isHidden = false
            self.dragingItem.isHidden = true
            self.indexPath = nil
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.red
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI()  {
        self.addSubview(collectionView)
        collectionView.addSubview(dragingItem)
    }
}

//MARK: - UICollectionViewDelegate 方法
extension LJX_HomeChooseView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return resetArray.count > 0 ? resetArray.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectCell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelViewCellIdentifier, for: indexPath) as! ChannelViewCell
        
        collectCell.text = resetArray[indexPath.item] as? String
        
        return collectCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.item)
        
        if indexPath.section > 0 {
            
            // 更新数据
//            let obj = array[indexPath.item]
//            array.remove(at: indexPath.item)
//            array.append(obj)
//            collectionView.moveItem(at: indexPath, to: NSIndexPath(item: array.count - 1, section: 0) as IndexPath)
            
        } else {
            
//            if isEdite {
//
//                if indexPath.item == 0 {return}
//                // 更新数据
//                let obj = array[indexPath.item]
//                array.remove(at: indexPath.item)
//                recommendArr.insert(obj, at: 0)
//                collectionView.moveItem(at: indexPath, to: NSIndexPath(item: 0, section: 1) as IndexPath)
//
//            } else {
//
//                if switchoverCallback != nil {
//
//                    switchoverCallback!(selectedArr, recommendArr, indexPath.item)
//                    _ = navigationController?.popViewController(animated: true)
//                }
//            }
        }
    }
}

//MARK: - 自定义cell
class ChannelViewCell: UICollectionViewCell {
    
    var edite = true {
        didSet {
            imageView.isHidden = !edite
        }
    }
    
    var text: String? {
        
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        contentView.addSubview(label)
        label.addSubview(imageView)
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private lazy var label: UILabel = {
        
        let label = UILabel(frame: self.bounds)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        
        let image = UIImageView(frame: CGRect(x: 2, y: 2, width: 10, height: 10))
        image.image = UIImage(named: "close")
        image.isHidden = true
        return image
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 自定义布局属性
class ChannelViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 40)
        itemSize = CGSize(width: itemW, height: itemW * 0.5)
        minimumLineSpacing = 15
        minimumInteritemSpacing = 20
        sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}
