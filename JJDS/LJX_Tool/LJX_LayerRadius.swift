//
//  LJX_LayerRadius.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_LayerRadius: NSObject {
    
    
}

extension LJX_LayerRadius {
    //MARK: 设置某个圆角
    class func configSideRadius(iv: UIView, width:CGFloat ,height:CGFloat) { // -> UIView
        //MARK: 设置阴影，圆角，一定要根据 屏幕的尺寸/self的bounds 设定；不能使用自身尺寸
        let bounds = CGRect.init(x: 0, y: 0, width: iv.bounds.width , height: iv.bounds.height)
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight,.bottomLeft,.bottomRight], cornerRadii: CGSize(width: width, height: height))
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = maskPath.cgPath
        iv.layer.mask = maskLayer        
    }
}

extension LJX_LayerRadius {
    
    class func dateConvertString(date:Date, dateFormat:String) -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date  //.components(separatedBy: " ").first!
    }
}

extension LJX_LayerRadius {
    //MARK: Gradient
    class func gradientColor(view : UIView , _ colors:[CGColor]) {
        let gradientColor = CAGradientLayer()
        gradientColor.frame = view.bounds
        gradientColor.colors = colors
        //设置渲染的起始结束位置（纵向渐变）
        gradientColor.startPoint = CGPoint(x: 0, y: 1)
        gradientColor.endPoint = CGPoint(x: 1, y: 0)
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.3, 0.7]
        gradientColor.locations = gradientLocations
        view.layer.addSublayer(gradientColor)
    }
}

extension LJX_LayerRadius {
    //value 是AnyObject类型是因为有可能所传的值不是String类型，有可能是其他任意的类型。
   class func DYStringIsEmpty(value: AnyObject?) -> Bool {
        //首先判断是否为nil
        if (nil == value) {
            //对象是nil，直接认为是空串
            return true
        }else{
            //然后是否可以转化为String
            if let myValue  = value as? String{
                //然后对String做判断
                return myValue == "" || myValue == "(null)" || 0 == myValue.count
            }else{
                //字符串都不是，直接认为是空串
                return true
            }
        }
    }
}

extension LJX_LayerRadius {
    class func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
}
