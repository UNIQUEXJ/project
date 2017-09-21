//
//  String+extension.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

extension String {
    
    
    /// 数字格式化成字符串,可以加入逗号啊 之类  字符串为 1234567.89
    /// case none //1234567.89
    
    //    case decimal //1,234,567.89
    //
    //    case currency //￥1,234,567.89
    //
    //    case percent //123,456,789%
    //
    //    case scientific //1.23456789E6
    //
    //    case spellOut //一百二十三万四千五百六十七点八九
    //
    //    @available(iOS 9.0, *)
    //    case ordinal //第123,4568
    //
    //    @available(iOS 9.0, *)
    //    case currencyISOCode //CNY1,234,567.89
    //
    //    @available(iOS 9.0, *)
    //    case currencyPlural//1,234,567.89人民币
    //
    //    @available(iOS 9.0, *)
    //    case currencyAccounting//￥1,234,567.89
    /// - Parameters:
    ///   - number: <#number description#>
    ///   - style: <#style description#>
    /// - Returns: <#return value description#>
    static func lj_formaterStr(_ number: NSNumber, _ style: NumberFormatter.Style) -> String {
        let format = NumberFormatter()
        format.numberStyle = style
        return format.string(from: number) ?? ""
    }
    
    /// 根据字符串内容和宽度获取字符串高度
    func lj_stringContentSize(_ font: UIFont, _ width: CGFloat) -> CGSize {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.paragraphStyle: paragraphStyle.copy()]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size
    }
    
    func lj_stringWidth(_ font: UIFont) -> CGFloat {
        return self.lj_stringSize(font).width
    }
    func lj_stringHeight(_ font: UIFont) -> CGFloat {
        return self.lj_stringSize(font).height
    }
    func lj_stringSize(_ font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedStringKey.font: font])
    }
    
    /// String使用下标截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return String(self[startIndex..<endIndex])
        }
    }
    // MARK: - md5加密
    var lj_md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }
    
    // MARK: - 判断一些是否正确
    /// 是否是手机号码
    var lj_isPhoneNum: Bool {
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$"
        let reg = NSPredicate(format: "SELF MATCHES %@", mobile)
        return reg.evaluate(with: self)
    }
    var lj_isCode: Bool {
        let code = "^[a-z0-9]{4,6}$"
        let reg = NSPredicate(format: "SELF MATCHES %@", code)
        return reg.evaluate(with: self)
    }
    var lj_isPasswrod: Bool {
        let password = "^[A-Za-z0-9_-_@_*_#_$_!]{6,18}$"
        let reg = NSPredicate(format: "SELF MATCHES %@", password)
        return reg.evaluate(with: self)
    }
    
    var lj_isUsername: Bool {
        let username = "^[A-Za-z0-9_-]{3,16}$"
        let reg = NSPredicate(format: "SELF MATCHES %@", username)
        return reg.evaluate(with: self)
    }
    var lj_isEmail: Bool {
        let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let reg = NSPredicate(format: "SELF MATCHES %@", email)
        return reg.evaluate(with: self)
    }
    var lj_isURL: Bool {
        let url = "(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}"
        let reg = NSPredicate(format: "SELF MATCHES %@", url)
        return reg.evaluate(with: self)
    }
    
    // MARK: 根据字符串获取
    func lj_date(_ style: DateFormatterStyle) -> Date {
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = style.rawValue
        return dateFormatter.date(from: self) ?? Date()
    }
    
    // MARK: NSRange与Range互换
    func lj_nsRange(form range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)?.encodedOffset ?? 0
        let to = range.upperBound.samePosition(in: utf16)?.encodedOffset ?? 0
        return NSRange(from..<to)
    }
    func lj_range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    // MARK: 获取字符串首字母
    var lj_Pingyin: String {
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: self)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 转换成大写字母
        let strPinYin = pinyinString.uppercased()
        var firstString = ""
        if strPinYin.count > 0 {
            firstString = strPinYin[0..<1]
        }
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "0"
    }
    
    
}
