// AnvilPatcherTests — License: AGPL-3.0

import XCTest
import AnvilPatcher

final class AnvilPatcherTests: XCTestCase {
    func testPatcherInit() {
        let patcher = AnvilPatcher()
        XCTAssertNotNil(patcher)
    }
}