// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import SwiftUI
import AnvilUI
import AnvilTheme

/// Main sources list view.
public struct SourcesView: View {
    @Environment(\.themeConfiguration) private var theme
    @StateObject private var service = SourceService()
    @State private var showingAddSource = false
    @State private var showingError: SourceError?
    
    public init() {}
    
    public var body: some View {
        AnvilNavigationStack {
            AnvilScreen("Sources") {
                if service.sources.isEmpty {
                    AnvilEmptyState(
                        icon: "square.grid.3x3",
                        title: "No Sources",
                        message: "Add a source repository to browse apps.",
                        action: { showingAddSource = true },
                        actionTitle: "Add Source"
                    )
                } else {
                    VStack(spacing: theme.density.itemSpacing) {
                        ForEach(service.sources) { source in
                            NavigationLink {
                                SourceAppsView(source: source, service: service)
                            } label: {
                                SourceRow(source: source, service: service)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            } toolbar: {
                AnvilButton("Add", role: .plain) { showingAddSource = true }
            }
        }
        .sheet(isPresented: $showingAddSource) {
            AddSourceView(service: service)
        }
        .alert("Error", isPresented: .constant(showingError != nil), presenting: showingError) { _ in
            Button("OK") { showingError = nil }
        } message: { error in
            Text(error.localizedDescription)
        }
        .task {
            await service.refreshAllSources()
        }
        .refreshable {
            await service.refreshAllSources()
        }
    }
}

/// Individual source row.
private struct SourceRow: View {
    @Environment(\.themeConfiguration) private var theme
    let source: Source
    @ObservedObject var service: SourceService
    
    var body: some View {
        AnvilCard {
            VStack(alignment: .leading, spacing: theme.density.sm) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(source.name)
                            .font(Typography.headline)
                            .foregroundStyle(Colors.primaryText)
                        
                        Text(source.url.host ?? "")
                            .font(Typography.monospacedSmall)
                            .foregroundStyle(Colors.tertiaryText)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        AnvilBadge(
                            source.isEnabled ? "Enabled" : "Disabled",
                            kind: source.isEnabled ? .success : .neutral
                        )
                        
                        if let lastFetched = source.lastFetched {
                            Text(lastFetched, style: .relative)
                                .font(Typography.monospacedSmall)
                                .foregroundStyle(Colors.tertiaryText)
                        }
                    }
                }
                
                if let error = source.lastError {
                    AnvilBadge(error, kind: .error)
                        .lineLimit(1)
                }
                
                HStack {
                    Text("\(source.apps.count) apps")
                        .font(Typography.monospacedSmall)
                        .foregroundStyle(Colors.secondaryText)
                    
                    Spacer()
                    
                    AnvilButton(
                        source.isEnabled ? "Refresh" : "Enable",
                        role: .secondary
                    ) {
                        if source.isEnabled {
                            Task { await service.refreshSource(id: source.id) }
                        } else {
                            service.toggleSource(id: source.id)
                        }
                    }
                    .frame(width: 100)
                }
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                service.removeSource(id: source.id)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            Button {
                service.toggleSource(id: source.id)
            } label: {
                Label(source.isEnabled ? "Disable" : "Enable", systemImage: source.isEnabled ? "pause.circle" : "play.circle")
            }
            .tint(source.isEnabled ? .orange : .green)
        }
    }
}

/// Apps list for a source.
private struct SourceAppsView: View {
    @Environment(\.themeConfiguration) private var theme
    let source: Source
    @ObservedObject var service: SourceService
    @State private var searchText = ""
    
    var filteredApps: [SourceApp] {
        if searchText.isEmpty {
            return source.apps
        }
        return source.apps.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.bundleID.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        AnvilScreen(source.name) {
            AnvilSection {
                ForEach(filteredApps) { app in
                    NavigationLink {
                        AppDetailView(app: app, service: service)
                    } label: {
                        AppRow(app: app)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search apps")
        .refreshable {
            await service.refreshSource(id: source.id)
        }
    }
}

/// App row in source list.
private struct AppRow: View {
    @Environment(\.themeConfiguration) private var theme
    let app: SourceApp
    
    var body: some View {
        AnvilCard {
            HStack(spacing: theme.density.md) {
                // Icon
                AsyncImage(url: app.iconURL) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "app.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(Colors.tertiaryText)
                    default:
                        ProgressView()
                            .frame(width: 40, height: 40)
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md))
                .background(Colors.tertiaryBackground)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(app.name)
                        .font(Typography.body.weight(.medium))
                        .foregroundStyle(Colors.primaryText)
                        .lineLimit(1)
                    
                    Text(app.bundleID)
                        .font(Typography.monospacedSmall)
                        .foregroundStyle(Colors.tertiaryText)
                        .lineLimit(1)
                    
                    HStack(spacing: theme.density.sm) {
                        AnvilBadge(app.version, kind: .info)
                        
                        Text(ByteCountFormatter.string(fromByteCount: app.size, countStyle: .file))
                            .font(Typography.monospacedSmall)
                            .foregroundStyle(Colors.tertiaryText)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Colors.tertiaryText)
            }
        }
    }
}

/// App detail view with version history.
private struct AppDetailView: View {
    @Environment(\.themeConfiguration) private var theme
    let app: SourceApp
    @ObservedObject var service: SourceService
    @State private var versions: [AppVersion] = []
    @State private var showingInstall = false
    @State private var installVersion: AppVersion?
    
    var body: some View {
        AnvilScreen(app.name) {
            VStack(spacing: theme.density.lg) {
                // Header
                AnvilCard {
                    HStack(spacing: theme.density.md) {
                        AsyncImage(url: app.iconURL) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable().aspectRatio(contentMode: .fit)
                            default:
                                Image(systemName: "app.fill")
                                    .font(.system(size: 48))
                                    .foregroundStyle(Colors.tertiaryText)
                            }
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(app.name)
                                .font(Typography.title)
                                .foregroundStyle(Colors.primaryText)
                            
                            Text(app.bundleID)
                                .font(Typography.monospacedSmall)
                                .foregroundStyle(Colors.tertiaryText)
                            
                            if let developer = app.developerName {
                                Text(developer)
                                    .font(Typography.caption)
                                    .foregroundStyle(Colors.secondaryText)
                            }
                        }
                        
                        Spacer()
                    }
                }
                
                // Metadata
                AnvilCard {
                    VStack(alignment: .leading, spacing: theme.density.sm) {
                        AnvilSectionHeader("Information")
                        
                        InfoRow("Version", value: app.version)
                        InfoRow("Size", value: ByteCountFormatter.string(fromByteCount: app.size, countStyle: .file))
                        if let minOS = app.minimumOSVersion {
                            InfoRow("Minimum iOS", value: minOS)
                        }
                        if let category = app.category {
                            InfoRow("Category", value: category)
                        }
                        InfoRow("Updated", value: app.versionDate.formatted(date: .abbreviated, time: .shortened))
                    }
                }
                
                // Description
                if let description = app.description {
                    AnvilCard {
                        VStack(alignment: .leading, spacing: theme.density.sm) {
                            AnvilSectionHeader("Description")
                            Text(description)
                                .font(Typography.body)
                                .foregroundStyle(Colors.primaryText)
                        }
                    }
                }
                
                // Version History
                AnvilCard {
                    VStack(alignment: .leading, spacing: theme.density.sm) {
                        HStack {
                            AnvilSectionHeader("Versions")
                            Spacer()
                            AnvilButton("Install", role: .primary) {
                                installVersion = versions.first { $0.version == app.version }
                                showingInstall = true
                            }
                            .frame(width: 100)
                        }
                        
                        ForEach(versions) { version in
                            VersionRow(
                                version: version,
                                isCurrent: version.version == app.version,
                                onInstall: {
                                    installVersion = version
                                    showingInstall = true
                                }
                            )
                        }
                    }
                }
            }
        }
        .task {
            versions = service.versions(for: app.bundleID)
        }
        .sheet(isPresented: $showingInstall) {
            if let version = installVersion {
                InstallConfirmationView(app: app, version: version)
            }
        }
    }
}

/// Version history row.
private struct VersionRow: View {
    @Environment(\.themeConfiguration) private var theme
    let version: AppVersion
    let isCurrent: Bool
    let onInstall: () -> Void
    
    var body: some View {
        AnvilRow {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: theme.density.sm) {
                    Text(version.version)
                        .font(Typography.monospacedSmall.weight(.medium))
                        .foregroundStyle(Colors.primaryText)
                    
                    if isCurrent {
                        AnvilBadge("Current", kind: .success)
                    }
                }
                
                Text(version.versionDate.formatted(date: .abbreviated, time: .shortened))
                    .font(Typography.monospacedSmall)
                    .foregroundStyle(Colors.tertiaryText)
            }
        } trailing: {
            AnvilButton("Install", role: isCurrent ? .secondary : .primary) {
                onInstall()
            }
            .frame(width: 80)
            .disabled(isCurrent)
        }
    }
}

