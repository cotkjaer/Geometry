//
//  VectorTests.swift
//  Geometry
//
//  Created by Christian Otkjær on 26/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Geometry

class VectorTests: XCTestCase
{
    func testExample()
    {
        //===--- Test -------------------------------------------------------------===//
        print(Vector(3.0, tail: EmptyVector()))
        print(3.0 ⋮ 4.0 ⋮ 5.0)
        print( (3.0 ⋮ 4.0 ⋮ 5.0).dotProduct(6.0 ⋮ 7.0 ⋮ 8.0) ) // 86.0
        print((3.0 ⋮ 4.0 ⋮ 5.0) + (6.0 ⋮ 7.0 ⋮ 8.0))
        print(2 * (3.0 ⋮ 4.0 ⋮ 5.0))
        print((3.0 ⋮ 4.0 ⋮ 5.0) / 2)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
