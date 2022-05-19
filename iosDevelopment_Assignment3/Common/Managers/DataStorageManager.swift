//
//  DataStorageManager.swift
//  ChargeAccount
//
//  Created by Yinpeng on 16/05/2022.
//

import Foundation

struct DataStorageManager: Codable {
    
    // Enum for data error
    enum DataError: Error {
        case dataNotFound
        case dataNotSaved
    }
    
    // Store Data
   static func storeSeat(seats: [SeatModel]) throws {
        let data = try JSONEncoder().encode(seats)
        UserDefaults.standard.set(data, forKey: "kBookingSeatList")
        UserDefaults.standard.synchronize()
    }
    
    // Read Write Data
    static func readSeatModels() throws -> [SeatModel] {
        guard let data = UserDefaults.standard.data(forKey: "kBookingSeatList") else { return [] }
        if let seatModels = try? JSONDecoder().decode([SeatModel].self, from: data) {
            return seatModels
        }
        
        throw DataError.dataNotFound
    }
    
}
