// AnvilRefresh — Background auto-refresh, per-app toggles, failure notifications, Shortcuts
// License: AGPL-3.0

import Foundation
import SwiftUI
import AnvilUI
import AnvilTheme
import AnvilAccounts

@MainActor
public final class AnvilRefresh: ObservableObject, Sendable {
    public init() {}
}

extension AnvilRefresh {
    public struct RefreshView: View {
        @Environment(\.themeConfiguration) private var theme
        public init() {}
        public var body: some View {
            AnvilScreen("Refresh") {
                AnvilEmptyState(
                    icon: "arrow.clockwise",
                    title: "Refresh",
                    message: "Background auto-refresh before expiry, per-app toggles, failure notifications, Shortcuts actions."
                )
            }
        }
    }
}