/// Simple info row.
private struct InfoRow: View {
    @Environment(\.themeConfiguration) private var theme
    let label: String
    let value: String
    
    init(_ label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(label)
                .font(Typography.body)
                .foregroundStyle(Colors.secondaryText)
            Spacer()
            Text(value)
                .font(Typography.monospacedSmall)
                .foregroundStyle(Colors.primaryText)
        }
    }
}

/// Add source sheet.
private struct AddSourceView: View {
    @Environment(\.themeConfiguration) private var theme
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var service: SourceService
    @State private var urlString = ""
    @State private var name = ""
    @State private var isLoading = false
    @State private var error: SourceError?
    
    var body: some View {
        AnvilNavigationStack {
            AnvilScreen("Add Source") {
                VStack(spacing: theme.density.lg) {
                    AnvilCard {
                        VStack(alignment: .leading, spacing: theme.density.md) {
                            AnvilSectionHeader("Repository URL")
                            
                            AnvilTextField("https://example.com/repo", text: $urlString)
                            
                            AnvilSectionHeader("Name (optional)")
                            
                            AnvilTextField("Auto-detected from index", text: $name)
                        }
                    }
                    
                    if let error {
                        AnvilErrorState(
                            title: "Failed to Add Source",
                            message: error.localizedDescription,
                            retry: { Task { await addSource() } }
                        )
                    }
                    
                    AnvilButton("Add Source", role: .primary, isLoading: isLoading) {
                        await addSource()
                    }
                    .disabled(urlString.isEmpty || isLoading)
                }
            } toolbar: {
                AnvilButton("Cancel", role: .plain) { dismiss() }
            }
        }
    }
    
