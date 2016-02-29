//
//  MultiDimensionalValueTests.swift
//  Geometry
//
//  Created by Christian Otkjær on 29/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
import Geometry

/*
struct Point3D : MultiDimensionalValue
{
    static let zero : Point3D = Point3D()
    
    typealias Scalar = Double
    
    var dimensions : Int { return 3 }

    var x : Double
    var y : Double
    var z : Double
    
    subscript(index: Int) -> Double
        {
        get {
            switch index
            {
            case 0: return x
            case 1: return y
            case 2: return z
            default: fatalError("index \(index) out of bounds for  \(self.dynamicType)")
            }
        }
        set
        {
            switch index
            {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: fatalError("index \(index) out of bounds for \(self.dynamicType)")
            }
        }
    }

    
}
*/

// MARK: - Test
/*
struct Point : Point2D
{
    typealias Scalar = Double
    
    static var zero : Point { return Point() }
    
    var x : Double
    var y : Double
    
    subscript(index: Int) ->Double
        {
        get {
            switch index
            {
            case 0: return x
            case 1: return y
            default: fatalError("index \(index) out of bounds for  \(self.dynamicType)")
            }
        }
        set
        {
            switch index
            {
            case 0: x = newValue
            case 1: y = newValue
            default: fatalError("index \(index) out of bounds for \(self.dynamicType)")
            }
        }
    }

}

class MultiDimensionalValueTests: XCTestCase
{
    func test_init()
    {
        let p = Point()
        
        XCTAssertEqual(0, p.x)
        XCTAssertEqual(0, p[0])
        XCTAssertEqual(p.x, p[0])
    }
}
*/