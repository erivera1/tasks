//
//  TechnicalExamTests.swift
//  TechnicalExamTests
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import XCTest

@testable import TechnicalExam
class TechnicalExamTests: XCTestCase {

    func testTask(){
        let task = Task()
        task.id = UUID()
        task.description = "this is a test"
        task.status = false
        XCTAssertEqual("this is a test", task.description)
    }

}
