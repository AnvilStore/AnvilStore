// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI
import Combine

/// A navigation stack that works on iOS 15+ with fallback.
public struct AnvilNavigationStack<Content: View>: View {
    @Environment(\.themeConfiguration) private var theme
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}

/// Tab bar replacement with monospace labels.
public struct AnvilTabBar: View {
    @Environment(\.themeConfiguration) private var theme
    @Binding var selection: Int
    let tabs: [Tab]
    
    public struct Tab: Identifiable {
        public let id = UUID()
        let label: String
        let icon: String
        
        public init(label: String, icon: String) {
            self.label = label
            self.icon = icon
        }
    }
    
    public init(selection: Binding<Int>, tabs: [Tab]) {
        self._selection = selection
        self.tabs = tabs
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
                Button {
                    selection = index
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22, weight: selection == index ? .semibold : .regular))
                        Text(tab.label)
                            .font(Typography.monospacedSmall)
                    }
                    .foregroundStyle(selection == index ? Color.accentColor : Colors.tertiaryText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, theme.density.verticalPadding)
                }
                .buttonStyle(.plain)
            }
        }
        .background(Colors.secondaryBackground)
        .overlay(
            Rectangle()
                .fill(Colors.separator.opacity(0.5))
                .frame(height: 0.5),
            alignment: .top
        )
    }
}

/// iPad sidebar navigation.
public struct AnvilSidebar<SidebarContent: View, DetailContent: View>: View {
    @Environment(\.themeConfiguration) private var theme
    let sidebar: SidebarContent
    let detail: DetailContent
    
    public init(
        @ViewBuilder sidebar: () -> SidebarContent,
        @ViewBuilder detail: () -> DetailContent
    ) {
        self.sidebar = sidebar()
        self.detail = detail()
    }
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationSplitView {
                sidebar
            } detail: {
                detail
            }
        } else {
            HStack(spacing: 0) {
                sidebar
                    .frame(width: 280)
                    .background(Colors.secondaryBackground)
                
                Rectangle()
                    .fill(Colors.separator.opacity(0.5))
                    .frame(width: 0.5)
                
                detail
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}