// AnvilRefreshTests — License: AGPL-3.0

import XCTest
import AnvilRefresh

final class AnvilRefreshTests: XCTestCase {
    func testRefreshInit() {
        let refresh = AnvilRefresh()
        XCTAssertNotNil(refresh)
    }
}