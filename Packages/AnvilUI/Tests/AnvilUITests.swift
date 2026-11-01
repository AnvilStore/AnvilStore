// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import XCTest
@testable import AnvilUI
import AnvilTheme

final class AnvilUITests: XCTestCase {
    func testThemeConfigurationApplied() {
        let config = ThemeConfiguration(
            accentColor: .blue,
            appearance: .dark,
            density: .compact,
            expertMode: true
        )
        
        let view = Text("Test")
            .themeConfiguration(config)
        
        // Just verify it doesn't crash
        XCTAssertNotNil(view)
    }
    
    func testAnvilRow() {
        let row = AnvilRow {
            Text("Content")
        } leading: {
            Image(systemName: "circle")
        } trailing: {
            AnvilBadge("Active", kind: .success)
        }
        
        XCTAssertNotNil(row)
    }
    
    func testAnvilButtonRoles() {
        for role in AnvilButton.Role.allCases {
            let button = AnvilButton("Test", role: role) {}
            XCTAssertNotNil(button)
        }
    }
    
    func testAnvilSection() {
        let section = AnvilSection(header: "Header", footer: "Footer") {
            Text("Content")
        }
        XCTAssertNotNil(section)
    }
    
    func testAnvilEmptyState() {
        let empty = AnvilEmptyState(
            icon: "square.grid.3x3",
            title: "No Sources",
            message: "Add a source to get started"
        )
        XCTAssertNotNil(empty)
    }
}

extension AnvilButton.Role: CaseIterable {
    public static var allCases: [AnvilButton.Role] = [.primary, .secondary, .destructive, .plain]
}