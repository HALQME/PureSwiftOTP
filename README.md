---
title: Pure Swift OTP
subtitle: Just Like Fork of https://github.com/lachlanbell/SwiftOTP
---
# SwiftOTP Fork Only Written in Swift

PureSwiftOTP is a unique fork version of \[lachlanbell/SwiftOTP\](https://github.com/lachlanbell/SwiftOTP).

The logic of generating OTP is not almost changed.

I changed package dependency and usage, a little.

# Installation

With Package.swift, add

```swift
dependencies: [
    .package(url: "https://github.com/HALQME/PureSwiftOTP.git", branch: "main")
]
```

and `import PureSwiftOTP` in your file.

# Usage

## TOTP

```swift
// https://tools.ietf.org/html/rfc4226#page-32
let data = Data(hex: "3132333435363738393031323334353637383930")!
let totp = TOTP() // digits: Int = 6, algorithm: OTPAlgorithm = .sha1, timeInterval: TimeInterval = 30
totp.generate(data: data, time: Date(timeIntervalSince1970: 0)) // "755224"

// OR
let secret = "BASE32ENCODEDVALUE"
totp.generate(secret: secret) // return TOTP code of Date()
```

## HOTP

```swift
// https://tools.ietf.org/html/rfc4226#page-32
let data = Data(hex: "3132333435363738393031323334353637383930")!
let hotp = HOTP() // digits: Int = 6, algorithm: OTPAlgorithm = .sha1
hotp.geneerate(secret: data, counter: 0) // "755224"
```
