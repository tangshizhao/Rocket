//
//  Identifiable.swift
//  Rocket
//
//  Created by 汤世昭 on 2020/3/3.
//

import Foundation

public protocol Identifiable: CustomStringConvertible {
    var uuid: UUID { get }
}

extension Identifiable {
    public var description: String {
        return "<ID: \(uuid.uuidString), TIME: \(Date())>"
    }
}
