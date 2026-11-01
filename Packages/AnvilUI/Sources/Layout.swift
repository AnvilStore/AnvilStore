// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI

/// A screen container with navigation title and optional toolbar.
public struct AnvilScreen<Content: View, ToolbarContent: View>: View {
    @Environment(\.themeConfiguration) private var theme
    let title: String
    let content: Content
    let toolbar: ToolbarContent?
    
    public init(
        _ title: String,
        @ViewBuilder content: () -> Content,
        @ViewBuilder toolbar: () -> ToolbarContent? = { nil }
    ) {
        self.title = title
        self.content = content()
        self.toolbar = toolbar()
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Colors.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: theme.density.itemSpacing) {
                    content
                }
                .padding(.bottom, theme.density.xl)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    toolbar
                }
            }
        }
    }
}

/// A list section with header and footer.
public struct AnvilSection<Content: View>: View {
    @Environment(\.themeConfiguration) private var theme
    let header: String?
    let footer: String?
    let content: Content
    
    public init(
        header: String? = nil,
        footer: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.header = header
        self.footer = footer
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.density.itemSpacing / 2) {
            if let header {
                AnvilSectionHeader(header)
            }
            
            content
            
            if let footer {
                Text(footer)
                    .font(Typography.monospacedSmall)
                    .foregroundStyle(Colors.tertiaryText)
                    .padding(.horizontal, theme.density.horizontalPadding)
            }
        }
    }
}

/// Empty state view.
public struct AnvilEmptyState: View {
    @Environment(\.themeConfiguration) private var theme
    let icon: String
    let title: String
    let message: String
    let action: (() -> Void)?
    let actionTitle: String?
    
    public init(
        icon: String,
        title: String,
        message: String,
        action: (() -> Void)? = nil,
        actionTitle: String? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.action = action
        self.actionTitle = actionTitle
    }
    
    public var body: some View {
        VStack(spacing: theme.density.lg) {
            Image(systemName: icon)
                .font(.system(size: 48, weight: .light))
                .foregroundStyle(Colors.tertiaryText)
            
            VStack(spacing: theme.density.sm) {
                Text(title)
                    .font(Typography.headline)
                    .foregroundStyle(Colors.primaryText)
                
                Text(message)
                    .font(Typography.body)
                    .foregroundStyle(Colors.secondaryText)
                    .multilineTextAlignment(.center)
            }
            
            if let action, let actionTitle {
                AnvilButton(actionTitle, role: .primary, action: action)
                    .frame(width: 200)
            }
        }
        .padding(theme.density.xl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

/// Loading state view.
public struct AnvilLoadingState: View {
    @Environment(\.themeConfiguration) private var theme
    let message: String?
    
    public init(_ message: String? = nil) {
        self.message = message
    }
    
    public var body: some View {
        VStack(spacing: theme.density.lg) {
            ProgressView()
                .controlSize(.large)
                .tint(Color.accentColor)
            
            if let message {
                Text(message)
                    .font(Typography.body)
                    .foregroundStyle(Colors.secondaryText)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

/// Error state view.
public struct AnvilErrorState: View {
    @Environment(\.themeConfiguration) private var theme
    let title: String
    let message: String
    let retry: (() -> Void)?
    
    public init(
        title: String,
        message: String,
        retry: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.retry = retry
    }
    
    public var body: some View {
        VStack(spacing: theme.density.lg) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48, weight: .light))
                .foregroundStyle(Colors.error)
            
            VStack(spacing: theme.density.sm) {
                Text(title)
                    .font(Typography.headline)
                    .foregroundStyle(Colors.primaryText)
                
                Text(message)
                    .font(Typography.body)
                    .foregroundStyle(Colors.secondaryText)
                    .multilineTextAlignment(.center)
            }
            
            if let retry {
                AnvilButton("Retry", role: .primary, action: retry)
                    .frame(width: 160)
            }
        }
        .padding(theme.density.xl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}