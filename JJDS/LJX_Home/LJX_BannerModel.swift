//
//  LJX_BannerModel.swift
//  JJDS
//
//  Created by a on 2019/5/17.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_BannerModel: NSObject {
    @objc var cover_image : String?
    @objc var redirect_url : String?
    @objc var ID : String?
    @objc var type : String?
    @objc var title : String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable :Any]? {
        return ["ID" :"resource.id" , "type" : "resource.type"]
    }

}
