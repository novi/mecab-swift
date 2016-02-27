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
import Foundation

public enum MecabError: ErrorType {
    case MecabInitializeError
    case NodeParseError
}

public protocol Tokenzier {
    associatedtype T
    func tokenize(str: String) throws -> [T]
}

public class Mecab: Tokenzier {
    
    let mecab: COpaquePointer
    let mutex: UnsafeMutablePointer<pthread_mutex_t> = UnsafeMutablePointer.alloc(sizeof(pthread_mutex_t))
    public init() {
        self.mecab = mecab_new(0, nil)
        pthread_mutex_init(mutex, nil)
    }
    
    public func tokenize(str: String) throws -> [Node] {
        var nodes: [Node] = []
        
        pthread_mutex_lock(mutex)
        defer {
            pthread_mutex_unlock(mutex)
        }
        
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
        pthread_mutex_destroy(mutex)
    }
}