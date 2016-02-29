//
//  Angles.swift
//  Math
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

// MARK: - Sinus

///Sine function
@warn_unused_result
public func sin<F: FloatingPointArithmeticType>(f: F) -> F
{
    if let d = f as? Double, let s = sin(d) as? F
    {
        return s
    }
    if let d = f as? Float, let s = sin(d) as? F
    {
        return s
    }
    if let d = f as? CGFloat, let s = sin(d) as? F
    {
        return s
    }
    
    fatalError("cannot get sin for \(f.dynamicType)")
}

// MARK: - Cosinus

///Cosine function
@warn_unused_result
public func cos<F: FloatingPointArithmeticType>(f: F) -> F
{
    if let d = f as? Double, let s = cos(d) as? F
    {
        return s
    }
    if let d = f as? Float, let s = cosf(d) as? F
    {
        return s
    }
    if let d = f as? CGFloat, let s = cos(d) as? F
    {
        return s
    }
    
    fatalError("cannot get cos for \(f.dynamicType)")
}

// MARK: - Tangent

///Tangent function
@warn_unused_result
public func tan<F: FloatingPointArithmeticType>(f: F) -> F
{
    if let d = f as? Double, let s = tan(d) as? F
    {
        return s
    }
    if let d = f as? Float, let s = tanf(d) as? F
    {
        return s
    }
    if let d = f as? CGFloat, let s = tan(d) as? F
    {
        return s
    }
    
    fatalError("cannot get tan for \(f.dynamicType)")
}

///Arc tangent function of two variables
@warn_unused_result
public func atan2<F: FloatingPointArithmeticType>(x: F, _ y:F) -> F
{
    if let x = x as? Double, let y = y as? Double, let r = atan2(x,y) as? F
    {
        return r
    }

    if let x = x as? Float, let y = y as? Float, let r = atan2f(x,y) as? F
    {
        return r
    }
    
    if let x = x as? CGFloat, let y = y as? CGFloat, let r = atan2(x,y) as? F
    {
        return r
    }
    
    fatalError("cannot get tan for \(x.dynamicType)")
}

///Arc tangent function of two-dimensional value
/// - returns : atan2(p.y, p.x) - value in range ]-π;π]
@warn_unused_result
public func atan2<P: TwoDimensionalValue>(p: P) -> P.Scalar
{
    return atan2(p[1], p[0])
}

// MARK: - Normalize

/**
Normalize an angle in a 2π wide interval around a center value.
- parameter φ: angle to normalize
- parameter Φ: center of the desired 2π-interval for the result
- returns: φ - 2πk; with integer k and Φ - π <= φ - 2πk <= Φ + π

- Note: This method has three main uses:
1. normalize an angle between 0 and 2π
```swift
let a = normalizeAngle(a, π)
```

2. normalize an angle between -π and +π
```swift
let a = normalizeAngle(a, 0)
```

3. compute the angle between two defining angular positions
```swift
let angle = normalizeAngle(end, start) - start
```

- Warning: Due to numerical accuracy and since π cannot be represented
exactly, the result interval is **closed**, it cannot be half-closed
as would be more satisfactory in a purely mathematical view.

*/
@warn_unused_result
public func normalizeAngle<F:FloatingPointArithmeticType>(φ : F, _ Φ: F = F.π) -> F
{
    let a = ((φ + F.π - Φ) / F.π2).floor
    return φ - F.π2 * a
}

/// Normalizes angle to be in ]-π;π]
@warn_unused_result
public func normalizeRadians<F:FloatingPointArithmeticType>(φ: F) -> F
{
    return φ - ( φ / F.π2 - 0.5 ).ceil * F.π2
}

/// Transform degrees to radians
@warn_unused_result
public func degrees2radians<F:FloatingPointArithmeticType>(degrees: F) -> F
{
    return (degrees * F.π) / 180
}

/// Transform radians to degrees
@warn_unused_result
public func radians2degrees<F:FloatingPointArithmeticType>(radians: F) -> F
{
    return (radians * 180) / F.π
}

public extension FloatingPointArithmeticType
{
    /// Assumes `self` is in degrees
    public var asRadians : Self { return (self * Self.π) / 180 }
    
    /// Assumes `self` is in radians
    public var asDegrees : Self { return (self * 180) / Self.π }
        
    /// - note: Assumes `self` is in radians
    /// Normalizes angle to be in ]φ-π;φ+π]
    @warn_unused_result
    func normalized(φ: Self = Self.π) -> Self
    {
        if φ == 0
        {
            /// Normalizes angle to be in ]-π;π]
            return self - ( self / Self.π2 - 0.5 ).ceil * Self.π2
        }
        
        let a = ((self + Self.π - φ) / Self.π2).floor
        return self - Self.π2 * a
    }
}
