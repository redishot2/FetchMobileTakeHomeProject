//
//  Recipes.swift
//  Directory
//
//  Created by Natasha Martinez on 1/9/25.
//

import Foundation

struct Directory: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Hashable {
    let cuisine: String
    let name: String
    let photo_url_large: String?
    let photo_url_small: String?
    let uuid: String
    let source_url: String?
    let youtube_url: String?
}
