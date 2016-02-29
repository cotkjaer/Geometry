//
//  Point2D.swift
//  Geometry
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic


public protocol Point2D : MultiDimensionValue
{
    var x : Scalar { get set }
    var y : Scalar { get set }
    
    init()
    
    init(x: Scalar, y: Scalar)
    
    func distance<P:Point2D where P.Scalar == Scalar>(point: P) -> Scalar
}

// MARK: - Defaults

extension Point2D
{
    public var dimensions : Int { return 2 }
    
    public subscript(index: Int) -> Scalar
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

//MARK: - Equatable

func == <P: Point2D>(lhs: P, rhs:P) -> Bool
{
    return lhs.x == rhs.x && lhs.y == rhs.y
}

// MARK: - Default

public extension Point2D
{
    init(x: Scalar, y: Scalar)
    {
        self.init()
        
        self.x = x
        self.y = y
    }
    
    func scaled(factor: Scalar) -> Self
    {
        return Self(x: x * factor, y: y * factor)
    }
}

// MARK: - Operators

public func + <P: Point2D>(lhs: P, rhs: P) -> P
{
    return P(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func += <P: Point2D> (inout lhs: P, rhs: P)
{
    lhs.x += rhs.x
    lhs.y += rhs.y
}

public func - <P: Point2D>(lhs: P, rhs: P) -> P
{
    return P(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func -= <P: Point2D> (inout lhs: P, rhs: P)
{
    lhs.x -= rhs.x
    lhs.y -= rhs.y
}

public func * <P: Point2D>(p: P, multiplier: P.Scalar) -> P
{
    return P(x: p.x * multiplier, y: p.y * multiplier)
}

public func *= <P: Point2D> (inout p: P, multiplier: P.Scalar)
{
    p.x *= multiplier
    p.y *= multiplier
}

public func / <P: Point2D>(p: P, divider: P.Scalar) -> P
{
    return P(x: p.x / divider, y: p.y / divider)
}

public func /= <P: Point2D> (inout p: P, divider: P.Scalar)
{
    p.x /= divider
    p.y /= divider
}

// MARK: - Convenience

extension Point2D
{
    // MARK: init
    
    init(x: Scalar)
    {
        self.init(x:x, y:0)
    }
    
    init(y: Scalar)
    {
        self.init(x:0, y:y)
    }
    
    init<S: Size2D where S.Scalar == Scalar>(size: S)
    {
        self.init(x:size.width, y:size.height)
    }
    
    // MARK: map
    
    func map(transform: Scalar -> Scalar) -> Self
    {
        return Self(x: transform(x), y: transform(y))
    }
    
    // MARK: with
    
    func with(x x: Scalar) -> Self
    {
        return Self(x: x, y: y)
    }
    
    func with(y y: Scalar) -> Self
    {
        return Self(x: x, y: y)
    }
    
    // MARK: distance
    
    public func distance<P:Point2D where P.Scalar == Scalar>(point: P) -> Scalar
    {
        return (pow(x - point.x, 2) + pow(y - point.y, 2)).squareroot
    }
    
    func distanceTo<P:Point2D where P.Scalar == Scalar>(point: P) -> Scalar
    {
        return distanceSquaredTo(point).squareroot
    }
    
    func distanceSquaredTo<P:Point2D where P.Scalar == Scalar>(point: P) -> Scalar
    {
        return pow(x - point.x, 2) + pow(y - point.y, 2)
    }
    
    private func distanceToLineSegment<P:Point2D where P.Scalar == Scalar>(v v: P, w: P) -> Scalar
    {
        if v == w { return distanceTo(v) }
     
        let s = P(x: x, y: y)
        
        // |w-v|^2 - avoid a squareroot
        let l2 = v.distanceSquaredTo(w)
        
        // Consider the line extending the segment, parameterized as v + t (w - v).
        // The projection of point p onto that line falls where t = [(p-v) . (w-v)] / |w-v|^2
        let t = dot(s - v, w - v) / l2
        
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
            let projection = lerp(v, w, t)
            return distanceTo(projection)
        }
    }
    
    /**
     Minimum distance between line segment and `self`
     - parameter ls: line-segment tuple
     */
    func distanceToLineSegment<P:Point2D where P.Scalar == Scalar>(point: P)(ls: (P, P)) -> Scalar
    {
        return distanceToLineSegment(v:ls.0, w:ls.1)
    }
    
    // MARK: rotation
    
    /// angle is in radians
    public mutating func rotate<P:Point2D where P.Scalar == Scalar>(theta:P.Scalar, around center:P)
    {
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)
        
        let transposedX = x - center.x
        let transposedY = y - center.y
        
        x = center.x + (transposedX * cosTheta - transposedY * sinTheta)
        y = center.y + (transposedX * sinTheta + transposedY * cosTheta)
    }
    
    /// angle is in radians
    public func rotated(theta:Scalar, around center:Self) -> Self
    {
        return (self - center).rotated(theta) + center
    }
    
    /// angle is in radians
    public func rotated(theta:Scalar) -> Self
    {
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)
        
        return Self(x: x * cosTheta - y * sinTheta, y: x * sinTheta + y * cosTheta)
    }
    
//    public func angleToPoint(point: Self) -> Scalar
//    {
//        return atan2(point.y - y, point.x - x)
//    }
}

public func rotate<P:Point2D>(point p1:P, radians: P.Scalar, around rhs:P) -> P
{
    let sinTheta = sin(radians)
    let cosTheta = cos(radians)
    
    let transposedX = p1.x - rhs.x
    let transposedY = p1.y - rhs.y
    
    let newX = rhs.x + (transposedX * cosTheta - transposedY * sinTheta)
    let newY = rhs.y + (transposedX * sinTheta + transposedY * cosTheta)
    
    return P(x: newX, y: newY)
}

public func isEqual<P:Point2D>(p1: P, rhs: P, withPrecision precision:P.Scalar) -> Bool
{
    return p1.distanceTo(rhs) < abs(precision)
}

// MARK: - CGPoint

extension CGPoint : Point2D
{
    public typealias Scalar = CGFloat
}

// MARK: - Distance


public func distance<P:Point2D>(a: P, _ b: P) -> P.Scalar
{
    return a.distanceTo(b)
}

public func distanceSquared<P:Point2D>(a: P, _ b: P) -> P.Scalar
{
    return pow(a.x - b.x, 2) + pow(a.y - b.y, 2)
}


// MARK: - Dot

/// this is U+22C5 not U+00B7 (middle dot)
infix operator ⋅ { associativity left precedence 160 }

public func ⋅ <P:Point2D>(a: P, b: P) -> P.Scalar
{
    return a.x * b.x + a.y * b.y
}

public func dot<P:Point2D>(a: P, _ b: P) -> P.Scalar
{
    return a.x * b.x + a.y * b.y
}

public func dotProduct<P:Point2D>(a: P, _ b: P) -> P.Scalar
{
    return a.x * b.x + a.y * b.y
}



// MARK: - Cross

infix operator × { associativity left precedence 160 }

public func × <P:Point2D> (lhs: P, rhs: P) -> P.Scalar
{
    return lhs.x * rhs.y - lhs.y * rhs.x
}

public func cross<P:Point2D>(lhs: P, _ rhs: P) -> P.Scalar
{
    return lhs.x * rhs.y - lhs.y * rhs.x
}

public func crossProduct<P:Point2D>(lhs: P, _ rhs: P) -> P.Scalar
{
    return lhs.x * rhs.y - lhs.y * rhs.x
}

// MARK: - Translate

extension Point2D
{
    public mutating func translate(dx: Scalar? = nil, dy: Scalar? = nil)
    {
        if let delta = dx
        {
            x += delta
        }
        
        if let delta = dy
        {
            y += delta
        }
    }
    
    public func translated(dx: Scalar? = nil, dy: Scalar? = nil) -> Self
    {
        var p = Self(x: x, y: y)
        
        p.translate(dx, dy: dy)
        
        return p
    }
}