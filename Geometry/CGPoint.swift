//
//  CGPoint.swift
//  Math
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics
import UIKit

// MARK: - CGPoint

public extension CGPoint
{
    // MARK: init
    
    init(x: CGFloat)
    {
        self.init(x:x, y:0)
    }
    
    init(y: CGFloat)
    {
        self.init(x:0, y:y)
    }

    init(size: CGSize)
    {
        self.init(x:size.width, y:size.height)
    }
    
    // MARK: map
    
    func map(transform: CGFloat -> CGFloat) -> CGPoint
    {
        return CGPoint(x: transform(x), y: transform(y))
    }
    
    // MARK: with
    
    func with(x x: CGFloat) -> CGPoint
    {
        return CGPoint(x: x, y: y)
    }
    
    func with(y y: CGFloat) -> CGPoint
    {
        return CGPoint(x: x, y: y)
    }
    
    // MARK: distance
    
    func distanceTo(point: CGPoint) -> CGFloat
    {
        return sqrt(distanceSquaredTo(point))
    }
    
    func distanceSquaredTo(point: CGPoint) -> CGFloat
    {
        return pow(x - point.x, 2) + pow(y - point.y, 2)
    }
    
    private func distanceToLineSegment(v v: CGPoint, w: CGPoint) -> CGFloat
    {
        if v == w { return distanceTo(v) }
        
        // |w-v|^2 - avoid a squareroot
        let l2 = v.distanceSquaredTo(w)
        
        // Consider the line extending the segment, parameterized as v + t (w - v).
        // The projection of point p onto that line falls where t = [(p-v) . (w-v)] / |w-v|^2
        let t = dot(self - v, w - v) / l2
        
        if t < 0 // Beyond the 'v' end of the segment
        {
            return distanceTo(v)
        }
        else if t > 1 // Beyond the 'w' end of the segment
        {
            return distanceTo(w)
        }
        else // Projection falls on the segment
        {
            let projection = lerp(v, w, t)// v + t * (w - v)
            return distanceTo(projection)
        }
    }
    
    /**
     Minimum distance between line segment and `self`
     - parameter ls: line-segment tuple
     */
    func distanceToLineSegment(ls: (CGPoint, CGPoint)) -> CGFloat
    {
        return distanceToLineSegment(v:ls.0, w:ls.1)
    }
    
    // MARK: mid way
    
    func midWayTo(p2:CGPoint) -> CGPoint
    {
        return lerp(self, p2, 0.5)
    }
    
    // MARK: rotation
    
    /// angle is in radians
    public mutating func rotate(theta:CGFloat, around center:CGPoint = CGPointZero)
    {
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)
        
        let transposedX = x - center.x
        let transposedY = y - center.y
        
        x = center.x + (transposedX * cosTheta - transposedY * sinTheta)
        y = center.y + (transposedX * sinTheta + transposedY * cosTheta)
    }

    /// angle is in radians
    public func rotated(theta:CGFloat, around center:CGPoint) -> CGPoint
    {
        return (self - center).rotated(theta) + center
    }
    
    /// angle is in radians
    public func rotated(theta:CGFloat) -> CGPoint
    {
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)
        
        return CGPoint(x: x * cosTheta - y * sinTheta, y: x * sinTheta + y * cosTheta)
    }
    
    public func angleToPoint(point: CGPoint) -> CGFloat
    {
        return atan2(point.y - y, point.x - x)
    }
}

public func rotate(point p1:CGPoint, radians: CGFloat, around p2:CGPoint) -> CGPoint
{
    let sinTheta = sin(radians)
    let cosTheta = cos(radians)
    
    let transposedX = p1.x - p2.x
    let transposedY = p1.y - p2.y
    
    return CGPoint(x: p2.x + (transposedX * cosTheta - transposedY * sinTheta),
        y: p2.y + (transposedX * sinTheta + transposedY * cosTheta))
}

