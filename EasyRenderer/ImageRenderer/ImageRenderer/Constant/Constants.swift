//
//  Constants.swift
//  ImageRenderer
//
//  Created by Taral Rathod on 04/10/20.
//

import Foundation

struct NetworkConstants {
    static let baseURL = "https://www.flickr.com/services/rest/?method=%@&api_key=%@&format=json&nojsoncallback=1"
    static let photosBaseURL = "https://live.staticflickr.com/"
}

enum FlickerMethods: String {
    case getRecents = "flickr.photos.getRecent"
    case search = "flickr.photos.search"
}

struct FlickerConstants {
    static let apiKey = "2df4f5f111086c3e2d33f31fbc1a65f4"
    static let secret = "89b144bddd03be28"
}

struct StringKey {
    static let slash = "/"
    static let underScore = "_"
    static let jpg = ".jpg"
    static let sizeQ = "q"
}
