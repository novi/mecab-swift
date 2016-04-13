//
//  Mecab.swift
//  MeCab
//
//  Created by Yusuke Ito on 12/25/15.
//  Copyright © 2015 Yusuke Ito. All rights reserved.
//

#if os(Linux)
    import Glibc
#endif

import CMeCab

public enum MecabError: ErrorProtocol {
    case MecabInitializeError
    case NodeParseError
}

public protocol Tokenzier {
    associatedtype T: TokenNode
    func tokenize(string str: String) throws -> [T]
}

public class Mecab: Tokenzier {
    
    let mecab: OpaquePointer
    var mutex = pthread_mutex_t()
    public init() throws {
        guard let mecab = mecab_new(0, nil) else {
            throw MecabError.MecabInitializeError
        }
        self.mecab = mecab
        pthread_mutex_init(&mutex, nil)
    }
    
    public func tokenize(string str: String) throws -> [Node] {
        var nodes: [Node] = []
        
        pthread_mutex_lock(&mutex)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        return try str.withCString{ buf in
            var nodes: [Node] = []
            var node = mecab_sparse_tonode(mecab, buf)
            while true {
                if node == nil {
                    break
                }
                nodes.append(try Node(node))
                node = UnsafePointer(node.pointee.next)
            }
            return nodes
        }
    }
    
    deinit {
        mecab_destroy(mecab)
        pthread_mutex_destroy(&mutex)
    }
}