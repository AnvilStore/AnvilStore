// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI
import AnvilUI
import AnvilTheme
import AnvilSources
import AnvilSetup
import AnvilAccounts
import AnvilInstall
import AnvilRefresh
import AnvilPatcher
import AnvilCutaway
import AnvilJIT
import AnvilDebug

/// Root view handling onboarding and main tabs.
public struct RootView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.themeConfiguration) private var theme
    @State private var showingOnboarding = false

    public init() {}

    public var body: some View {
        Group {
            if appState.hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingFlowView(onComplete: {
                    appState.completeOnboarding()
                })
            }
        }
        .onAppear {
            if !appState.hasCompletedOnboarding {
                showingOnboarding = true
            }
        }
    }
}

/// Main tab view with Sources, Setup, Accounts, Install, etc.
private struct MainTabView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.themeConfiguration) private var theme

    var body: some View {
        ZStack(alignment: .bottom) {
            AnvilTabBar(selection: $appState.selectedTab, tabs: [
                .init(label: "Sources", icon: "square.grid.3x3"),
                .init(label: "Setup", icon: "gear.badge.checkmark"),
                .init(label: "Accounts", icon: "person.2"),
                .init(label: "Install", icon: "arrow.down.circle"),
                .init(label: "Refresh", icon: "arrow.clockwise"),
                .init(label: "Patch", icon: "wrench.and.screwdriver"),
                .init(label: "Cutaway", icon: "doc.badge.magnifyingglass"),
                .init(label: "JIT", icon: "bolt"),
                .init(label: "Debug", icon: "ladybug"),
            ])
            .ignoresSafeArea(edges: .bottom)

            TabView(selection: $appState.selectedTab) {
                SourcesView()
                    .tag(0)

                SetupView()
                    .tag(1)

                AnvilAccounts.AccountsView()
                    .tag(2)

                AnvilInstall.InstallView()
                    .tag(3)

                AnvilRefresh.RefreshView()
                    .tag(4)

                AnvilPatcher.PatcherView()
                    .tag(5)

                AnvilCutaway.CutawayView()
                    .tag(6)

                AnvilJIT.JITView()
                    .tag(7)

                AnvilDebug.DebugView()
                    .tag(8)
            }
        }
    }
}

/// Onboarding flow.
private struct OnboardingFlowView: View {
    let onComplete: () -> Void
    @State private var currentPage = 0

    private let pages = [
        OnboardingPage(
            icon: "iphone.gen3.radiowaves.left.and.right",
            title: "Welcome to AnvilStore",
            body: "An on-device iOS sideloading workstation. Install apps without a computer."
        ),
        OnboardingPage(
            icon: "lock.shield",
            title: "Privacy First",
            body: "No analytics. No tracking. Your Apple credentials stay in the Keychain. AGPL-3.0 licensed."
        ),
        OnboardingPage(
            icon: "gear.badge.checkmark",
            title: "Setup Required",
            body: "You'll need a pairing file from AltServer/SideStore to sign apps. We'll guide you through it."
        ),
        OnboardingPage(
            icon: "square.grid.3x3",
            title: "Add Sources",
            body: "Add AltStore-compatible repositories to browse and install apps directly on device."
        ),
    ]

    var body: some View {
        AnvilNavigationStack {
            ZStack {
                Colors.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    TabView(selection: $currentPage) {
                        ForEach(pages.indices, id: \.self) { index in
                            OnboardingPageView(page: pages[index])
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))

                    VStack(spacing: theme.density.md) {
                        if currentPage == pages.count - 1 {
                            AnvilButton("Get Started", role: .primary) {
                                onComplete()
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            AnvilButton("Continue", role: .primary) {
                                withAnimation { currentPage += 1 }
                            }
                            .frame(maxWidth: .infinity)
                        }

                        if currentPage > 0 {
                            AnvilButton("Back", role: .secondary) {
                                withAnimation { currentPage -= 1 }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(theme.density.xl)
                }
            }
        }
    }
}

private struct OnboardingPage {
    let icon: String
    let title: String
    let body: String
}

private struct OnboardingPageView: View {
    @Environment(\.themeConfiguration) private var theme
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: theme.density.xl) {
            Spacer()

            Image(systemName: page.icon)
                .font(.system(size: 80, weight: .light))
                .foregroundStyle(Color.accentColor)

            VStack(spacing: theme.density.md) {
                Text(page.title)
                    .font(Typography.title)
                    .foregroundStyle(Colors.primaryText)
                    .multilineTextAlignment(.center)

                Text(page.body)
                    .font(Typography.body)
                    .foregroundStyle(Colors.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, theme.density.xl)
            }

            Spacer()
            Spacer()
        }
        .padding(theme.density.xl)
    }
}