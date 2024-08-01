//
//  VinylData.swift
//  Hack Challenge
//
//  Created by Krishna Patel on 5/5/23.
//

import Foundation

struct VinylData: Codable {
    var id: Int
    var name: String
    var artist: String
    var year: String
    var img: String
    var songs: [String]
    var users: [String]
}

struct returnList: Codable {
    var vinyls: [VinylData]
}
