//
//  Networking.swift
//  Directory
//
//  Created by Natasha Martinez on 1/9/25.
//

import Combine
import Foundation

class Networking: ObservableObject {
    static func fetchData(url: URL?) async -> Result<[Recipe], NetworkingError> {
        guard let url = url else {
            return .failure(NetworkingError(description: .badURL))
        }
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(NetworkingError(description: .badResponse))
            }
            
            if let directory = try? JSONDecoder().decode(Directory.self, from: data) {
                return .success(directory.recipes)
            } else {
                return .failure(NetworkingError(description: .decoding))
            }
        } catch(let error) {
            guard let urlError = error as? URLError else {
                return .failure(NetworkingError(description: .badResponse))
            }
            
            switch urlError.code {
                case URLError.unsupportedURL:
                    return .failure(NetworkingError(description: .badURL))
                    
                default:
                    return .failure(NetworkingError(description: .badResponse))
            }
        }
    }
}

extension Networking {
    struct URLInfo: Hashable {
        let name: String
        let url: URL?
        
        init(name: String, url: String) {
            self.name = name
            self.url = URL(string: url)
        }
    }
    
    enum URLs {
        static let valid = URLInfo(name: "Valid", url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        static let malformed = URLInfo(name: "Malformed", url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        static let empty = URLInfo(name: "Empty", url: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        static let badURL = URLInfo(name: "Bad URL", url: "not a url")
        
        static var all = [valid, malformed, empty, badURL]
    }
    
    struct NetworkingError: Identifiable, Error {
        enum ErrorDescription: String {
            case emptyURL = "No content found."
            case badURL = "The URL provided is not valid."
            case decoding = "There was a problem decoding the returned JSON."
            case badResponse = "Something appears to be wrong with the API."
        }
        
        var id: String { description.rawValue }
        private let description: ErrorDescription
        private let genericStatement = "Try again in a few minutes or select a new URL from the dropdown list in the top right corner. Our appologies for the inconvenience."
        
        var displayMessage: String {
            return description.rawValue + " " + genericStatement
        }
        
        init(description: ErrorDescription) {
            self.description = description
        }
    }
}
