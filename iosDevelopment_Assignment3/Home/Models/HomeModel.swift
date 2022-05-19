//
//  HomeModel.swift
//  iosDevelopment_Assignment3
//
//  Created by Yinpeng on 12/05/2022.
//

import Foundation

struct HomeListModel: Codable {
    var restaurantId: Int = 0
    var image: String?
    var introduction: String?
    var name: String?
    var distance: String?
    var seats: [String]?

}

struct SeatModel: Codable {
    var restaurantId: Int = 0
    var name: String?
    var image: String?
    var seat: String?
}

struct HomeListResponse: Codable {
    var list:[HomeListModel]?
}

