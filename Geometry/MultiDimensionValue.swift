//
//  Scalable.swift
//  Geometry
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

public protocol MultiDimensionValue: Addable, Subtractable, Equatable, CollectionType
{
    typealias Scalar : FloatingPointArithmeticType
    
    var dimensions : Int { get }
    
    subscript(_ :Int) -> Scalar { get set }
    
    func * (_: Self, _: Scalar) -> Self
    func * (_: Scalar, _: Self) -> Self
    
    func / (_: Self, _: Scalar) -> Self
}

// MARK: - Defaults

extension MultiDimensionValue
{
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return dimensions }
}

public func lerp <F: MultiDimensionValue> (lower: F, _ upper: F, _ factor: F.Scalar) -> F
{
    return lower * (1 - factor) + upper * factor
}

public func == <F: MultiDimensionValue> (lhs: F, rhs: F) -> Bool
{
    guard lhs.dimensions == rhs.dimensions else { return false }
    
    for i in lhs.startIndex..<lhs.endIndex
    {
        guard lhs[i] as? F.Scalar == rhs[i] as? F.Scalar else { return false }
    }
    
    return true
}

//public protocol ScalableShape: Shape, Addable
//{
//    func scaled(factor : Scalar) -> Self
//}
//
//public func lerp <F: ScalableShape> (lower: F, _ upper: F, _ factor: F.Scalar) -> F
//{
//    return lower.scaled(1 - factor) + upper.scaled(factor)
//}

public func lerp (lower: CGRect, _ upper: CGRect, _ factor: CGFloat) -> CGRect
{
    return CGRect(
        origin: lerp (lower.origin, upper.origin, factor),
        size: lerp (lower.size, upper.size, factor)
    )
}