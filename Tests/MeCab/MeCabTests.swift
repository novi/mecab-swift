//
//  MeCabTests.swift
//  MeCabTests
//
//  Created by Yusuke Ito on 12/25/15.
//  Copyright © 2015 Yusuke Ito. All rights reserved.
//

import XCTest
@testable import MeCab

extension MeCabTests {
    static var allTests : [(String, MeCabTests -> () throws -> Void)] {
        return [
                   ("testTokenizeWithDefaults", testTokenizeWithDefaults),
                   ("testDemo", testDemo)
        ]
    }
}

class MeCabTests: XCTestCase {
    
    func testTokenizeWithDefaults() throws {
        
        let mecab = try Mecab()
        
        let text = "あのイーハトーヴォのすきとおった風、"
        
        let nodes = try mecab.tokenize(string: text)
        
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
    
    func testDemo() throws {
        
        let m = try Mecab()
        
        let nodes = try m.tokenize(string: "太郎は次郎が持っている本を花子に渡した。")
        
        // MARK: Demo
        
        for n in nodes.filter({ !$0.isBosEos }) {
            print(n.surface, n.features, n.posId)
        }
        
        // MARK: Test
        
        let expected = "太郎 は 次郎 が 持っ て いる 本 を 花 子 に 渡し た 。".characters.split(separator: " ").map(String.init)
        let bodyNodes = nodes.filter({ !$0.isBosEos })
        
        XCTAssertEqual(expected, bodyNodes.map{ $0.surface })
        
        XCTAssertEqual(expected.count, bodyNodes.count)
    }
    
}
