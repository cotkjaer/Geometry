//
//  AnglesTests.swift
//  Geometry
//
//  Created by Christian Otkjær on 29/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Geometry

class AnglesTests: XCTestCase
{
    func test_degrees2Radians()
    {
        let degrees = 180.0
        
        let radians = degrees2radians(degrees)
        
        XCTAssertEqual(Double.π, radians)
    }
}
