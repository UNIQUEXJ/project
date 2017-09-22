//
//  LJNetTools.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//


import Alamofire
import ObjectMapper
import SwiftyJSON
import MBProgressHUD

let baseURL = "http://www.window18.com/api/"
//let baseURL = "http://139.196.31.161:8025/a/mobileapi/"

struct APIPath {
    static let loginPath = "http://www.window18.com/api/MobileInterface.asmx/Login" // 登录
    static let logout = "Customers/logout" // 登出
    static let companyList = "Customers/GetUsersList" //获取公司列表
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
    func login(_ parameters: [String: Any], complete: @escaping (Bool)->()) {
        guard !(lj_reachability?.lj_isNotNet() ?? false) else {
            MBProgressHUD.lj_showText(text: "请检查网络连接,再尝试")
            complete(false)
            return
        }
        let hud = MBProgressHUD.lj_showNet(text: "登录中...")
        Alamofire.request(APIPath.loginPath, method: .post, parameters: parameters).responseJSON { (response) in
            hud.lj_dismiss()
            switch response.result {
            case .failure:
                MBProgressHUD.lj_showText(text: "登录失败")
                complete(false)
            case .success(let data):
                let json = JSON(data)
                // MARK: 转换字典
                if let user = json.dictionaryObject, let model = Mapper<UserModel>().map(JSON: user), model.success {
                    UserDefaults.standard.lj_setDefaults("sid", value: model.sid ?? "")
                    complete(true)
                }else {
                    if let msg = json["msg"].string {
                        MBProgressHUD.lj_showText(text: msg)
                    }
                    complete(false)
                }
            }
        }
    }
}

