//
//  LJCache.swift
//  project
//
//  Created by 刘蒋 on 2017/9/21.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

struct LJCache {
    static func readCacheSize(filePath: String = "/Library/Caches") -> String {
        let cacheFilePath = NSHomeDirectory() + filePath
        let cacheSize = forderSizeAtPath(cacheFilePath)/1024/1024
        return String(format: "%.2f", cacheSize) + "MB"
    }
    
    //遍历所有目录及子目录
    static func forderSizeAtPath(_ folderPath: String) -> Double {
        let manage = FileManager.default
        guard manage.fileExists(atPath: folderPath) else { return 0 }
        let childFilePath = manage.subpaths(atPath: folderPath)!
        var fileSize:Double = 0
        for path in childFilePath {
            let fileAbsoluePath = folderPath + "/" + path
            fileSize += returnFileSize(fileAbsoluePath)
        }
        return fileSize
    }
    
    //处理每个文件路径下文件 —> 大小
    static func returnFileSize(_ path: String) -> Double {
        let manage = FileManager.default
        var fileSize:Double = 0
        do {
            let files = try manage.attributesOfItem(atPath: path)
            fileSize = (files[FileAttributeKey.size] as? Double) ?? 0.0
        } catch {
            print(error)
        }
        return fileSize
    }
    
    
    //MARK: - 清除缓存
    static func cleanCache(_ filePath: String = "/Library/Caches", _ competion:() -> Void = { print("清除完毕") } ) {
        deleteFolder(NSHomeDirectory() + filePath)
        competion()
    }
    
    //删除文件夹的所有文件
    static func deleteFolder(_ folderPath: String) {
        let manage = FileManager.default
        guard manage.fileExists(atPath: folderPath) else { return }
        let childFilePath = manage.subpaths(atPath: folderPath)
        for path in childFilePath! {
            let fileAbsoluePath = folderPath + "/" + path
            deleteFile(fileAbsoluePath)
        }
    }
    
    //删除单个文件
    static func deleteFile(_ path: String) {
        let manage = FileManager.default
        do {
            try manage.removeItem(atPath: path)
        } catch {
            print(error)
        }
    }
}
