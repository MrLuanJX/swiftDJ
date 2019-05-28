//
//  LJX_ExpertModel.swift
//  JJDS
//
//  Created by a on 2019/5/16.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_ExpertModel: NSObject {
    
    @objc var ID : String?
    @objc var round : String?
    @objc var left_score : String?
    @objc var right_score : String?
    @objc var game_id : String?
    @objc var start_time : String?
    @objc var status : String?
    @objc var league_name : String?
    @objc var in_play : String?
    @objc var bet_topic_count : String?

    @objc var leftTeamID : String?
    @objc var leftTeamTag : String?
    @objc var leftTeamLogo : String?
    @objc var leftTeamExternID : String?

    @objc var rightTeamID : String?
    @objc var rightTeamTag : String?
    @objc var rightTeamLogo : String?
    @objc var rightTeamExternID : String?
    
    @objc var mainBetTopicID : String?
    @objc var mainBetTopicLeftOdd : String?
    @objc var mainBetTopicRightOdd : String?
    @objc var mainBetTopicStatus : String?
    @objc var mainBetTopicInPlay : String?

    @objc var mainBetTopicType : String?
    @objc var mainBetTopicGameNo : String?
    @objc var mainBetTopicKey : String?
    @objc var mainBetTopicValue : String?
    @objc var mainBetTopicGameID : String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable :Any]? {
        return ["ID" :"id" ,
                "leftTeamID" : "left_team.id",
                "leftTeamTag" : "left_team.tag",
                "leftTeamLogo" : "left_team.logo",
                "leftTeamExternID" : "left_team.extern_id",
                "rightTeamID" : "right_team.id",
                "rightTeamTag" : "right_team.tag",
                "rightTeamLogo" : "right_team.logo",
                "rightTeamExternID" : "right_team.extern_id",
                "mainBetTopicID" : "main_bet_topic.id",
                "mainBetTopicLeftOdd" : "main_bet_topic.left_odd",
                "mainBetTopicRightOdd" : "main_bet_topic.right_odd",
                "mainBetTopicStatus" : "main_bet_topic.status",
                "mainBetTopicInPlay" : "main_bet_topic.in_play",
                
                "mainBetTopicType" : "main_bet_topic.topic.type",
                "mainBetTopicGameNo" : "main_bet_topic.topic.game_no",
                "mainBetTopicKey" : "main_bet_topic.topic.key",
                "mainBetTopicValue" : "main_bet_topic.topic.value",
                "mainBetTopicGameID" : "main_bet_topic.topic.game_id"
        ]
    }
}
