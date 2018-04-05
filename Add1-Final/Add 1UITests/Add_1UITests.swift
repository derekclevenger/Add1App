//
//  Add_1UITests.swift
//  Add 1UITests
//
//

import XCTest

class Add_1UITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Enter invalid number, score should change to negative one.
    func testNegativeScore(){
        let app = XCUIApplication()
        
        let scoreElement = app.staticTexts.element(boundBy: 0)
        let textFieldElement = app.textFields.element(boundBy: 0)
        
        XCTAssertTrue(scoreElement.label == "0", "Score should be 0 at beginning")
        XCTAssertTrue(textFieldElement.label == "", "Textfield should be blank")
        
        // enter 1111 in the textfield
        textFieldElement.tap()
        textFieldElement.typeText("1111")
        
        // wait for score to change
        let predicate = NSPredicate(format: "label != 0")
        let expectations = XCTNSPredicateExpectation(predicate: predicate, object: scoreElement)
        
        let result = XCTWaiter().wait(for: [expectations], timeout: 3)
        
        XCTAssertTrue(scoreElement.label == "-1", "Score label should have negative value")
    }
    
    func testPositiveScore(){
        
        let app = XCUIApplication()
        
        let scoreElement = app.staticTexts["score"]
        let textFieldElement = app.textFields["inputBox"]
        let numberElement = app.staticTexts["number"]
        
        let originalNumber = numberElement.label
        let origNumberAsInt = Int(originalNumber)! + 1111
        
        textFieldElement.tap()
        textFieldElement.typeText("\(origNumberAsInt)")
        
        let predicate = NSPredicate(format: "label != 0")
        let expectations = XCTNSPredicateExpectation(predicate: predicate, object: scoreElement)
        
        XCTWaiter().wait(for: [expectations], timeout: 2)
        XCTAssertTrue(scoreElement.label == "1", "Score label should have a positive value")
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.staticTexts.element(boundBy: 0).tap()
        app.staticTexts.element(boundBy: 1).tap()
        app.staticTexts.element(boundBy: 2).tap()
        app.otherElements.children(matching: .textField).element.tap()
        app.otherElements.containing(.image, identifier:"background").children(matching: .textField).element.typeText("2222")
        
        
        let timeUpAlert = XCUIApplication().alerts["Time Up!"]
        let predicate = NSPredicate(format: "exists == true")
        let expection = XCTNSPredicateExpectation(predicate: predicate, object: timeUpAlert)
        
        let result = XCTWaiter().wait(for: [expection], timeout: 20)
        XCTAssertTrue(result == .completed, "We expected the alert popup to appear by now.")
        
        
    }
    
    func testNothing(){
        
        let timeUpAlert = XCUIApplication().alerts["Time Up!"]
        timeUpAlert.staticTexts["Time Up!"].tap()
        timeUpAlert.staticTexts["Your time is up! You got a score of: -1 points. Very good!"].tap()
        timeUpAlert.buttons["Restart"].tap()
        
    }
    
}
