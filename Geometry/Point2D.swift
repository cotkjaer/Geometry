//
//  Point2D.swift
//  Geometry
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

public protocol Point2D : ScalableShape
{
    var x : NumberType { get set }
    var y : NumberType { get set }
    
    init()
    
    init(x: NumberType, y: NumberType)
    
    func distance<P:Point2D where P.NumberType == NumberType>(point: P) -> NumberType
}

// MARK: - Default

public extension Point2D
{
    init(x: NumberType, y: NumberType)
    {
        self.init()
        
        self.x = x
        self.y = y
    }
    
    func scaled(factor: NumberType) -> Self
    {
        return Self(x: x * factor, y: y * factor)
    }
}

// MARK: - CGPoint

extension CGPoint : Point2D
{
    public typealias NumberType = CGFloat
    
    public func distance<P:Point2D where P.NumberType == NumberType>(point: P) -> CGFloat
    {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}
