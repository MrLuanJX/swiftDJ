//
//  LJX_HomeAnalystsModel.swift
//  JJDS
//
//  Created by a on 2019/5/22.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_HomeAnalystsModel: NSObject {
    @objc var name : String?
    @objc var avatar : String?
    @objc var ID : String?
    @objc var type : String?
    @objc var tag : String?
    @objc var descriptionM : String?

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable :Any]? {
        return ["ID" :"id" , "descriptionM" : "description"]
    }
}
