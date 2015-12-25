//
//  main.swift
//  MeCabDemo
//
//  Created by Yusuke Ito on 12/25/15.
//  Copyright © 2015 Yusuke Ito. All rights reserved.
//

import MeCab
import Foundation


let m = Mecab()

let nodes = try! m.tokenize("太郎は次郎が持っている本を花子に渡した。")

for n in nodes.filter({ !$0.isBosEos }) {
    print(n.surface, n.features)
}