// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI

// MARK: - Typography

public enum Typography {
    public static let monospacedFont = Font.system(.body, design: .monospaced)
    public static let monospacedSmall = Font.system(.caption, design: .monospaced)
    public static let monospacedLarge = Font.system(.title3, design: .monospaced)
    
    public static let title = Font.system(.title2, design: .default, weight: .semibold)
    public static let headline = Font.system(.headline, design: .default, weight: .semibold)
    public static let body = Font.system(.body, design: .default)
    public static let caption = Font.system(.caption, design: .default)
    public static let footnote = Font.system(.footnote, design: .default)
}

// MARK: - Colors

public enum Colors {
    public static let primaryText = Color.primary
    public static let secondaryText = Color.secondary
    public static let tertiaryText = Color(.systemGray)
    
    public static let background = Color(.systemBackground)
    public static let secondaryBackground = Color(.secondarySystemBackground)
    public static let tertiaryBackground = Color(.tertiarySystemBackground)
    
    public static let separator = Color(.separator)
    
    public static let success = Color.green
    public static let warning = Color.orange
    public static let error = Color.red
    public static let info = Color.blue
}

// MARK: - Spacing

public enum Spacing {
    public static let xs: CGFloat = 4
    public static let sm: CGFloat = 8
    public static let md: CGFloat = 12
    public static let lg: CGFloat = 16
    public static let xl: CGFloat = 24
    public static let xxl: CGFloat = 32
}

// MARK: - Corner Radius

public enum CornerRadius {
    public static let sm: CGFloat = 6
    public static let md: CGFloat = 8
    public static let lg: CGFloat = 12
    public static let xl: CGFloat = 16
}

// MARK: - Icon Sizing

public enum IconSize {
    public static let sm: CGFloat = 16
    public static let md: CGFloat = 20
    public static let lg: CGFloat = 24
    public static let xl: CGFloat = 28
}
