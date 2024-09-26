//
//  TOTP.swift
//  PureSwiftOTP
//
//  Created by HALQME on 2024/09/26.
//

import Foundation
import Base32

struct TOTP {
    let timeInterval: TimeInterval
    let hotp: HOTP

    init(digits: Int = 6, algorithm: OTPAlgorithm = .sha1, timeInterval: TimeInterval = 30) {
        self.timeInterval = timeInterval
        self.hotp = HOTP(digits: digits, algorithm: algorithm)
    }

    
    /// generate from data
    /// - Parameter data: Data
    /// - Returns: String?
    public func generate(data: Data) -> String? {
        return hotp.geneerate(
            secret: data, counter: Int(Date().timeIntervalSince1970 / timeInterval))
    }
    
    /// generate from generic secret key
    /// - Parameter secret: String(Base32 Encoded)
    /// - Returns: String?
    public func generate(secret: String) -> String? {
        guard let data = base32DecodeToData(secret) else { return nil }
        return generate(data: data)
    }

    public func generate(data: Data, time: Date) -> String? {
        return hotp.geneerate(
            secret: data, counter: Int(floor(time.timeIntervalSince1970) / timeInterval)
        )
    }
    
    public func counterProgress() -> Int {
        let time = Date()
        return Int(floor(time.timeIntervalSince1970)) % Int(timeInterval)
    }
}
