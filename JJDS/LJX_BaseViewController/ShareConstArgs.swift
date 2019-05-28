//
//  ShareConstArgs.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import SnapKit
import MJExtension
import Alamofire

// 友盟AppKey
public let UMAppKey = "5ceb4cfd3fc195c317000400"
// 极光AppKey
public let JGAppKey = "bd608c52a37da61efa9bd4ab"

// 屏幕宽高
public let k_WIDTH = UIScreen.main.bounds.size.width
public let k_HEIGHT = UIScreen.main.bounds.size.height
public let stateheight = UIApplication.shared.statusBarFrame.size.height
public let navHeight = stateheight + 44

//tabbar高度
public let tabBarHeight = (stateheight==44 ? 83 : 49)

public var k_SafeInset : UIEdgeInsets!

public let zjsyBaseURL = "http://39.107.140.222/SpringMVC/electronicSports/getAppPackage.do?"

// banner
public let getHomeBannerURL = "http://grim.ouresports.com/api/banners"
// 新闻首页
public let homeNewsURL = "http://grim.ouresports.com/api/information?"  

public let homeDetailNewsURL = "http://grim.ouresports.com/api/news/"

public let scheduleListURL = "http://api.ouresports.com/api/schedule?"

public let finalScoresListURL = "http://api.ouresports.com/api/v2/final_scores?"

public let seriesListURL = "http://api.ouresports.com/api/bets/series?"

public let scheduleDetailURL = "http://39.107.140.222/SpringMVC/electronicSports/getNumber.do"

// 专家Banner
public let zjBannerURL = "http://api.ouresports.com/api/banners?type=AppBanner"

public let zjHotAnalystsURL = "http://api.ouresports.com/api/circle/hot_analysts"
// 专家- 推荐
public let zjURL = "http://api.ouresports.com/api/v2/circle/hot_recommendations?"



// 友盟页面表示
public let HomePage = "homePage"
public let HomeDetailPage = "HomeDetailPage"
public let SuchedulePage = "SuchedulePage"
public let MinePage = "MinePage"
public let LoginPage = "LoginPage"
public let RegistPage = "RegistPage"
public let SetupPage = "SetupPage"
public let AboutPage = "AboutPage"
