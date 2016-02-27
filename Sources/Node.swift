//
//  Node.swift
//  MeCab
//
//  Created by Yusuke Ito on 12/25/15.
//  Copyright © 2015 Yusuke Ito. All rights reserved.
//

import CMeCab
import Foundation

public protocol TokenNode {
    var isBosEos: Bool { get }
    var surface: String { get }
    var features: [String] { get }
}

extension Node {
    public enum `Type`: Int {
        case Normal = 0
        case Unknown = 1
        case BeginOfSentence = 2
        case EndOfSentence = 3
        case EndOfNBestEnumeration = 4
    }
}

public struct Node: TokenNode, CustomStringConvertible {
    public let isBosEos: Bool
    public let surface: String
    public let features: [String]
    public let posId: Int
    public let type: Type
    
    init(_ node: UnsafePointer<mecab_node_t>) throws {
        guard let surface = NSString(bytes: node.memory.surface, length: Int(node.memory.length), encoding: NSUTF8StringEncoding),
            let feature = NSString(UTF8String: node.memory.feature),
            let type = Type(rawValue: Int(node.memory.stat)) else {
                throw MecabError.NodeParseError
        }
        self.surface = surface as String
        self.features = (feature as String).componentsSeparatedByString(",")
        if features.count == 0 {
            throw MecabError.NodeParseError
        }
        self.isBosEos = type == .EndOfSentence || type == .BeginOfSentence
        self.type = type
        self.posId = Int(node.memory.posid)
    }
}

extension Node {
    public var description: String {
        return "\(surface): \(posId) \(features)"
    }
}