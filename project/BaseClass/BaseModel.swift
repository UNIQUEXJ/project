//
//  BaseModel.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import ObjectMapper

class BaseModel: BaseObject {
    var success = false
    var errorCode: String?
    var msg: String?
    override func mapping(map: Map) {
        success <- map["success"]
        errorCode <- map["errorCode"]
        msg <- map["msg"]
    }
}

class UserModel: BaseObject {
    var msg: String?
    var success = false
    var sid: String?
    override func mapping(map: Map) {
        msg <- map["msg"]
        success <- map["result"]
        sid <- map["EmpGuid"]
    }
    
}
class UserDetailModel: BaseObject {
    
    var sid: String?
    var name: String?
    var username: String?
    
    override func mapping(map: Map) {
        name <- map["name"]
        sid <- map["JSESSIONID"]
        username <- map["username"]
    }
}
