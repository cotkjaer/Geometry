//
//  Size2D.swift
//  Geometry
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

public protocol Size2D : MultiDimensionValue
{
    var width : Scalar { get set }
    var height : Scalar { get set }
    
    init()
    
    init(width: Scalar, height: Scalar)
}

// MARK: - Default

public extension Size2D
{
    init(width: Scalar, height: Scalar)
    {
        self.init()
        
        self.width = width
        self.height = height
    }
    
    func scaled(factor: Scalar) -> Self
    {
        return Self(width: width * factor, height: height * factor)
    }
}

// MARK: - CGSize

extension CGSize : Size2D
{
    public var dimensions : Int { return 2 }
    
    public typealias Scalar = CGFloat
    
    public subscript(index: Int) -> Scalar
        {
        get {
            switch index
            {
            case 0: return width
            case 1: return height
            default: fatalError("index \(index) out of bounds for CGSize")
            }
        }
        set
        {
            switch index
            {
            case 0: width = newValue
            case 1: height = newValue
            default: fatalError("index \(index) out of bounds for CGSize")
            }
        }
    }
}
