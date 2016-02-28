import XCTest

extension MecabTests {
    var allTests : [(String, () throws -> Void)] {
        return [
            ("testTokenizeWithDefaults", testTokenizeWithDefaults)
        ]
    }
}


XCTMain([
    MecabTests()
])