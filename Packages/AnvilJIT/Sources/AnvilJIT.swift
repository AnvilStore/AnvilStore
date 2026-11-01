// AnvilJIT — Per-app JIT enabler, backends per iOS version, auto-enable on launch
// License: AGPL-3.0

import Foundation
import SwiftUI
import AnvilUI
import AnvilTheme
import AnvilAccounts

@MainActor
public final class AnvilJIT: ObservableObject, Sendable {
    public init() {}
}

extension AnvilJIT {
    public struct JITView: View {
        @Environment(\.themeConfiguration) private var theme
        public init() {}
        public var body: some View {
            AnvilScreen("JIT") {
                AnvilEmptyState(
                    icon: "bolt",
                    title: "JIT",
                    message: "Per-app JIT enabler, one backend per iOS version range, auto-enable on launch."
                )
            }
        }
    }
}