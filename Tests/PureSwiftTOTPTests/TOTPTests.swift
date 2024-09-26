//
//  TOTPTests.swift
//  PureSwiftOTP
//
//  Created by HALQME on 2024/09/26.
//

import Testing
import Foundation
@testable import PureSwiftOTP

@Suite("Generate Tests")
struct TOTPTests {
    // https://tools.ietf.org/html/rfc4226#page-32
    let data = Data(hex: "3132333435363738393031323334353637383930")!
    let totp = TOTP()
    @Test("TOTPTest #1 0s")
    func testHOTP1() {
        #expect(totp.generate(data: data, time: Date(timeIntervalSince1970: 0)) == "755224")
    }

    @Test("TOTPTest #2 29s")
    func testHOTP2() {
        #expect(totp.generate(data: data, time: Date(timeIntervalSince1970: 29)) == "755224")
    }

    @Test("TOTPTest #3 30s")
    func testHOTP3() {
        #expect(totp.generate(data: data, time: Date(timeIntervalSince1970: 30)) == "287082")
    }

    @Test("TOTPTest #4 90s")
    func testHOTP4() {
        #expect(totp.generate(data: data, time: Date(timeIntervalSince1970: 90)) == "969429")
    }

    @Test("TOTPTest #5 20000000000s")
    func testHOTP5() {
        #expect(
            totp.generate(data: data, time: Date(timeIntervalSince1970: 20000000000)) == "353130")
    }

}

@Suite("Generate Tests")
struct UtilityTests {
    @Test("TOTP Counter Progress")
    func example() throws {
        let totp = TOTP()
        print(totp.counterProgress())
    }
}