    private func addSource() async {
        guard let url = URL(string: urlString), url.scheme == "https" else {
            error = .invalidURL
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            _ = try await service.addSource(url: url, name: name.isEmpty ? nil : name)
            dismiss()
        } catch {
            self.error = error as? SourceError ?? .networkError(error)
        }
        
        isLoading = false
    }
}

/// Install confirmation view.
private struct InstallConfirmationView: View {
    @Environment(\.themeConfiguration) private var theme
    @Environment(\.dismiss) private var dismiss
    let app: SourceApp
    let version: AppVersion
    @State private var isInstalling = false
    @State private var installError: String?
    
    var body: some View {
        AnvilNavigationStack {
            AnvilScreen("Confirm Install") {
                VStack(spacing: theme.density.lg) {
                    AnvilCard {
                        VStack(alignment: .leading, spacing: theme.density.sm) {
                            HStack {
                                AsyncImage(url: app.iconURL) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image.resizable().aspectRatio(contentMode: .fit)
                                    default:
                                        Image(systemName: "app.fill")
                                            .font(.system(size: 40))
                                            .foregroundStyle(Colors.tertiaryText)
                                    }
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(app.name)
                                        .font(Typography.headline)
                                    Text(version.version)
                                        .font(Typography.monospacedSmall)
                                        .foregroundStyle(Colors.tertiaryText)
                                }
                            }
                        }
                    }
                    
                    AnvilCard {
                        VStack(alignment: .leading, spacing: theme.density.sm) {
                            AnvilSectionHeader("Details")
                            InfoRow("Bundle ID", value: app.bundleID)
                            InfoRow("Size", value: ByteCountFormatter.string(fromByteCount: version.size, countStyle: .file))
                            if let changelog = version.changelog {
                                AnvilDivider("Changelog")
                                Text(changelog)
                                    .font(Typography.body)
                                    .foregroundStyle(Colors.primaryText)
                            }
                        }
                    }
                    
                    if let error = installError {
                        AnvilErrorState(title: "Install Failed", message: error)
                    }
                    
                    VStack(spacing: theme.density.md) {
                        AnvilButton("Install", role: .primary, isLoading: isInstalling) {
                            await performInstall()
                        }
                        .disabled(isInstalling)
                        
                        AnvilButton("Cancel", role: .secondary) { dismiss() }
                            .disabled(isInstalling)
                    }
                }
            }
        }
    }
    
    private func performInstall() async {
        isInstalling = true
        installError = nil
        
        // TODO: Wire to AnvilInstall
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        isInstalling = false
        installError = "Install not yet implemented - wire to AnvilInstall module"
    }
}