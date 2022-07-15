//
//  whatDayIsTodayTests.swift
//  whatDayIsTodayTests
//
//  Created by USER on 2022/07/05.
//

import XCTest
@testable import whatDayIsToday
class whatDayIsTodayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // APIのnilチェック
    func testAPIRequest() throws {
        var article: [String]?
        let item = URLQueryItem(name: "titles", value: "1月1日")
        APIRequestURLSession.shared.apiRequest(item: item) { result in
            guard let pageId = result.query.pages.keys.first,
                  let resultArticle = result.query.pages[pageId]?.extract else { return }
            var resultArray = resultArticle.components(separatedBy: "\n")
            resultArray = resultArray.map { $0.trimmingCharacters(in: .whitespaces) }
            resultArray = resultArray.filter { !($0.isEmpty) && !($0.hasPrefix("===")) }
            resultArray = resultArray.map {
                var result = $0
                if let range = $0.range(of: "*") {
                    result.removeSubrange(range)
                }
                return result
            }
            article = resultArray
        }
        XCTAssertNil(article)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
