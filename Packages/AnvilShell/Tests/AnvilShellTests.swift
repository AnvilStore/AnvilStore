// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import XCTest
@testable import AnvilShell
import AnvilTheme

final class AnvilShellTests: XCTestCase {
    func testAppStateDefault() {
        let state = AppState()
        
        XCTAssertEqual(state.themeConfiguration, ThemeConfiguration.default)
        XCTAssertFalse(state.hasCompletedOnboarding)
        XCTAssertEqual(state.selectedTab, 0)
    }
    
    func testAppStatePersistence() {
        let state = AppState()
        state.themeConfiguration = ThemeConfiguration(accentColor: .blue, appearance: .dark, density: .compact, expertMode: true)
        state.completeOnboarding()
        state.persistTheme()
        
        // Create new instance to test loading
        let newState = AppState()
        
        XCTAssertTrue(newState.hasCompletedOnboarding)
        XCTAssertEqual(newState.themeConfiguration.accentColor, .blue)
        XCTAssertEqual(newState.themeConfiguration.appearance, .dark)
        XCTAssertEqual(newState.themeConfiguration.density, .compact)
        XCTAssertTrue(newState.themeConfiguration.expertMode)
    }
}