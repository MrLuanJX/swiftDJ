//
//  LJX_ScheduleModel.swift
//  JJDS
//
//  Created by a on 2019/5/14.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ScheduleModel: NSObject {

    @objc var ID : String?
    @objc var game_id : String?
    @objc var round : String?
    @objc var league_name : String?
    @objc var start_time : String?
    @objc var status : String?
    @objc var left_score : String?
    @objc var right_score : String?
    @objc var recommendations_count : String?
    @objc var has_bet_topic : String?
    @objc var in_play : String?
    @objc var has_live_match : String?
    @objc var cur_game_no : String?
    @objc var mapData : Array<Any>?
    @objc var left_team_kills : String?
    @objc var right_team_kills : String?
    @objc var left_team_gold : String?
    @objc var right_team_gold : String?
    @objc var left_team_exp : String?
    @objc var right_team_exp : String?
    @objc var left_radiant : String?
    @objc var chat_room_open : String?
    @objc var left_id : String?
    @objc var left_logo : String?
    @objc var left_tag : String?
    @objc var left_extern_id : String?
    @objc var right_id : String?
    @objc var right_logo : String?
    @objc var right_tag : String?
    @objc var right_extern_id : String?
    
    /* 赛果 */
    @objc var matches : Array<LJX_Matches>?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable :Any]? {
        
        return ["ID" : "id",
                "left_team_kills" : "cur_match.left_team_kills",
                "right_team_kills" : "cur_match.right_team_kills",
                "left_team_gold" : "cur_match.left_team_gold",
                "left_team_exp" : "cur_match.left_team_exp",
                "right_team_exp" : "cur_match.right_team_exp",
                "duration" : "cur_match.duration",
                "left_id" : "left_team.id",
                "left_logo" : "left_team.logo",
                "left_tag" : "left_team.tag",
                "left_extern_id" : "left_team.extern_id",
                "right_id" : "right_team.id",
                "right_logo" : "right_team.logo",
                "right_tag" : "right_team.tag",
                "right_extern_id" : "right_team.extern_id"
        ]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable :Any]? {
        return ["map_data" :NSStringFromClass(LJX_MapData.self) , "matches" :NSStringFromClass(LJX_Matches.self)]
    }
}

class LJX_Matches : NSObject {
    @objc var game_no : String?
    @objc var left_team_kills : String?
    @objc var right_team_kills : String?
    @objc var left_team_win : String?
    @objc var duration : String?
    @objc var left_team_first_blood : String?
    @objc var left_team_ten_kills : String?
    
    @objc var first_half_pistol_left_win : String?
    @objc var second_half_pistol_left_win : String?
    @objc var right_score : String?
    @objc var left_score : String?
    @objc var left_team_five_kills : String?
}

class LJX_MapData : NSObject {
    
}


