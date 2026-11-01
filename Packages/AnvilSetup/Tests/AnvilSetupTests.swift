// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import XCTest
@testable import AnvilSetup

final class AnvilSetupTests: XCTestCase {
    func testSetupViewExists() {
        let view = SetupView()
        XCTAssertNotNil(view)
    }
}