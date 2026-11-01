// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI
import AnvilUI
import AnvilTheme
import AnvilSources

/// Main app entry point.
@main
public struct AnvilStoreApp: App {
    @StateObject private var appState = AppState()
    
    public init() {}
    
    public var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .themeConfiguration(appState.themeConfiguration)
        }
    }
}

/// Global app state.
@MainActor
public final class AppState: ObservableObject {
    @Published public var themeConfiguration = ThemeConfiguration.default
    @Published public var hasCompletedOnboarding = false
    @Published public var selectedTab = 0
    
    public init() {
        loadPersistedState()
    }
    
    private func loadPersistedState() {
        // Load from UserDefaults or Keychain
        if let data = UserDefaults.standard.data(forKey: "themeConfiguration"),
           let config = try? JSONDecoder().decode(ThemeConfiguration.self, from: data) {
            themeConfiguration = config
        }
        
        hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    }
    
    public func persistTheme() {
        if let data = try? JSONEncoder().encode(themeConfiguration) {
            UserDefaults.standard.set(data, forKey: "themeConfiguration")
        }
    }
    
    public func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}