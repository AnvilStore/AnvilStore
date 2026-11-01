// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI

// MARK: - Environment Key

private struct ThemeConfigurationKey: EnvironmentKey {
    static let defaultValue = ThemeConfiguration.default
}

extension EnvironmentValues {
    public var themeConfiguration: ThemeConfiguration {
        get { self[ThemeConfigurationKey.self] }
        set { self[ThemeConfigurationKey.self] = newValue }
    }
}

// MARK: - View Modifier

public struct ThemeConfigurationModifier: ViewModifier {
    let configuration: ThemeConfiguration
    
    public init(configuration: ThemeConfiguration) {
        self.configuration = configuration
    }
    
    public func body(content: Content) -> some View {
        content
            .environment(\.themeConfiguration, configuration)
            .accentColor(configuration.accentColor.color)
            .preferredColorScheme(configuration.appearance.colorScheme)
    }
}

extension View {
    public func themeConfiguration(_ configuration: ThemeConfiguration) -> some View {
        modifier(ThemeConfigurationModifier(configuration: configuration))
    }
}
