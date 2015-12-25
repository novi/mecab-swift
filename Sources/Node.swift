//
//  Node.swift
//  MeCab
//
//  Created by Yusuke Ito on 12/25/15.
//  Copyright © 2015 Yusuke Ito. All rights reserved.
//

import CMeCab
import Foundation

public struct Node: CustomStringConvertible {
    public let isBosEos: Bool
    public let surface: String
    public let features: [String]
    init(_ node: UnsafePointer<mecab_node_t>) throws {
        guard let surface = NSString(bytes: node.memory.surface, length: Int(node.memory.length), encoding: NSUTF8StringEncoding),
            let feature = NSString(UTF8String: node.memory.feature) else {
                throw MecabError.NodeParseError
        }
        self.surface = surface as String
        self.features = (feature as String).componentsSeparatedByString(",")
        if features.count == 0 {
            throw MecabError.NodeParseError
        }
        self.isBosEos = features[0] == "BOS/EOS"
    }
}

extension Node {
    public var description: String {
        return "\(surface): \(features)"
    }
}