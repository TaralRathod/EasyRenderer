//
//  DataModel.swift
//  ImageRenderer
//
//  Created by Taral Rathod on 04/10/20.
//

import Foundation

// MARK:- Codable structure for flicker API response
struct DataModel: Codable {
    var photos: DataModelPhotos?
    var stat: String?
}

// MARK:- Codable structure for Data Model of Photos values
struct DataModelPhotos: Codable {
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: QuantumValue?
    var photo: [PhotoModel]?
}

enum QuantumValue: Codable {
    func encode(to encoder: Encoder) throws {
        
    }
    
    case int(Int), string(String)

    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }

        throw QuantumError.missingValue
    }

    enum QuantumError:Error {
        case missingValue
    }
}

// MARK:- Codable structure for Data Model of Photo Object
struct PhotoModel: Codable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var isPublic: Bool?
    var isFriend: Bool?
    var isFamily: Bool?
}
