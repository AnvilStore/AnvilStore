// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import XCTest
@testable import AnvilTheme

final class ThemeConfigurationTests: XCTestCase {
    func testDefaultConfiguration() {
        let config = ThemeConfiguration.default
        XCTAssertEqual(config.accentColor, .orange)
        XCTAssertEqual(config.appearance, .auto)
        XCTAssertEqual(config.density, .comfortable)
        XCTAssertFalse(config.expertMode)
    }
    
    func testCodable() throws {
        let config = ThemeConfiguration(
            accentColor: .blue,
            appearance: .dark,
            density: .compact,
            expertMode: true
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(config)
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(ThemeConfiguration.self, from: data)
        
        XCTAssertEqual(config, decoded)
    }
    
    func testDensitySpacing() {
        XCTAssertEqual(DensityMode.compact.verticalPadding, 8)
        XCTAssertEqual(DensityMode.comfortable.verticalPadding, 12)
        XCTAssertEqual(DensityMode.spacious.verticalPadding, 16)
    }
    
    func testAccentColors() {
        for accent in AccentColor.allCases {
            XCTAssertNotNil(accent.color)
            XCTAssertFalse(accent.displayName.isEmpty)
        }
    }
}
