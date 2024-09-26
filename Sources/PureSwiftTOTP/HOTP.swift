//
//  HOTP.swift
//  PureSwiftOTP
//
//  Created by HALQME on 2024/09/25.
//
import Foundation
import CryptoKit
import DataEnhance

public struct HOTP {

    let digits: Int
    let algorithm: OTPAlgorithm

    public init(digits: Int = 6, algorithm: OTPAlgorithm = .sha1) {
        self.digits = digits
        self.algorithm = algorithm
    }
    
    /// HOTP Generator
    /// - Parameters:
    ///   - secret: Secrets: Data
    ///   - counter: Counter: Int
    /// - Returns: String?
    public func geneerate(secret: Data, counter: Int)
        -> String?
    {
        let counter = UInt64(counter).bigEndian.data

        let hmac =
            switch algorithm {
            case .sha1:
                Data(
                    HMAC<Insecure.SHA1>.authenticationCode(
                        for: counter, using: SymmetricKey.init(data: secret)))
            case .sha256:
                Data(
                    HMAC<SHA256>.authenticationCode(
                        for: counter, using: SymmetricKey.init(data: secret)))
            case .sha512:
                Data(
                    HMAC<SHA512>.authenticationCode(
                        for: counter, using: SymmetricKey.init(data: secret)))
            }

        let offset = Int((hmac.last ?? 0x00) & 0x0f)
        
        let truncatedHMAC = Array(hmac[offset...offset + 3])
        
        let data =  Data(truncatedHMAC)
        
        let uInt32 = UInt32(strtoul(data.byte.toHexString(), nil, 16))
        
        let number = (uInt32 & 0x7fffffff) % UInt32(pow(10, Float(digits)))

        let str = String(number)
        
        // Return string if adding leading zeros is not required
        guard str.count == digits else {
            let prefixedZeros = String(repeatElement("0", count: (digits - str.count)))
            return prefixedZeros + str
        }
        
        return (str)
    }
}
