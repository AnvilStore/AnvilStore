// AnvilInstall — Sign & install on-device, queue, retry, install-over-existing
// License: AGPL-3.0

import Foundation
import SwiftUI
import AnvilUI
import AnvilTheme
import AnvilAccounts

@MainActor
public final class AnvilInstall: ObservableObject, Sendable {
    public init() {}
}

extension AnvilInstall {
    public struct InstallView: View {
        @Environment(\.themeConfiguration) private var theme
        public init() {}
        public var body: some View {
            AnvilScreen("Install") {
                AnvilEmptyState(
                    icon: "arrow.down.circle",
                    title: "Install",
                    message: "Sign and install IPAs, manage install queue, retry from failed step, install-over-existing."
                )
            }
        }
    }
}