// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI

/// Theme configuration for AnvilStore.
/// Dense, monospace-forward, single accent color, no gradients.
public struct ThemeConfiguration: Codable, Equatable, Sendable {
    public var accentColor: AccentColor
    public var appearance: AppearanceMode
    public var density: DensityMode
    public var expertMode: Bool
    
    public init(
        accentColor: AccentColor = .orange,
        appearance: AppearanceMode = .auto,
        density: DensityMode = .comfortable,
        expertMode: Bool = false
    ) {
        self.accentColor = accentColor
        self.appearance = appearance
        self.density = density
        self.expertMode = expertMode
    }
    
    public static let `default` = ThemeConfiguration()
}

// MARK: - Accent Color

public enum AccentColor: String, Codable, CaseIterable, Sendable {
    case orange
    case blue
    case green
    case red
    case purple
    case pink
    case yellow
    case teal
    
    public var color: Color {
        switch self {
        case .orange: return Color(red: 1.0, green: 0.58, blue: 0.0)
        case .blue: return Color(red: 0.0, green: 0.48, blue: 1.0)
        case .green: return Color(red: 0.20, green: 0.78, blue: 0.35)
        case .red: return Color(red: 1.0, green: 0.27, blue: 0.23)
        case .purple: return Color(red: 0.69, green: 0.32, blue: 0.87)
        case .pink: return Color(red: 1.0, green: 0.18, blue: 0.33)
        case .yellow: return Color(red: 1.0, green: 0.80, blue: 0.0)
        case .teal: return Color(red: 0.19, green: 0.82, blue: 0.85)
        }
    }
    
    public var displayName: String {
        rawValue.capitalized
    }
}

// MARK: - Appearance Mode

public enum AppearanceMode: String, Codable, CaseIterable, Sendable {
    case light
    case dark
    case auto
    
    public var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .auto: return nil
        }
    }
    
    public var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .auto: return "Auto"
        }
    }
}

// MARK: - Density Mode

public enum DensityMode: String, Codable, CaseIterable, Sendable {
    case compact
    case comfortable
    case spacious
    
    public var verticalPadding: CGFloat {
        switch self {
        case .compact: return 8
        case .comfortable: return 12
        case .spacious: return 16
        }
    }
    
    public var horizontalPadding: CGFloat {
        switch self {
        case .compact: return 12
        case .comfortable: return 16
        case .spacious: return 20
        }
    }
    
    public var itemSpacing: CGFloat {
        switch self {
        case .compact: return 8
        case .comfortable: return 12
        case .spacious: return 16
        }
    }
    
    public var displayName: String {
        rawValue.capitalized
    }
}
