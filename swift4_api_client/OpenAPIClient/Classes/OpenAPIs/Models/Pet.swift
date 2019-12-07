//
// Pet.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct Pet: Codable {

    public var id: Int64
    public var name: String
    public var tag: String?

    public init(id: Int64, name: String, tag: String?) {
        self.id = id
        self.name = name
        self.tag = tag
    }


}