public func isEqual(p1: CGPoint, p2: CGPoint, withPrecision precision:CGFloat) -> Bool
{
    return p1.distanceTo(p2) < abs(precision)
}

// MARK: - Comparable

extension CGPoint: Comparable
{
}

/// CAVEAT: first y then x comparison
public func > (p1: CGPoint, p2: CGPoint) -> Bool
{
    return (p1.y < p2.y) || ((p1.y == p2.y) && (p1.x < p2.x))
}

public func < (p1: CGPoint, p2: CGPoint) -> Bool
{
    return (p1.y > p2.y) || ((p1.y == p2.y) && (p1.x > p2.x))
}

// MARK: - Operators

public func + (p1: CGPoint, p2: CGPoint) -> CGPoint
{
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}

public func += (inout p1: CGPoint, p2: CGPoint)
{
    p1.x += p2.x
    p1.y += p2.y
}

public prefix func - (p: CGPoint) -> CGPoint
{
    return CGPoint(x: -p.x, y: -p.y)
}

public func - (p1: CGPoint, p2: CGPoint) -> CGPoint
{
    return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
}

public func - (p1: CGPoint, p2: CGPoint?) -> CGPoint
{
    return p1 - (p2 ?? CGPointZero)
}

public func -= (inout p1: CGPoint, p2: CGPoint)
{
    p1.x -= p2.x
    p1.y -= p2.y
}

public func + (point: CGPoint, size: CGSize) -> CGPoint
{
    return CGPoint(x: point.x + size.width, y: point.y + size.height)
}

public func += (inout point: CGPoint, size: CGSize)
{
    point.x += size.width
    point.y += size.height
}


public func + (point: CGPoint, vector: CGVector) -> CGPoint
{
    return CGPoint(x: point.x + vector.dx, y: point.y + vector.dy)
}

public func += (inout point: CGPoint, vector: CGVector)
{
    point.x += vector.dx
    point.y += vector.dy
}

public func - (point: CGPoint, vector: CGVector) -> CGPoint
{
    return CGPoint(x: point.x - vector.dx, y: point.y - vector.dy)
}

public func -= (inout point: CGPoint, vector: CGVector)
{
    point.x -= vector.dx
    point.y -= vector.dy
}

public func - (point: CGPoint, size: CGSize) -> CGPoint
{
    return CGPoint(x: point.x - size.width, y: point.y - size.height)
}

public func -= (inout point: CGPoint, size: CGSize)
{
    point.x -= size.width
    point.y -= size.height
}

public func * (factor: CGFloat, point: CGPoint) -> CGPoint
{
    return CGPoint(x: point.x * factor, y: point.y * factor)
}

public func * (point: CGPoint, factor: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x * factor, y: point.y * factor)
}

public func *= (inout point: CGPoint, factor: CGFloat)
{
    point.x *= factor
    point.y *= factor
}

public func / (point: CGPoint, factor: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x / factor, y: point.y / factor)
}

public func /= (inout point: CGPoint, factor: CGFloat)
{
    point.x /= factor
    point.y /= factor
}

public func * (point: CGPoint, transform: CGAffineTransform) -> CGPoint
{
    return CGPointApplyAffineTransform(point, transform)
}

public func *= (inout point: CGPoint, transform: CGAffineTransform)
{
    point = point * transform
}

//MARK: - Round

public func round(point: CGPoint, toDecimals: Int = 0) -> CGPoint
{
    let decimals = max(0, toDecimals)
    
    if decimals == 0
    {
        return CGPoint(x: round(point.x), y: round(point.y))
    }
    else
    {
        let factor = pow(10, CGFloat(max(decimals, 0)))
        
        return CGPoint(x: round(point.x * factor) / factor, y: round(point.y * factor) / factor)
    }
}

// MARK: - Tuples

public extension CGPoint
{
    init(_ tuple: (CGFloat, CGFloat))
    {
        (x, y) = tuple
    }
    
    var tuple: (CGFloat, CGFloat) { return (x, y) }
}


