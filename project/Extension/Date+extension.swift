//
//  Date+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

import SwiftDate

enum DateFormatterStyle: String {
    case ymd = "YYYY-MM-dd"
    case ymdHms = "YYYY-MM-dd HH:mm:ss"
    case hms = "HH:mm:ss"
}
let dateFormatter = DateFormatter()

extension Date {
    func lj_string(_ style: DateFormatterStyle) -> String {
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = style.rawValue
        return dateFormatter.string(from: self)
    }
    func lj_double() -> Double {
        return (self + 8.hours).timeIntervalSince1970 * 1000
    }
    // MARK: 实现get方法实现只读属性,
    var lj_currentDateStr: String {
        get {
            return Date().lj_string(.ymdHms)
        }
    }
    // MARK: 每月首日
    var lj_monthStartDate: Date {
        get {
            return self - (self.day - 1).days
        }
    }
    var lj_monthEndDate: Date {
        get {
            return lj_monthStartDate + (monthDays - 1).days
        }
    }
    // MARK: 每周首日
    var lj_weekStartDate: Date {
        get {
            return self - (self.weekday  - 1).days
        }
    }
    var lj_weekEndDate: Date {
        get {
            return lj_weekStartDate + 6.days
        }
    }
}
