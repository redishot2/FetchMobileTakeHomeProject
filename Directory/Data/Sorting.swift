//
//  Sorting.swift
//  Directory
//
//  Created by Natasha Martinez on 1/11/25.
//

import Foundation

class Sorting {
    
    struct SortType: Identifiable {
        var id: String { description.rawValue }
        let description: SortTypes
        
        enum SortTypes: String {
            case alphabetical
            case cuisine
            
            static var all = [alphabetical, cuisine]
        }
    }
    
    static func sort(by sort: SortType.SortTypes, content: [Recipe]) -> [Recipe] {
        switch sort {
            case .alphabetical:
                return sortAlphabetically(content: content)
            case .cuisine:
                return sortCuisine(content: content)
        }
    }
    
    private static func sortAlphabetically(content: [Recipe]) -> [Recipe] {
        content.sorted(by: { $0.name < $1.name })
    }
    
    private static func sortCuisine(content: [Recipe]) -> [Recipe] {
        content.sorted(by: { $0.cuisine < $1.cuisine })
    }
}
