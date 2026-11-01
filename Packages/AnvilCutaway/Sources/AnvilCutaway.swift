// AnvilCutaway — IPA inspector and differ: Info.plist, entitlements, Mach-O, diff, export
// License: AGPL-3.0

import Foundation
import SwiftUI
import AnvilUI
import AnvilTheme

@MainActor
public final class AnvilCutaway: ObservableObject, Sendable {
    public init() {}
}

extension AnvilCutaway {
    public struct CutawayView: View {
        @Environment(\.themeConfiguration) private var theme
        public init() {}
        public var body: some View {
            AnvilScreen("Cutaway") {
                AnvilEmptyState(
                    icon: "doc.badge.magnifyingglass",
                    title: "Cutaway",
                    message: "IPA inspector and differ: Info.plist, entitlements with notes, provisioning, Mach-O architectures/frameworks/dylibs, diff two IPAs, JSON/Markdown export."
                )
            }
        }
    }
}