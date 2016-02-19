//
//  Size2D.swift
//  Geometry
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

public protocol Size2D : ScalableShape
{
    var width : NumberType { get set }
    var height : NumberType { get set }
    
    init()
    
    init(width: NumberType, height: NumberType)
}

// MARK: - Default

public extension Size2D
{
    init(width: NumberType, height: NumberType)
    {
        self.init()
        
        self.width = width
        self.height = height
    }
    
    func scaled(factor: NumberType) -> Self
    {
        return Self(width: width * factor, height: height * factor)
    }
}

// MARK: - CGSize

extension CGSize : Size2D
{
    public typealias NumberType = CGFloat
}
