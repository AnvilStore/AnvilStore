// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI

/// A button with dense, monospace styling.
public struct AnvilButton: View {
    @Environment(\.themeConfiguration) private var theme
    let title: String
    let role: Role
    let isLoading: Bool
    let action: () -> Void
    
    public enum Role {
        case primary, secondary, destructive, plain
        
        var backgroundColor: Color {
            switch self {
            case .primary: return Color.accentColor
            case .secondary: return Color.secondary.opacity(0.15)
            case .destructive: return Colors.error.opacity(0.15)
            case .plain: return Color.clear
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .primary: return .white
            case .secondary: return Color.primary
            case .destructive: return Colors.error
            case .plain: return Color.accentColor
            }
        }
        
        var borderColor: Color {
            switch self {
            case .primary: return Color.clear
            case .secondary: return Colors.separator.opacity(0.5)
            case .destructive: return Colors.error.opacity(0.5)
            case .plain: return Color.clear
            }
        }
    }
    
    public init(
        _ title: String,
        role: Role = .primary,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.role = role
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: theme.density.itemSpacing / 2) {
                if isLoading {
                    ProgressView()
                        .controlSize(.small)
                        .tint(role.foregroundColor)
                }
                Text(title)
                    .font(Typography.body.weight(.medium))
            }
            .foregroundStyle(role.foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, theme.density.verticalPadding)
            .padding(.horizontal, theme.density.horizontalPadding)
            .background(role.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md))
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(role.borderColor, lineWidth: 1)
            )
        }
        .disabled(isLoading)
        .buttonStyle(.plain)
    }
}

/// A toggle with monospace label.
public struct AnvilToggle: View {
    @Environment(\.themeConfiguration) private var theme
    @Binding var isOn: Bool
    let title: String
    let subtitle: String?
    
    public init(
        _ title: String,
        subtitle: String? = nil,
        isOn: Binding<Bool>
    ) {
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
    }
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(Typography.body)
                if let subtitle {
                    Text(subtitle)
                        .font(Typography.monospacedSmall)
                        .foregroundStyle(Colors.tertiaryText)
                }
            }
        }
        .toggleStyle(.switch)
        .tint(Color.accentColor)
    }
}

/// A picker for enum cases.
public struct AnvilPicker<Selection: Hashable & CaseIterable & RawRepresentable>: View where Selection.RawValue == String {
    @Environment(\.themeConfiguration) private var theme
    @Binding var selection: Selection
    let label: String
    
    public init(_ label: String, selection: Binding<Selection>) {
        self.label = label
        self._selection = selection
    }
    
    public var body: some View {
        Picker(label, selection: $selection) {
            ForEach(Selection.allCases, id: \.self) { option in
                Text(option.rawValue.capitalized).tag(option)
            }
        }
        .pickerStyle(.menu)
    }
}

/// Text field with monospace styling.
public struct AnvilTextField: View {
    @Environment(\.themeConfiguration) private var theme
    @Binding var text: String
    let placeholder: String
    let axis: Axis
    
    public init(
        _ placeholder: String,
        text: Binding<String>,
        axis: Axis = .horizontal
    ) {
        self.placeholder = placeholder
        self._text = text
        self.axis = axis
    }
    
    public var body: some View {
        TextField(placeholder, text: $text, axis: axis)
            .font(Typography.monospacedSmall)
            .padding(.vertical, theme.density.verticalPadding / 2)
            .padding(.horizontal, theme.density.horizontalPadding / 2)
            .background(Colors.tertiaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm))
    }
}

/// Secure field with monospace styling.
public struct AnvilSecureField: View {
    @Environment(\.themeConfiguration) private var theme
    @Binding var text: String
    let placeholder: String
    
    public init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        SecureField(placeholder, text: $text)
            .font(Typography.monospacedSmall)
            .padding(.vertical, theme.density.verticalPadding / 2)
            .padding(.horizontal, theme.density.horizontalPadding / 2)
            .background(Colors.tertiaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm))
    }
}