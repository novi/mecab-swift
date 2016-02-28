//
//  MeCabTests.swift
//  MeCabTests
//
//  Created by Yusuke Ito on 12/25/15.
//  Copyright © 2015 Yusuke Ito. All rights reserved.
//

import XCTest
@testable import MeCab

class MeCabTests: XCTestCase {
    
    func testTokenizeWithDefaults() {
        
        let mecab = try! Mecab()
        
        let text = "あのイーハトーヴォのすきとおった風、"
        
        let nodes = try! mecab.tokenize(text)
        
        for n in nodes {
            print(n.description)
        }
        
        
        XCTAssertEqual(nodes.count, 9)
        
        XCTAssertTrue(nodes[0].isBosEos)
        
        XCTAssertEqual(nodes[1].surface, "あの")
        XCTAssertEqual(nodes[1].posId, 68) // this value for ipadic
        
        XCTAssertEqual(nodes[2].surface, "イーハトーヴォ")
        XCTAssertEqual(nodes[2].posId, 38)
        
        XCTAssertEqual(nodes[3].surface, "の")
        XCTAssertEqual(nodes[3].posId, 13)
        
        XCTAssertEqual(nodes[4].surface, "すきとおっ")
        XCTAssertEqual(nodes[4].posId, 31)
        
        XCTAssertEqual(nodes[5].surface, "た")
        XCTAssertEqual(nodes[5].posId, 25)
    
        XCTAssertEqual(nodes[6].surface, "風")
        XCTAssertEqual(nodes[6].posId, 38)
        
        XCTAssertEqual(nodes[7].surface, "、")
        XCTAssertEqual(nodes[7].posId, 9)
        
        XCTAssertTrue(nodes[8].isBosEos)
    }
    
}
