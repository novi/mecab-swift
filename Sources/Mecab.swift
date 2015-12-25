//
//  Mecab.swift
//  MeCab
//
//  Created by Yusuke Ito on 12/25/15.
//  Copyright © 2015 Yusuke Ito. All rights reserved.
//

import CMeCab
import Foundation

public enum MecabError: ErrorType {
    case MecabInitializeError
    case NodeParseError
}

public protocol Tokenzier {
    typealias TN
    func tokenize(str: String) throws -> [TN]
}

public class Mecab: Tokenzier {
    public typealias TN = Node
    
    let mecab: COpaquePointer
    public init() {
        self.mecab = mecab_new(0, nil)
    }
    
    public func tokenize(str: String) throws -> [Node] {
        var nodes: [Node] = []
        
        var node = mecab_sparse_tonode(mecab, NSString(string: str).UTF8String)
        while true {
            if node == nil {
                break
            }
            nodes.append(try Node(node))
            node = UnsafePointer(node.memory.next)
        }
        return nodes
    }
    
    deinit {
        mecab_destroy(mecab)
    }
}