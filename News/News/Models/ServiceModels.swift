//
//  ServiceModels.swift
//  News
//
//  Created by Admin on 30/06/22.
//
import Foundation

struct ServiceError: Decodable {

    var message: String = ""
    var errorCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case message, errorCode
    }
}
