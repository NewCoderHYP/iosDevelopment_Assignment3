//
//  SPFileManager.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 09/05/2022.
//

import Foundation

struct SPFileManager {
    
    struct FileSize {
        var totalCache: Double?
        var description: String?
    }
    static let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    
    static func size() -> FileSize? {
        guard let path = cachePath else { return nil }
        
        var totalCache = 0.0
        if isDirectory(path) {
            let fileArr = FileManager.default.subpaths(atPath: path) ?? []
            fileArr.forEach { totalCache += fileSize("\(path)/\($0)") }
        } else {
            totalCache = fileSize(path)
        }
        
        var size = FileSize()
        size.totalCache = totalCache
        
        if totalCache > 1024.0 * 1024.0 {
            size.description = String(format: "%.2f MB", totalCache / 1024.0 / 1024.0)
        } else if totalCache > 1024.0 {
            size.description = String(format: "%.2f KB", totalCache / 1024.0)
        } else {
            size.description = String(format: "%.2f B", totalCache)
        }
        return size
    }
    
    
    static func clear() {
        guard let path = cachePath else { return }
        if FileManager.default.fileExists(atPath: path) {
            do { try FileManager.default.removeItem(atPath: path)} catch {}
        }
    }
    
    private static func fileSize(_ path: String?) -> Double {
        var size = 0.0
        guard let path = path else { return size }
        if FileManager.default.fileExists(atPath: path) {
            let attr = try! FileManager.default.attributesOfItem(atPath: path)
            for (key, fileSize) in attr {
                if key == FileAttributeKey.size {
                    size += (fileSize as AnyObject).doubleValue
                }
            }
        }
        return size
    }
    
    private static func isDirectory(_ path: String?) -> Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: path ?? "", isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
}
