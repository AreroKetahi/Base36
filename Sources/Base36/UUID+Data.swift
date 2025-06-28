//
//  UUID+Data.swift
//  Base36
//
//  Created by Arkivili Collindort on 2025/6/16
//


import Foundation

extension UUID {
    /// Raw data of a UUID entity.
    var dataRepresentation: Data {
        var uuid = self.uuid
        return unsafe Data(bytes: &uuid, count: MemoryLayout.size(ofValue: uuid))
    }
    
    /// Create a UUID from raw data.
    /// - Parameter data: Raw data of UUID.
    ///
    /// - Important: Please check the data size before calling this function. Incorrect UUID data size may cause memory leaks.
    init(_ data: Data) {
        self = unsafe data.withUnsafeBytes { ptr in
            unsafe ptr.load(as: UUID.self)
        }
    }
}

