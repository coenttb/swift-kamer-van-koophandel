//
//  Basisprofiel Client Tests.swift
//  coenttb-kvk
//
//  Created by Assistant on 10/01/2025.
//

import Foundation
import Testing
import Dependencies
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared
@testable import Basisprofielen

@Suite(
    "Basisprofiel Client Tests",
    .dependency(TestStrategy.liveTest)
)
struct BasisprofielClientTests {
    
    let validKvKNumber = Basisprofiel.kvk.kvkNummer
    let invalidKvKNumber = Kamer_van_Koophandel_Models.Number("99999999")
    
    @Test("Successfully retrieves basisprofiel")
    func testGetBasisprofiel() async throws {
        @Dependency(AuthenticatedClient.self) var client
        @Dependency(TestStrategy.self) var testStrategy
        print(testStrategy)
        #expect(try await client.get(validKvKNumber, nil).kvkNummer == Basisprofiel.kvk.kvkNummer)
    }
    
    @Test("Successfully retrieves eigenaar")
    func testGetEigenaar() async throws {
        @Dependency(AuthenticatedClient.self) var client
        #expect(try await client.getEigenaar(validKvKNumber, nil).rsin == Basisprofiel.Eigenaar.kvk.rsin)
    }

    @Test("Successfully retrieves hoofdvestiging")
    func testGetHoofdvestiging() async throws {
        @Dependency(AuthenticatedClient.self) var client
        
        #expect(try await client.getHoofdvestiging(validKvKNumber, nil).vestigingsnummer == Basisprofiel.Vestiging.kvkHoofdVestiging.vestigingsnummer)
    }
    
    @Test("Successfully retrieves vestigingen list")
    func testGetVestigingen() async throws {
        @Dependency(AuthenticatedClient.self) var client
        
        let vestigingen = try await client.getVestigingen(validKvKNumber)
        
        // Verify list metadata
        #expect(vestigingen.kvkNummer == validKvKNumber)
    }
    
    @Test("Handles errors correctly when KvK number not found")
    func testHandlesNotFound() async throws {
        @Dependency(AuthenticatedClient.self) var client
        
        // Test all endpoints with invalid KvK number
        await #expect(throws: Error.self) {
            try await client.get(invalidKvKNumber, nil)
        }
        
        await #expect(throws: Error.self) {
            try await client.getEigenaar(invalidKvKNumber, nil)
        }
        
        await #expect(throws: Error.self) {
            try await client.getHoofdvestiging(invalidKvKNumber, nil)
        }
        
        await #expect(throws: Error.self) {
            try await client.getVestigingen(invalidKvKNumber)
        }
    }
}
