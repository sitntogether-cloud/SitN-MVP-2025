//
//  AuthenticationUITests.swift
//  SitNUITests
//
//  Created by Gilbert Colón on 8/2/25.
//

import XCTest

final class AuthenticationUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testSignInButtonExists() throws {
        let app = XCUIApplication()
        app.launch()

        let signInButton = app.buttons["Sign In"]
        XCTAssert(signInButton.exists)
    }
    
    @MainActor
    func testNavigateToSignUp() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["Sign up"].tap()
        
        XCTAssert(app.staticTexts["Create Account"].exists)
    }
}