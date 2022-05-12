//
//  Cacheable.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 09/05/2022.
//

import Foundation

protocol Cacheable: Codable {
    static var cacheName: String { get }
}

enum CacheWhere {
    case cache
    case document
    case userDefault
}

extension Cacheable {
    private static var cachePath: String {
        //NSHomeDirectory()
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return NSHomeDirectory() + "/Library/Caches/\(cacheName)" }
        return "\(path)/\(cacheName)"
    }
    
    private static var documentPath: String {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return NSHomeDirectory() + "/Documents/\(cacheName)" }
        return "\(path)/\(cacheName)"
    }
    
    private static func path(where: CacheWhere) -> String {
        switch `where` {
        case .cache:
            return cachePath
        case .document:
            return documentPath
        case .userDefault:
            return ""
        }
    }
    
    static func loadFromDisk(_ where: CacheWhere = .cache) -> Self? {
        guard !IsCollectionEmpty(cacheName) else { return nil }
        var data: Data? = nil
        switch `where` {
        case .cache, .document:
            data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path(where: `where`)))
        case .userDefault:
            data = UserDefaults.standard.data(forKey: cacheName)
        }
        guard let decodeData = data else { return nil }
        return try? JSONDecoder.init().decode(Self.self, from: decodeData)
    }
    
    static func updateDiskCache(_ cacheModel: Self?, _ where: CacheWhere = .cache) {
        guard !IsCollectionEmpty(cacheName) else { return }
        if let data = cacheModel?.toJSONData() {
            switch `where` {
            case .cache, .document:
                do {
                    try data.write(to: URL.init(fileURLWithPath: path(where: `where`)))
                } catch let exception {
                    print("updateDiskCache write ERROR", exception)
                }
            case .userDefault:
                UserDefaults.standard.set(data, forKey: cacheName)
                UserDefaults.standard.synchronize()
            }
        } else {
            switch `where` {
            case .cache, .document:
                do {
                    try FileManager.default.removeItem(at: URL.init(fileURLWithPath: path(where: `where`)))
                } catch let exception {
                    print("updateDiskCache remove ERROR", exception)
                }
            case .userDefault:
                UserDefaults.standard.set(nil, forKey: cacheName)
                UserDefaults.standard.synchronize()
            }
        }
    }
}
