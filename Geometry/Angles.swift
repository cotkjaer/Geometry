//
//  Angles.swift
//  Math
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

// MARK: - Normalize

/**
Normalize an angle in a 2π wide interval around a center value.
- parameter φ: angle to normalize
- parameter Φ: center of the desired 2π-interval for the result
- returns: φ - 2πk; with integer k and Φ - π <= φ - 2πk <= Φ + π

- Note: This method has three main uses:
1. normalize an angle between 0 and 2π
```swift
let a = CGFloat.normalizeAngle(a, π)
```

2. normalize an angle between -π and +π
```swift
let a = CGFloat.normalizeAngle(a, 0)
```

3. compute the angle between two defining angular positions
```swift
let angle = CGFloat.normalizeAngle(end, start) - start
```

- Warning: Due to numerical accuracy and since π cannot be represented
exactly, the result interval is **closed**, it cannot be half-closed
as would be more satisfactory in a purely mathematical view.

*/
@warn_unused_result
public func normalizeAngle<F:FloatingPointArithmeticType>(φ : F, _ Φ: F = F.π) -> F
{
    return φ - F.π2 * ((φ + F.π - Φ) / F.π2).floor
}

//extension FloatingPointArithmeticType
//{
//    /// normalized value, as an angle between 0 and 2π
//    public var asNormalizedAngle : Self { return normalizeAngle(self) }
//    
//    /// Normalizes self to be in ]-π;π]
//    public var normalizedRadians: Self
//        {
//            return self - (self / Self.π2 - Self(0.5)).ceil * Self.π2
//    }
//}

/// Normalizes angle to be in ]-π;π]
public func normalizeRadians<F:FloatingPointArithmeticType>(φ: F) -> F
{
    return φ - ( φ / F.π2 - 0.5 ).ceil * F.π2
}

public func degrees2radians<F:FloatingPointArithmeticType>(degrees: F) -> F
{
    return (degrees * F.π) / 180
}

public func radians2degrees<F:FloatingPointArithmeticType>(radians: F) -> F
{
    return (radians * 180) / F.π
}
