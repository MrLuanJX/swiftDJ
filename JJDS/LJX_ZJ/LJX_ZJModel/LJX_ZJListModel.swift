//
//  LJX_ZJListModel.swift
//  JJDS
//
//  Created by a on 2019/5/22.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ZJListModel: NSObject {

    @objc var ID : String?
    @objc var title : String?
    @objc var share_order : String?
    @objc var unlock_count : String?
    @objc var mosaic : String?
    @objc var created_at : String?
    @objc var expectant_repay : String?
    @objc var result : String?
    @objc var price : String?
    @objc var hot_score : String?
    
    @objc var analystID : String?
    @objc var analystType : String?
    @objc var analystName : String?
    @objc var analystTag : String?
    @objc var analystAvatar : String?
    @objc var analystCombo : String?
    @objc var analystScore : String?
    @objc var analystRecentRed : String?
    @objc var analystRecentRepay : String?
    @objc var analystRedCurrentMonth : String?
    
    @objc var seriesID : String?
    @objc var seriesLeftTag : String?
    @objc var seriesRightTag : String?
    @objc var seriesLeftLogo : String?
    @objc var seriesRightLogo : String?
    @objc var seriesStartTime : String?
    @objc var seriesRound : String?
    @objc var seriesLeagueName : String?
    @objc var seriesGameID : String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable :Any]? {
        return ["ID" :"id" ,
                "analystID" : "analyst.id",
                "analystType" : "analyst.type",
                "analystName" : "analyst.name",
                "analystTag" : "analyst.tag",
                "analystAvatar" : "analyst.avatar",
                "analystCombo" : "analyst.combo",
                "analystScore" : "analyst.score",
                "analystRecentRed" : "analyst.recent_red",
                "analystRecentRepay" : "analyst.recent_repay",
                "analystRedCurrentMonth" : "analyst.red_current_month",
                
                
                "seriesID" : "series.id",
                "seriesLeftTag" : "series.left_tag",
                "seriesRightTag" : "series.right_tag",
                "seriesLeftLogo" : "series.left_logo",
                "seriesRightLogo" : "series.right_logo",
                "seriesStartTime" : "series.start_time",
                "seriesRound" : "series.round",
                "seriesLeagueName" : "series.league_name",
                "seriesGameID" : "series.game_id"
        ]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable :Any]? {
        return ["recommendation_points" :NSStringFromClass(LJX_Recommendation.self)]
    }
}

class LJX_Recommendation : NSObject {
    @objc var type : String?
    @objc var key : String?
    @objc var value : String?
}
