// AnvilPatcher — Bundle ID/name/version/icon, entitlements, dylibs, deb extraction, presets
// License: AGPL-3.0

import Foundation
import SwiftUI
import AnvilUI
import AnvilTheme
import AnvilAccounts

@MainActor
public final class AnvilPatcher: ObservableObject, Sendable {
    public init() {}
}

extension AnvilPatcher {
    public struct PatcherView: View {
        @Environment(\.themeConfiguration) private var theme
        public init() {}
        public var body: some View {
            AnvilScreen("Patch") {
                AnvilEmptyState(
                    icon: "wrench.and.screwdriver",
                    title: "Patcher",
                    message: "Change bundle ID/name/version/icon, remove extensions, add/strip entitlements, import dylibs/frameworks/debs, saveable presets, batch patching."
                )
            }
        }
    }
}