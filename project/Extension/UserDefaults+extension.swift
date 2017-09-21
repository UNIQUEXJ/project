//
//  UserDefaults+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

extension UserDefaults {
    func lj_setDefaults(_ key: String, value: Any?) {
        set(value, forKey: key)
        synchronize()
    }
    func lj_removeDefaulte(_ key: String) {
        removeObject(forKey: key)
        synchronize()
    }
}
