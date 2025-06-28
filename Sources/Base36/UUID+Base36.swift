//
//  UUID+Base36.swift
//  Base36
//
//  Created by Arkivili Collindort on 2025/6/16
//


import Foundation

extension UUID {
    /// Encode UUID as Base-36 represetation.
    /// - Returns: Base-36 representation UUID.
    public func base36Representation() -> String {
        self.dataRepresentation.base36EncodedString()
    }
    
    /// Decode UUID from a Base-36 representation.
    /// - Parameter string: Base-36 encoded UUID.
    public init?(base36Representation string: String) {
        guard let data = Data(base36Encoded: string) else {
            return nil
        }
        
        self.init(data)
    }
}
