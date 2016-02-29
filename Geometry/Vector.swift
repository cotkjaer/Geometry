//
//  Vector.swift
//  Geometry
//
//  Created by Christian Otkjær on 26/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

// Abstraction of a mathematical vector
public protocol VectorType
{
    typealias Scalar : FloatingPointArithmeticType
    
    func dotProduct(_: Self) -> Scalar
    
    // Parts not essential for answering the question
    init()
    var count: Int {get}
    subscript(_:Int) -> Scalar {get set}
    
    func + (_: Self, _: Self) -> Self
    func - (_: Self, _: Self) -> Self
    prefix func + (_: Self) -> Self
    prefix func - (_: Self) -> Self
    func * (_: Self, _: Scalar) -> Self
    func / (_: Self, _: Scalar) -> Self
}

public struct EmptyVector<T: FloatingPointArithmeticType> : VectorType {
    
    public typealias Scalar = T
    
    public init() {}
    
    public func dotProduct(other: EmptyVector) -> Scalar
    {
        return Scalar(0)
    }
    public var count: Int { return 0 }
    
    public subscript(i: Int) -> Scalar
    {
        get { fatalError("subscript out-of-range") }
        set { fatalError("subscript out-of-range") }
    }
}

public struct Vector<Tail: VectorType> : VectorType
{
    public typealias Scalar = Tail.Scalar
    
//    public init(_ scalars: Scalar...)
//    {
//        self.init(scalars)
//    }
//    
//    public init<S:CollectionType where S.Generator.Element == Scalar>(_ scalars:S)
//    {
//        switch scalars.count
//        {
//        case 0:
//            self.init()
//            
//        case 1:
//            self.init(scalars[scalars.startIndex], tail: EmptyVector<Scalar>())
//            
//        default:
//            self.init(scalars[scalars.startIndex], tail: Vector(Array(scalars[scalars.startIndex.advancedBy(1)..<scalars.endIndex])))
//        }
//    }
    
    public init(_ scalar: Scalar, tail: Tail = Tail())
    {
        self.scalar = scalar
        self.tail = tail
    }
    
    public init()
    {
        self.scalar = Scalar(0)
        self.tail = Tail()
    }
    
    public func dotProduct(other: Vector) -> Scalar {
        return scalar * other.scalar + tail.dotProduct(other.tail)
    }
    
    public var count: Int { return tail.count + 1 }
    public var scalar: Scalar
    public var tail: Tail
    
    public subscript(i: Int) -> Scalar
        {
        get { return i == 0 ? scalar : tail[i - 1] }
        set { if i == 0 { scalar = newValue } else { tail[i - 1] = newValue } }
    }
}


//===--- A nice operator for composing vectors ----------------------------===//
//===--- there's probably a more appropriate symbol -----------------------===//
infix operator ⋮ {
associativity right
precedence 1 // unsure of the best precedence here
}


public func ⋮ <T: FloatingPointArithmeticType> (lhs: T, rhs: T) -> Vector<Vector<EmptyVector<T> > >
{
    return Vector(lhs, tail: Vector(rhs))
}

public func ⋮ <T: FloatingPointArithmeticType, U where U.Scalar == T> (lhs: T, rhs: Vector<U>) -> Vector<Vector<U> >
{
    return Vector(lhs, tail: rhs)
}


extension Vector : CustomDebugStringConvertible
{
    public var debugDescription: String
        {
        if count == 1 {
            return "Vector(\(String(reflecting: scalar)), tail: EmptyVector())"
        }
        return "\(String(reflecting: scalar)) ⋮ " + (count == 2 ? String(reflecting: self[1]) : String(reflecting: tail))
    }
}


public  func + <T> (_: EmptyVector<T>,_: EmptyVector<T>) -> EmptyVector<T>
{
    return EmptyVector()
}

public func - <T> (_: EmptyVector<T>, _: EmptyVector<T>) -> EmptyVector<T>
{
    return EmptyVector()
}

public prefix func + <T> (_: EmptyVector<T>) -> EmptyVector<T>
{
    return EmptyVector()
}

public prefix func - <T> (_: EmptyVector<T>) -> EmptyVector<T>
{
    return EmptyVector()
}


public func + <T> (lhs: Vector<T>, rhs: Vector<T>) -> Vector<T>
{
    return Vector(lhs[0] + rhs[0], tail: lhs.tail + rhs.tail)
}

public func - <T> (lhs: Vector<T>, rhs: Vector<T>) -> Vector<T>
{
    return Vector(lhs[0] - rhs[0], tail: lhs.tail - rhs.tail)
}

public prefix func + <T> (lhs: Vector<T>) -> Vector<T>
{
    return lhs
}

public prefix func - <T> (lhs: Vector<T>) -> Vector<T>
{
    return Vector(-lhs[0], tail: -lhs.tail)
}

// MARK: - Scale

public func * <V: VectorType> (lhs: V.Scalar, rhs: V) -> V
{
    return rhs * lhs
}

public func * <T> (lhs: Vector<T>, rhs: T.Scalar) -> Vector<T> {
    return Vector(lhs[0] * rhs, tail: lhs.tail * rhs)
}

public func / <T> (lhs: Vector<T>, rhs: T.Scalar) -> Vector<T> {
    return Vector(lhs[0] / rhs, tail: lhs.tail / rhs)
}

public func * <T> (_: EmptyVector<T>, _: T) -> EmptyVector<T>
{
    return EmptyVector()
}

public func / <T> (_: EmptyVector<T>, _: T) -> EmptyVector<T>
{
    return EmptyVector()
}

//===--- CollectionType conformance ---------------------------------------===//

extension Vector : CollectionType
{
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return count }
}
