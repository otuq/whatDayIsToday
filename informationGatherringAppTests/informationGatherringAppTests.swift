//
//  informationGatherringAppTests.swift
//  informationGatherringAppTests
//
//  Created by USER on 2021/05/24.
//

import XCTest
@testable import informationGatherringApp

class informationGatherringAppTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        APIRequest.shared.apiRequest(parms: ["titles": "5月26日"]) { (result) in
            
            let pageId = result.query.pages.keys.first
            let result = result.query.pages["pageId!"]?.extract
            print(result)
            XCTAssertNil(result)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
