//
//  Mobile_Financial_AppUITests.swift
//  Mobile-Financial-AppUITests
//
//  Created by 55487145 on 2018-02-14.
//  Copyright © 2018 55487145. All rights reserved.
//

import XCTest

class Mobile_Financial_AppUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSignUpValidation() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["SIGN UP"].tap()
        app.buttons["Submit"].tap()
        XCTAssert(app.alerts.element.staticTexts["The password must be 6 characters long or more. Please try again."].exists)
    }
    
    func testLoginValidation() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["LOG IN"].tap()
        XCTAssert(app.alerts.element.staticTexts["The password is invalid or the user does not have a password. Please try again."].exists)
    }
    
//    func testLoginSegue() {
//        isAccessibilityElement = false
//        let app = XCUIApplication()
//        app.launch()
//        app.buttons["LOG IN"].tap()
//        let email = app.textFields["Email"]
//        email.tap()
//        app.typeText("2@2.2")
//        let password = app.textFields["Password"]
//        password.tap()
//        app.typeText("222222")
//    }
}
