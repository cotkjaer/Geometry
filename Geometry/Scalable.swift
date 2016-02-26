//
//  Scalable.swift
//  Geometry
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

public protocol ScalableShape: Shape, Addable
{
    func scaled(factor : NumberType) -> Self
}

public func lerp <F: ScalableShape> (lower: F, _ upper: F, _ factor: F.NumberType) -> F
{
    return lower.scaled(1 - factor) + upper.scaled(factor)
}

public func lerp (lower: CGRect, _ upper: CGRect, _ factor: CGFloat) -> CGRect
{
    return CGRect(
        origin: lerp (lower.origin, upper.origin, factor),
        size: lerp (lower.size, upper.size, factor)
    )
}