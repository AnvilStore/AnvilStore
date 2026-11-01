// AnvilStore — on-device iOS sideloading workstation
// SPDX-License-Identifier: AGPL-3.0-only

import XCTest
@testable import AnvilSources

final class AnvilSourcesTests: XCTestCase {
    func testSourceModel() {
        let source = Source(
            name: "Test Repo",
            url: URL(string: "https://example.com/repo")!,
            apps: []
        )
        
        XCTAssertEqual(source.name, "Test Repo")
        XCTAssertEqual(source.url.absoluteString, "https://example.com/repo")
        XCTAssertTrue(source.isEnabled)
        XCTAssertTrue(source.apps.isEmpty)
    }
    
    func testSourceAppModel() {
        let app = SourceApp(
            id: "com.test.app@1.0.0",
            bundleID: "com.test.app",
            name: "Test App",
            version: "1.0.0",
            versionDate: Date(),
            size: 1024 * 1024,
            iconURL: URL(string: "https://example.com/icon.png"),
            downloadURL: URL(string: "https://example.com/app.ipa")!,
            description: "A test app"
        )
        
        XCTAssertEqual(app.bundleID, "com.test.app")
        XCTAssertEqual(app.version, "1.0.0")
        XCTAssertEqual(app.size, 1024 * 1024)
    }
    
    func testSourceIndexDecoding() throws {
        let json = """
        {
            "name": "Test Repo",
            "identifier": "com.test.repo",
            "apps": [
                {
                    "bundleIdentifier": "com.test.app",
                    "name": "Test App",
                    "versions": [
                        {
                            "version": "1.0.0",
                            "date": "2024-01-01T00:00:00Z",
                            "size": 1048576,
                            "downloadURL": "https://example.com/app.ipa"
                        }
                    ]
                }
            ]
        }
        """
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let index = try decoder.decode(SourceIndex.self, from: json.data(using: .utf8)!)
        
        XCTAssertEqual(index.name, "Test Repo")
        XCTAssertEqual(index.identifier, "com.test.repo")
        XCTAssertEqual(index.apps.count, 1)
        XCTAssertEqual(index.apps[0].bundleIdentifier, "com.test.app")
        XCTAssertEqual(index.apps[0].versions.count, 1)
    }
    
    func testSourceErrorDescriptions() {
        XCTAssertEqual(SourceError.invalidURL.errorDescription, "Invalid source URL")
        XCTAssertEqual(SourceError.indexMissing.errorDescription, "Source index not found")
        XCTAssertEqual(SourceError.appNotFound("com.test").errorDescription, "App not found: com.test")
    }
}