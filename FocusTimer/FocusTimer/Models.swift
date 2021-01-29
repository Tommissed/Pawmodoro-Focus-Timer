//
//  RandomFact.swift
//  FocusTimer
//

import Foundation

struct RandomFact: Codable {
    var _id: String?
    var __v: Int?
    var user: String?
    var text: String?
    var updatedAt: String?
    var createdAt: String?
    var deleted: Bool?
    var source: Source?
    var status: Status?
    var used: Bool?
    var type: String?
    
    enum Source: String, Codable {
        case user
        case api
        }
    
    struct Status: Codable {
        var verified: Bool?
        var sentCount: Int?
    }
}
