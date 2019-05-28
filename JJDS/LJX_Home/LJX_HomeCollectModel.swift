//
//  LJX_HomeCollectModel.swift
//  JJDS
//
//  Created by a on 2019/5/22.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_HomeCollectModel: NSObject {
    
    @objc var right_score : String?
    @objc var league_name : String?
    @objc var has_bet_topic : String?
    @objc var cur_game_no : String?
    @objc var start_time : String?
    @objc var round : String?
    @objc var has_live_match : String?
    @objc var ID : String?
    @objc var game_id : String?
    @objc var status : String?
    @objc var left_score : String?
    
    
    @objc var official_stream_count : String?
    @objc var anchor_stream_count : String?
    
    @objc var curMatchDuration : String?
    @objc var curMatchRightScore : String?
    @objc var curMatchLeftScore : String?
    @objc var curMatchMap : String?

    
    @objc var leftID : String?
    @objc var leftExternID : String?
    @objc var leftTag : String?
    @objc var leftLogo : String?
    
    
    @objc var rightLogo : String?
    @objc var rightID : String?
    @objc var rightTag : String?
    @objc var rightExternID : String?

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable :Any]? {
        return ["ID" :"id" ,
                
                "official_stream_count" : "live_stream_info.official_stream_count",
                "anchor_stream_count" : "live_stream_info.anchor_stream_count",
                
                "curMatchDuration" : "cur_match.duration",
                "curMatchRightScore" : "cur_match.right_score",
                "curMatchLeftScore" : "cur_match.left_score",
                "curMatchMap" : "cur_match.map",
                
                
                "leftID" : "left_team.id",
                "leftExternID" : "left_team.extern_id",
                "leftTag" : "left_team.tag",
                "leftLogo" : "left_team.logo",
                
                "rightLogo" : "right_team.logo",
                "rightID" : "right_team.id",
                "rightTag" : "right_team.tag",
                "rightExternID" : "right_team.extern_id",
        ]
    }
}
