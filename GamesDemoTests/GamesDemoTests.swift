//
//  GamesDemoTests.swift
//  GamesDemoTests
//
//  Created by Ahmed Hosny Sayed on 9/21/21.
//  Copyright © 2021 ispha. All rights reserved.
//

import XCTest

class GamesDemoTests: XCTestCase {

	var gamesVc : GamesListViewController!
	override func setUp() {
		super.setUp()
		let controller = GamesListViewController(nibName: "GamesListViewController", bundle: nil)
		gamesVc = controller
	}
	override func setUpWithError() throws {


		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	func testEmptyState()
	{

		gamesVc.addPrefetchFeature()
		XCTAssert(gamesVc.arrayOfGames.count == 0, "No data found!")
	}
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
