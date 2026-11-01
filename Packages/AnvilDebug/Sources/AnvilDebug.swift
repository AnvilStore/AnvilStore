// AnvilDebug — Live device console, crash logs, sandbox browser, backup/restore
// License: AGPL-3.0

import Foundation
import SwiftUI
import AnvilUI
import AnvilTheme

@MainActor
public final class AnvilDebug: ObservableObject, Sendable {
    public init() {}
}

extension AnvilDebug {
    public struct DebugView: View {
        @Environment(\.themeConfiguration) private var theme
        public init() {}
        public var body: some View {
            AnvilScreen("Debug") {
                AnvilEmptyState(
                    icon: "ladybug",
                    title: "Debug",
                    message: "Live device console (filter/search/export), crash log viewer, sandbox browser with hex viewer and plist editor, app data backup/restore."
                )
            }
        }
    }
}