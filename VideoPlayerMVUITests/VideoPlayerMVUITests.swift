//
//  VideoPlayerMVUITests.swift
//  VideoPlayerMVUITests
//
//  Created by Maxim Vynnyk on 25.05.2023.
//

import XCTest

final class VideoPlayerMVUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        UIView.setAnimationsEnabled(false)
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("Main Screen")
        
        XCUIApplication().navigationBars["Your Videos"]/*@START_MENU_TOKEN@*/.buttons["Import"]/*[[".otherElements[\"Import\"].buttons[\"Import\"]",".buttons[\"Import\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("Imports Screen")
        app.swipeDown(velocity: .fast)

        app.scrollViews
            .children(matching: .other).element(boundBy: 0)
            .children(matching: .other).element
            .children(matching: .image).element(boundBy: 0).tap()
        let videoElement = app.otherElements["Video"]
        snapshot("Video Screen")
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
