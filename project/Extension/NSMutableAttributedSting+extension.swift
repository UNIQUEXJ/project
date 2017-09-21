//
//  NSMutableAttributedSting+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

extension NSMutableAttributedString {
    convenience init(searchText search: String, searchColor changeColor: UIColor, string str: String) {
        self.init(string: str)
        guard let range = str.range(of: search) else {
            return
        }
        self.addAttributes([NSAttributedStringKey.foregroundColor: changeColor], range: str.lj_nsRange(form: range))
    }
}

