// AnvilJITTests — License: AGPL-3.0

import XCTest
import AnvilJIT

final class AnvilJITTests: XCTestCase {
    func testJITInit() {
        let jit = AnvilJIT()
        XCTAssertNotNil(jit)
    }
}