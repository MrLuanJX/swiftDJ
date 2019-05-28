//
//  LJX_HomeModel.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_HomeModel: NSObject {
    
    @objc var browse_count : String?
    
    @objc var comment_count : String?           // 评论数
    
    @objc var cover_image : String?             // 缩略图
    
    @objc var created_at : String?              // 创建时间
    
    @objc var game_id : String?

    @objc var ID : String?                      // 新闻ID

    @objc var news_count : String?

    @objc var sticky : String?

    @objc var sub_title : String?

    @objc var sub_type : String?                // 类型
    
    @objc var tag_name : String?                // 类型名称

    @objc var title : String?                   // 标题

    @objc var type : String?                    // 类型
    
    @objc var content : String?                 // 详情——web
    
    @objc var source : String?                  // 来源

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable :Any]? {
        return ["ID" :"id"]
        
    }
}


