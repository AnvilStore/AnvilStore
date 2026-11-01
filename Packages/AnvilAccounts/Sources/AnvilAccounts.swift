// AnvilAccounts — Apple ID sign-in, anisette, cert/App ID/profile handling
// License: AGPL-3.0

import Foundation
import SwiftUI
import AnvilUI
import AnvilTheme
import Alamofire
import KeychainAccess

@MainActor
public final class AnvilAccounts: ObservableObject, Sendable {
    public init() {}
}

extension AnvilAccounts {
    public struct AccountsView: View {
        @Environment(\.themeConfiguration) private var theme
        public init() {}
        public var body: some View {
            AnvilScreen("Accounts") {
                AnvilEmptyState(
                    icon: "person.2",
                    title: "Accounts",
                    message: "Apple ID sign-in, anisette servers, certificates, and profiles will be managed here."
                )
            }
        }
    }
}