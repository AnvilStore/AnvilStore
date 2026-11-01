// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import Foundation

/// A source repository (AltStore-compatible).
public struct Source: Identifiable, Codable, Hashable, Sendable {
    public let id: UUID
    public var name: String
    public var url: URL
    public var isEnabled: Bool
    public var lastFetched: Date?
    public var lastError: String?
    public var apps: [SourceApp]
    
    public init(
        id: UUID = UUID(),
        name: String,
        url: URL,
        isEnabled: Bool = true,
        lastFetched: Date? = nil,
        lastError: String? = nil,
        apps: [SourceApp] = []
    ) {
        self.id = id
        self.name = name
        self.url = url
        self.isEnabled = isEnabled
        self.lastFetched = lastFetched
        self.lastError = lastError
        self.apps = apps
    }
}

/// An app within a source.
public struct SourceApp: Identifiable, Codable, Hashable, Sendable {
    public let id: String // bundle ID + version
    public let bundleID: String
    public let name: String
    public let version: String
    public let versionDate: Date
    public let size: Int64
    public let iconURL: URL?
    public let downloadURL: URL
    public let description: String?
    public let changelog: String?
    public let minimumOSVersion: String?
    public let developerName: String?
    public let category: String?
    public let screenshots: [URL]?
    public let tintColor: String?
    
    public init(
        id: String,
        bundleID: String,
        name: String,
        version: String,
        versionDate: Date,
        size: Int64,
        iconURL: URL?,
        downloadURL: URL,
        description: String? = nil,
        changelog: String? = nil,
        minimumOSVersion: String? = nil,
        developerName: String? = nil,
        category: String? = nil,
        screenshots: [URL]? = nil,
        tintColor: String? = nil
    ) {
        self.id = id
        self.bundleID = bundleID
        self.name = name
        self.version = version
        self.versionDate = versionDate
        self.size = size
        self.iconURL = iconURL
        self.downloadURL = downloadURL
        self.description = description
        self.changelog = changelog
        self.minimumOSVersion = minimumOSVersion
        self.developerName = developerName
        self.category = category
        self.screenshots = screenshots
        self.tintColor = tintColor
    }
}

/// A version entry for version history.
public struct AppVersion: Identifiable, Codable, Hashable, Sendable {
    public let id: String // bundleID + version
    public let bundleID: String
    public let version: String
    public let versionDate: Date
    public let size: Int64
    public let downloadURL: URL
    public let changelog: String?
    
    public init(
        id: String,
        bundleID: String,
        version: String,
        versionDate: Date,
        size: Int64,
        downloadURL: URL,
        changelog: String? = nil
    ) {
        self.id = id
        self.bundleID = bundleID
        self.version = version
        self.versionDate = versionDate
        self.size = size
        self.downloadURL = downloadURL
        self.changelog = changelog
    }
}

/// Source index JSON structure (AltStore format).
public struct SourceIndex: Codable, Sendable {
    public let name: String
    public let identifier: String
    public let description: String?
    public let iconURL: URL?
    public let website: URL?
    public let apps: [SourceIndexApp]
    public let news: [SourceNewsItem]?
    
    public init(
        name: String,
        identifier: String,
        description: String? = nil,
        iconURL: URL? = nil,
        website: URL? = nil,
        apps: [SourceIndexApp],
        news: [SourceNewsItem]? = nil
    ) {
        self.name = name
        self.identifier = identifier
        self.description = description
        self.iconURL = iconURL
        self.website = website
        self.apps = apps
        self.news = news
    }
}

public struct SourceIndexApp: Codable, Sendable {
    public let bundleIdentifier: String
    public let name: String
    public let developerName: String?
    public let subtitle: String?
    public let localizedDescription: String?
    public let iconURL: URL?
    public let tintColor: String?
    public let category: String?
    public let versions: [SourceIndexAppVersion]
    public let screenshots: [URL]?
    public let appPermissions: AppPermissions?
    
    public init(
        bundleIdentifier: String,
        name: String,
        developerName: String? = nil,
        subtitle: String? = nil,
        localizedDescription: String? = nil,
        iconURL: URL? = nil,
        tintColor: String? = nil,
        category: String? = nil,
        versions: [SourceIndexAppVersion],
        screenshots: [URL]? = nil,
        appPermissions: AppPermissions? = nil
    ) {
        self.bundleIdentifier = bundleIdentifier
        self.name = name
        self.developerName = developerName
        self.subtitle = subtitle
        self.localizedDescription = localizedDescription
        self.iconURL = iconURL
        self.tintColor = tintColor
        self.category = category
        self.versions = versions
        self.screenshots = screenshots
        self.appPermissions = appPermissions
    }
}

public struct SourceIndexAppVersion: Codable, Sendable {
    public let version: String
    public let date: String // ISO8601
    public let size: Int64
    public let downloadURL: String
    public let minOSVersion: String?
    public let localizedDescription: String?
    
    public init(
        version: String,
        date: String,
        size: Int64,
        downloadURL: String,
        minOSVersion: String? = nil,
        localizedDescription: String? = nil
    ) {
        self.version = version
        self.date = date
        self.size = size
        self.downloadURL = downloadURL
        self.minOSVersion = minOSVersion
        self.localizedDescription = localizedDescription
    }
}

public struct SourceNewsItem: Codable, Sendable {
    public let identifier: String
    public let title: String
    public let caption: String?
    public let date: String // ISO8601
    public let tintColor: String?
    public let imageURL: URL?
    public let notify: Bool?
    public let url: URL?
    
    public init(
        identifier: String,
        title: String,
        caption: String? = nil,
        date: String,
        tintColor: String? = nil,
        imageURL: URL? = nil,
        notify: Bool? = nil,
        url: URL? = nil
    ) {
        self.identifier = identifier
        self.title = title
        self.caption = caption
        self.date = date
        self.tintColor = tintColor
        self.imageURL = imageURL
        self.notify = notify
        self.url = url
    }
}

public struct AppPermissions: Codable, Sendable {
    public let entitlements: [String]?
    public let privacy: [String: String]?
    
    public init(entitlements: [String]? = nil, privacy: [String: String]? = nil) {
        self.entitlements = entitlements
        self.privacy = privacy
    }
}