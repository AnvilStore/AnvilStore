// AnvilInstallTests — License: AGPL-3.0

import XCTest
import AnvilInstall

final class AnvilInstallTests: XCTestCase {
    func testInstallInit() {
        let install = AnvilInstall()
        XCTAssertNotNil(install)
    }
}