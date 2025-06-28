//
//  Base36.swift
//  Base36
//
//  Created by Arkivili Collindort on 2025/6/16
//

import Foundation

private let base36Alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

extension Data {
    /// Encode a data to Base-36 format string.
    /// - Returns: Base-36 encoded data.
    ///
    /// - Warning: **DO NOT** use this function to process large size data, it may cause memory leaks when data is too large.
    public func base36EncodedString() -> String {
        var value = self.reduce(UInt128(0)) { ($0 << 8) | UInt128($1) }
        guard value > 0 else { return "0" }

        var result = ""
        while value > 0 {
            let remainder = Int(value % 36)
            result.append(
                base36Alphabet[
                    base36Alphabet.index(
                        base36Alphabet.startIndex,
                        offsetBy: remainder
                    )
                ]
            )
            value /= 36
        }

        return String(result.reversed())
    }

    /// Decode data from Base-36 encoded string.
    /// - Parameter string: Base-36 encoded string.
    public init?(base36Encoded string: String) {
        var value = UInt128(0)
        let base = UInt128(36)

        for char in string.lowercased() {
            guard let index = base36Alphabet.firstIndex(of: char) else {
                return nil
            }
            let digit = base36Alphabet.distance(
                from: base36Alphabet.startIndex,
                to: index
            )
            value = value * base + UInt128(digit)
        }

        var result = Data(repeating: 0, count: 16)
        for i in (0..<16).reversed() where value > 0 {
            result[i] = UInt8(value & 0xFF)
            value >>= 8
        }

        self = result
    }
}
