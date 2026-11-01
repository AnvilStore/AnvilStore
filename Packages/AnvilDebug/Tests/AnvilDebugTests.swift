// AnvilDebugTests — License: AGPL-3.0

import XCTest
import AnvilDebug

final class AnvilDebugTests: XCTestCase {
    func testDebugInit() {
        let debug = AnvilDebug()
        XCTAssertNotNil(debug)
    }
}