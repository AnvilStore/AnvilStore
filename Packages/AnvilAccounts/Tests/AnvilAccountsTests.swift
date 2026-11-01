// AnvilAccountsTests — License: AGPL-3.0

import XCTest
import AnvilAccounts

final class AnvilAccountsTests: XCTestCase {
    func testAccountsInit() {
        let accounts = AnvilAccounts()
        XCTAssertNotNil(accounts)
    }
}