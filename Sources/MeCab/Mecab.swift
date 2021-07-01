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

public enum MecabError: Error {
    case mecabInitializeError
    case nodeParseError
}

public class Mecab {
    
    let mecab: OpaquePointer
    var mutex = pthread_mutex_t()
    public init() throws {
        guard let mecab = mecab_new(0, nil) else {
            throw MecabError.mecabInitializeError
        }
        self.mecab = mecab
        pthread_mutex_init(&mutex, nil)
    }
    
    public func tokenize(string str: String) throws -> [Node] {
        
        pthread_mutex_lock(&mutex)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        return try str.withCString{ buf in
            var nodes: [Node] = []
            var node = mecab_sparse_tonode(mecab, buf)
            while true {
                if let n = node {
                    nodes.append(try Node(n))
                    node = UnsafePointer(n.pointee.next)
                } else {
                    break
                }
            }
            return nodes
        }
    }
    
    deinit {
        mecab_destroy(mecab)
        pthread_mutex_destroy(&mutex)
    }
}
