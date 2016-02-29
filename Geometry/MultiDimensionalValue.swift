//
//  Scalable.swift
//  Geometry
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

public protocol MultiDimensionalValue: Addable, Subtractable, Equatable, CollectionType
{
    typealias Scalar : FloatingPointArithmeticType
    
    var dimensions : Int { get }
    
    subscript(_ :Int) -> Scalar { get set }
    
    func * (_: Self, _: Scalar) -> Self
    func * (_: Scalar, _: Self) -> Self
    func *= (inout _: Self, _: Scalar)

    func / (_: Self, _: Scalar) -> Self
    func /= (inout _: Self, _: Scalar)
    
//    func + <M: MultiDimensionalValue where M.Scalar == Scalar>(_: Self, _: M) -> Self
    func += <M: MultiDimensionalValue where M.Scalar == Scalar>(inout _: Self, _: M)
    
//    func - <M: MultiDimensionalValue where M.Scalar == Scalar>(_: Self, _: M) -> Self
    func -= <M: MultiDimensionalValue where M.Scalar == Scalar>(inout _: Self, _: M)
    
    init(_ : Scalar...)
}

// MARK: - Defaults

extension MultiDimensionalValue
{
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return dimensions }
    
    public init(_ scalars: Scalar...)
    {
        self.init()
        
        for i in 0..<scalars.endIndex
        {
            self[i] = scalars[i]
        }
    }
}

// MARK: - Operators

public func * <F: MultiDimensionalValue> (lhs: F.Scalar, rhs: F) -> F
{
    return rhs * lhs
}

public func * <F: MultiDimensionalValue> (lhs: F, rhs: F.Scalar) -> F
{
    var f = lhs
    
    for i in 0..<f.dimensions
    {
        f[i] *= rhs
    }
    
    return f
}

public func *= <F: MultiDimensionalValue> (inout lhs: F, rhs: F.Scalar)
{
    lhs = lhs * rhs
}

public func / <F: MultiDimensionalValue> (lhs: F, rhs: F.Scalar) -> F
{
    var f = lhs
    
    for i in 0..<f.dimensions
    {
        f[i] /= rhs
    }
    
    return f
}

public func /= <F: MultiDimensionalValue> (inout lhs: F, rhs: F.Scalar)
{
    lhs = lhs / rhs
}

public prefix func + <F: MultiDimensionalValue> (lhs: F) -> F
{
    return lhs
}

public func + <M1: MultiDimensionalValue, M2: MultiDimensionalValue where M1.Scalar == M2.Scalar>(lhs: M1, rhs: M2) -> M1
{
    var r = lhs
    
    for i in 0..<min(lhs.dimensions, rhs.dimensions)
    {
        r[i] += rhs[i]
    }
    
    return r
}

public func += <M1: MultiDimensionalValue, M2: MultiDimensionalValue where M1.Scalar == M2.Scalar>(inout lhs: M1, rhs: M2)
{
    lhs = lhs + rhs
}


public func - <M1: MultiDimensionalValue, M2: MultiDimensionalValue where M1.Scalar == M2.Scalar>(lhs: M1, rhs: M2) -> M1
{
    var r = lhs
    
    for i in 0..<min(lhs.dimensions, rhs.dimensions)
    {
        r[i] -= rhs[i]
    }
    
    return r
}

public func -= <M1: MultiDimensionalValue, M2: MultiDimensionalValue where M1.Scalar == M2.Scalar>(inout lhs: M1, rhs: M2)
{
    lhs = lhs - rhs
}

public prefix func - <F: MultiDimensionalValue> (lhs: F) -> F
{
    var f = lhs
    
    for i in 0..<f.dimensions
    {
        f[i] = -f[i]
    }
    
    return f
}

public func == <F: MultiDimensionalValue> (lhs: F, rhs: F) -> Bool
{
    guard lhs.dimensions == rhs.dimensions else { return false }
    
    for i in lhs.startIndex..<lhs.endIndex
    {
        guard lhs[i] as? F.Scalar == rhs[i] as? F.Scalar else { return false }
    }
    
    return true
}

// MARK: - Linear interpolation

public func lerp <F: MultiDimensionalValue> (lower: F, _ upper: F, _ factor: F.Scalar) -> F
{
    return lower * (1 - factor) + upper * factor
}
/*
public func lerp (lower: CGRect, _ upper: CGRect, _ factor: CGFloat) -> CGRect
{
    return CGRect(
        origin: lerp (lower.origin, upper.origin, factor),
        size: lerp (lower.size, upper.size, factor)
    )
}
*/

