//
//  Naamgeving Router Tests.swift
//  coenttb-kvk
//
//  Created by Assistant on 09/01/2025.
//

import Testing
import Dependencies
import DependenciesTestSupport
import Foundation
import URLRouting
import Kamer_van_Koophandel_Shared
@testable import Naamgevingen
@testable import Kamer_van_Koophandel_Models

@Suite(
    "Naamgeving Router Tests"
)
struct NaamgevingRouterTests {
    
    @Test("Creates correct URL for naamgeving retrieval")
    func testRetrieveNaamgevingURL() throws {
        @Dependency(API.Router.self) var router
        
        let kvkNummer: Kamer_van_Koophandel_Models.Number = "59581883"
        let url = router.url(for: .get(kvkNummer: kvkNummer))
        
        #expect(url.path == "/v1/naamgevingen/kvknummer/59581883")
        
        // Verify no query parameters
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        #expect(components?.queryItems == nil || components?.queryItems?.isEmpty == true)
    }
    
    @Test("Creates correct URL with different KvK numbers")
    func testDifferentKvKNumbers() throws {
        @Dependency(API.Router.self) var router
        
        // Test with various KvK number formats
        let testCases: [Kamer_van_Koophandel_Models.Number] = [
            "12345678",
            "00012345",
            "98765432",
            "11111111"
        ]
        
        for kvkNummer in testCases {
            let url = router.url(for: .get(kvkNummer: kvkNummer))
            #expect(url.path == "/v1/naamgevingen/kvknummer/\(kvkNummer)")
            
            // Verify path components
            let pathComponents = url.pathComponents
            #expect(pathComponents.contains("v1"))
            #expect(pathComponents.contains("naamgevingen"))
            #expect(pathComponents.contains("kvknummer"))
            #expect(pathComponents.contains(kvkNummer.description))
            
            // Verify order of path components
            #expect(pathComponents[1] == "v1")
            #expect(pathComponents[2] == "naamgevingen")
            #expect(pathComponents[3] == "kvknummer")
            #expect(pathComponents[4] == kvkNummer.description)
        }
    }
    
    @Test("URL maintains KvK number format")
    func testKvKNumberFormat() throws {
        @Dependency(API.Router.self) var router
        
        // Test with KvK numbers containing leading zeros
        let kvkNummer: Kamer_van_Koophandel_Models.Number = "00123456"
        let url = router.url(for: .get(kvkNummer: kvkNummer))
        
        #expect(url.path == "/v1/naamgevingen/kvknummer/00123456")
        #expect(url.pathComponents.last == "00123456", "Leading zeros should be preserved")
    }
}
