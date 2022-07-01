//
//  NewsTests.swift
//  NewsTests
//
//  Created by Admin on 30/06/22.
//

import XCTest
@testable import News

class NewsTests: XCTestCase {

    var viewController: HomeViewController!

    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Step 2. Instantiate UIViewController with Storyboard ID
        viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        // Step 3. Make the viewDidLoad() execute.
        viewController.loadViewIfNeeded()
    }
    
    func testVariables() {
        XCTAssertNil(viewController.mostPapularNews)
    }
    
    func testTableView() {
        XCTAssertEqual(viewController.numberOfSections(in: viewController.newsTableView), 2)
        XCTAssertEqual(viewController.tableView(viewController.newsTableView, numberOfRowsInSection: 0), 1)
    }
    
    func testAPI() {
        XCTAssertEqual(viewController.numberOfSections(in: viewController.newsTableView), 2)
        let newsExpectation = expectation(description: "news")
        ServiceAPI.getInstance().getMostPapularNews(url: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=KAAY7wAjsXKlTUpWlLpfs80BRs3dktnN") { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                UIUtils.showDefaultAlertView(withTitle: "ALERT", message: error.message)
            } else if let mostPapularNews = result {
                self.viewController.mostPapularNews = mostPapularNews
                newsExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(self.viewController.mostPapularNews)
        }
        
    }
    
    
}
