//
//  DirectoryTests.swift
//  DirectoryTests
//
//  Created by Natasha Martinez on 1/9/25.
//

@testable import Directory
import XCTest

final class DirectoryTests: XCTestCase {
    func testValidURL() async {
        await check(url: Networking.URLs.valid.url, expectedCount: 63)
    }
    
    func testEmptyURL() async {
        await check(url: Networking.URLs.empty.url, expectedCount: 0)
    }
    
    func testBadURL() async {
        await check(url: Networking.URLs.badURL.url, expectedError: Networking.NetworkingError(description: .badURL))
    }
    
    func testMalformedURL() async {
        await check(url: Networking.URLs.malformed.url, expectedError: Networking.NetworkingError(description: .decoding))
    }
    
    func check(url: URL?, expectedError: Networking.NetworkingError? = nil, expectedCount: Int? = nil) async {
        let task = Task { await Networking.fetchData(url: url) }
        
        let result = await task.value
        switch result {
            case .success(let recipes):
                if let expectedCount = expectedCount {
                    XCTAssertEqual(recipes.count, expectedCount)
                } else {
                    XCTFail("Error! Malformed data should not result in successful response")
                }
                
            case .failure(let error):
                if let expectedError = expectedError {
                    XCTAssertEqual(error.displayMessage, expectedError.displayMessage)
                } else {
                    XCTFail("Error! Fetching valid url with error \(error.displayMessage)")
                }
        }
    }
}
