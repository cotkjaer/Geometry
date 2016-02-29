//
//  TwoDimensionalValue.swift
//  Geometry
//
//  Created by Christian Otkjær on 29/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

// MARK: - 2D

public protocol TwoDimensionalValue : MultiDimensionalValue
{
    init<T:TwoDimensionalValue where T.Scalar == Scalar>(_ : T)
}

// MARK:  Defaults

extension TwoDimensionalValue
{
    public var dimensions : Int { return 2 }
    
    public init<T:TwoDimensionalValue where T.Scalar == Scalar>(_ other : T)
    {
        self.init(other[0], other[1])
    }
}
