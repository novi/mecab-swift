//
//  main.swift
//  MeCabDemo
//
//  Created by Yusuke Ito on 12/25/15.
//  Copyright © 2015 Shiroyagi. All rights reserved.
//

import CMeCab
import Foundation

// https://mecab.googlecode.com/svn/trunk/mecab/doc/libmecab.html

let m = mecab_new(0, nil)
print(m)

let result = mecab_sparse_tonode(m, NSString(string: "太郎は次郎が持っている本を花子に渡した。").UTF8String)

var node = result
while true {
    if node == nil {
        break
    }
    print("\(node)")
    let surface = NSString(bytes: node.memory.surface, length: Int(node.memory.length), encoding: NSUTF8StringEncoding)
    let feature = NSString(UTF8String: node.memory.feature)
    print(surface, node.memory.length, feature)
    node = UnsafePointer(node.memory.next)
}

print(result)