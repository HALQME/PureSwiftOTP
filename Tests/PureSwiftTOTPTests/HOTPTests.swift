//
//  HOTPTests.swift
//  PureSwiftOTP
//
//  Created by HALQME on 2024/09/25.
//

import Testing
import Foundation
@testable import PureSwiftOTP

@Suite("HOTP Tests")
struct HOTPTests {
    // https://tools.ietf.org/html/rfc4226#page-32
    
    let data = Data(hex: "3132333435363738393031323334353637383930")!
    let expectedOTP = ["755224", "287082", "359152", "969429", "338314", "254676", "287922", "162583", "399871", "520489"]
    @Test("HOTP Geneate Test")
    func testHOTP() {
        let hotp = HOTP()
        for i in 0...(expectedOTP.count - 1) {
            #expect(hotp.geneerate(secret: data, counter: i) == expectedOTP[i])
        }
    }
}
