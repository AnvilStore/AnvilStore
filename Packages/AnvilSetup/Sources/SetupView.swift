// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI
import AnvilUI
import AnvilTheme

/// Setup view - placeholder for Module 2.
public struct SetupView: View {
    @Environment(\.themeConfiguration) private var theme
    
    public init() {}
    
    public var body: some View {
        AnvilNavigationStack {
            AnvilScreen("Setup") {
                AnvilEmptyState(
                    icon: "gear.badge.checkmark",
                    title: "Setup",
                    message: "Pairing file import, loopback tunnel, and diagnostics coming in Module 2."
                )
            }
        }
    }
}