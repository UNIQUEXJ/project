//
//  LJNetTools.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import Alamofire
//import ObjectMapper
import SwiftyJSON
import MBProgressHUD

//let baseURL = "http://192.168.1.211:8014/a/mobileapi/"
let baseURL = "http://139.196.31.161:8025/a/mobileapi/"

struct APIPath {
    static let loginPath = "login" // 登录
    static let logout = "logout" // 登出
}
let lj_sid = "JESSIONID"
func lj_getSid() -> String {
    guard let sid = UserDefaults.standard.object(forKey: "sid") as? String else {
        return ""
    }
    return sid
}
class LJNetTools {
    init() {
        
    }
    static var share: LJNetTools {
        struct Static {
            static let instance: LJNetTools = LJNetTools()
        }
        return Static.instance
    }
    func logout() {
        let hud = MBProgressHUD.lj_showNet(text: "")
        Alamofire.request(baseURL + APIPath.logout, method: .get, parameters: [lj_sid: lj_getSid()]).responseJSON { (response) in
            hud.lj_dismiss()
            //            lj_loginView(false)
        }
    }
}
