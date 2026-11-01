// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import Foundation
import Alamofire

/// Errors specific to source operations.
public enum SourceError: LocalizedError, Sendable {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case indexMissing
    case appNotFound(String)
    case downloadFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid source URL"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from source"
        case .decodingError(let error):
            return "Failed to parse source data: \(error.localizedDescription)"
        case .indexMissing:
            return "Source index not found"
        case .appNotFound(let bundleID):
            return "App not found: \(bundleID)"
        case .downloadFailed(let error):
            return "Download failed: \(error.localizedDescription)"
        }
    }
}

/// Service for fetching and managing sources.
@MainActor
public final class SourceService: ObservableObject, Sendable {
    @Published public private(set) var sources: [Source] = []
    @Published public private(set) var isFetching = false
    @Published public private(set) var lastError: SourceError?
    
    private let session: Session
    private let decoder: JSONDecoder
    
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 120
        self.session = Session(configuration: configuration)
        
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    /// Add a new source by URL.
    public func addSource(url: URL, name: String? = nil) async throws -> Source {
        // Validate URL format
        guard url.scheme == "https" else {
            throw SourceError.invalidURL
        }
        
        // Fetch index to validate
        let index = try await fetchIndex(from: url)
        
        let sourceName = name ?? index.name
        let source = Source(
            name: sourceName,
            url: url,
            apps: index.apps.map { app in
                // Convert index app to source app (latest version)
                let latestVersion = app.versions.max { v1, v2 in
                    guard let d1 = ISO8601DateFormatter().date(from: v1.date),
                          let d2 = ISO8601DateFormatter().date(from: v2.date) else {
                        return false
                    }
                    return d1 < d2
                }
                
                return SourceApp(
                    id: "\(app.bundleIdentifier)@\(latestVersion?.version ?? "unknown")",
                    bundleID: app.bundleIdentifier,
                    name: app.name,
                    version: latestVersion?.version ?? "unknown",
                    versionDate: ISO8601DateFormatter().date(from: latestVersion?.date ?? "") ?? Date(),
                    size: latestVersion?.size ?? 0,
                    iconURL: app.iconURL,
                    downloadURL: URL(string: latestVersion?.downloadURL ?? "") ?? url,
                    description: app.localizedDescription,
                    changelog: latestVersion?.localizedDescription,
                    minimumOSVersion: latestVersion?.minOSVersion,
                    developerName: app.developerName,
                    category: app.category,
                    screenshots: app.screenshots,
                    tintColor: app.tintColor
                )
            }
        )
        
        sources.append(source)
        return source
    }
    
    /// Remove a source.
    public func removeSource(id: UUID) {
        sources.removeAll { $0.id == id }
    }
    
    /// Toggle source enabled state.
    public func toggleSource(id: UUID) {
        guard let index = sources.firstIndex(where: { $0.id == id }) else { return }
        sources[index].isEnabled.toggle()
    }
    
    /// Refresh a single source.
    public func refreshSource(id: UUID) async {
        guard let index = sources.firstIndex(where: { $0.id == id }) else { return }
        guard sources[index].isEnabled else { return }
        
        isFetching = true
        defer { isFetching = false }
        
        do {
            let index = try await fetchIndex(from: sources[index].url)
            
            let updatedApps = index.apps.map { app in
                let latestVersion = app.versions.max { v1, v2 in
                    guard let d1 = ISO8601DateFormatter().date(from: v1.date),
                          let d2 = ISO8601DateFormatter().date(from: v2.date) else {
                        return false
                    }
                    return d1 < d2
                }
                
                return SourceApp(
                    id: "\(app.bundleIdentifier)@\(latestVersion?.version ?? "unknown")",
                    bundleID: app.bundleIdentifier,
                    name: app.name,
                    version: latestVersion?.version ?? "unknown",
                    versionDate: ISO8601DateFormatter().date(from: latestVersion?.date ?? "") ?? Date(),
                    size: latestVersion?.size ?? 0,
                    iconURL: app.iconURL,
                    downloadURL: URL(string: latestVersion?.downloadURL ?? "") ?? sources[index].url,
                    description: app.localizedDescription,
                    changelog: latestVersion?.localizedDescription,
                    minimumOSVersion: latestVersion?.minOSVersion,
                    developerName: app.developerName,
                    category: app.category,
                    screenshots: app.screenshots,
                    tintColor: app.tintColor
                )
            }
            
            sources[index].apps = updatedApps
            sources[index].lastFetched = Date()
            sources[index].lastError = nil
            
        } catch {
            sources[index].lastError = error.localizedDescription
            lastError = error as? SourceError ?? .networkError(error)
        }
    }
    
    /// Refresh all enabled sources.
    public func refreshAllSources() async {
        for source in sources where source.isEnabled {
            await refreshSource(id: source.id)
        }
    }
    
    /// Get all apps across all sources.
    public var allApps: [SourceApp] {
        sources.flatMap { $0.apps }
    }
    
    /// Get versions for a specific bundle ID.
    public func versions(for bundleID: String) -> [AppVersion] {
        var versions: [AppVersion] = []
        
        for source in sources {
            for app in source.apps where app.bundleID == bundleID {
                // Would need to fetch full version list from index
                // For now, return the latest
                versions.append(AppVersion(
                    id: app.id,
                    bundleID: app.bundleID,
                    version: app.version,
                    versionDate: app.versionDate,
                    size: app.size,
                    downloadURL: app.downloadURL,
                    changelog: app.changelog
                ))
            }
        }
        
        return versions.sorted { $0.versionDate > $1.versionDate }
    }
    
    // MARK: - Private
    
    private func fetchIndex(from url: URL) async throws -> SourceIndex {
        let indexURL = url.appendingPathComponent("index.json")
        
        let response = try await session.request(indexURL)
            .validate()
            .serializingDecodable(SourceIndex.self, decoder: decoder)
            .value
        
        return response
    }
}