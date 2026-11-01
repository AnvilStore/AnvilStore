// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI

/// A dense, monospace-forward list row with optional leading/trailing content.
public struct AnvilRow<Leading: View, Trailing: View, Content: View>: View {
    @Environment(\.themeConfiguration) private var theme
    let content: Content
    let leading: Leading
    let trailing: Trailing
    
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder leading: () -> Leading = { EmptyView() },
        @ViewBuilder trailing: () -> Trailing = { EmptyView() }
    ) {
        self.content = content()
        self.leading = leading()
        self.trailing = trailing()
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: theme.density.horizontalPadding / 2) {
            leading
            content
                .frame(maxWidth: .infinity, alignment: .leading)
            trailing
        }
        .padding(.vertical, theme.density.verticalPadding / 2)
        .padding(.horizontal, theme.density.horizontalPadding)
        .background(Colors.background)
    }
}

/// A section header with monospace label.
public struct AnvilSectionHeader: View {
    @Environment(\.themeConfiguration) private var theme
    let title: String
    
    public init(_ title: String) {
        self.title = title
    }
    
    public var body: some View {
        Text(title.uppercased())
            .font(Typography.monospacedSmall)
            .foregroundStyle(Colors.tertiaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, theme.density.horizontalPadding)
            .padding(.vertical, theme.density.verticalPadding / 2)
    }
}

/// A card container with subtle border.
public struct AnvilCard<Content: View>: View {
    @Environment(\.themeConfiguration) private var theme
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(theme.density.horizontalPadding)
            .background(Colors.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md))
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Colors.separator.opacity(0.5), lineWidth: 0.5)
            )
    }
}

/// A status badge with semantic color.
public struct AnvilBadge: View {
    @Environment(\.themeConfiguration) private var theme
    let text: String
    let kind: Kind
    
    public enum Kind {
        case success, warning, error, info, neutral
        
        var color: Color {
            switch self {
            case .success: return Colors.success
            case .warning: return Colors.warning
            case .error: return Colors.error
            case .info: return Colors.info
            case .neutral: return Colors.tertiaryText
            }
        }
    }
    
    public init(_ text: String, kind: Kind = .neutral) {
        self.text = text
        self.kind = kind
    }
    
    public var body: some View {
        Text(text)
            .font(Typography.monospacedSmall)
            .foregroundStyle(kind.color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(kind.color.opacity(0.15))
            .clipShape(Capsule())
    }
}

/// A monospace code/text block.
public struct AnvilCodeBlock: View {
    @Environment(\.themeConfiguration) private var theme
    let text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(Typography.monospacedSmall)
            .foregroundStyle(Colors.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(theme.density.horizontalPadding)
            .background(Colors.tertiaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm))
            .textSelection(.enabled)
    }
}

/// Divider with optional label.
public struct AnvilDivider: View {
    @Environment(\.themeConfiguration) private var theme
    let label: String?
    
    public init(_ label: String? = nil) {
        self.label = label
    }
    
    public var body: some View {
        HStack(spacing: theme.density.itemSpacing) {
            Rectangle()
                .fill(Colors.separator.opacity(0.5))
                .frame(height: 0.5)
            
            if let label {
                Text(label.uppercased())
                    .font(Typography.monospacedSmall)
                    .foregroundStyle(Colors.tertiaryText)
            }
            
            Rectangle()
                .fill(Colors.separator.opacity(0.5))
                .frame(height: 0.5)
        }
        .padding(.horizontal, theme.density.horizontalPadding)
    }
}