// AnvilCutawayTests — License: AGPL-3.0

import XCTest
import AnvilCutaway

final class AnvilCutawayTests: XCTestCase {
    func testCutawayInit() {
        let cutaway = AnvilCutaway()
        XCTAssertNotNil(cutaway)
    }
}