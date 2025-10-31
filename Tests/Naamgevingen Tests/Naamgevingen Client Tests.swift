//
//  Naamgeving Client Tests.swift
//  coenttb-kvk
//
//  Created by Assistant on 09/01/2025.
//

import Dependencies
import DependenciesTestSupport
import EnvironmentVariables
import Foundation
import IssueReporting
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared
@testable import Naamgevingen
import Testing

@Suite(
    "Naamgeving Client Tests",
    .dependency(TestStrategy.liveTest)
)
struct NaamgevingClientTests {
    @Test("Should successfully retrieve naamgeving for KvK")
    func testRetrieveKvKNaamgeving() async throws {
        @Dependency(AuthenticatedClient.self) var client
        @Dependency(TestStrategy.self) var testStrategy
        print("testStrategy", testStrategy)

        let response = try await client.get("59581883")

        #expect(response.kvkNummer == "59581883")
        #expect(response.rsin == "823807071")
        #expect(response.statutaireNaam == "Kamer van Koophandel")
        #expect(response.naam == "Kamer van Koophandel")
//        #expect(response.startdatum == "20140102")
        #expect(response.einddatum == nil)

        // Verify vestigingen
        let vestigingen = try #require(response.vestigingen)
        let count: Int = switch testStrategy {
        case .local: 2
        case .liveTest: 1
        case .live: 17
        }

        #expect(vestigingen.count == count)

    }

    @Test("Should successfully retrieve naamgeving for test company")
    func testRetrieveTestNaamgeving() async throws {
        @Dependency(AuthenticatedClient.self) var client
        @Dependency(TestStrategy.self) var testStrategy
        print("testStrategy", testStrategy)

        let response = try await client.get("68750110")

        let rsin: String? = switch testStrategy {
        case .local: "857587973"
        case .liveTest: "857587973"
        case .live: nil
        }

        let statutaireNaam: String? = switch testStrategy {
        case .local: "Test BV Donald"
        case .liveTest: "Test BV Donald"
        case .live: nil
        }

        let naam: String? = switch testStrategy {
        case .local: "Test BV Donald"
        case .liveTest: "Test BV Donald"
        case .live: "Bikerfix"
        }

        let startdatum: String? = switch testStrategy {
        case .local: "20220421"
        case .liveTest: "20170519"
        case .live: "20170519"
        }

        #expect(response.kvkNummer == "68750110")
        #expect(response.rsin == rsin)
        #expect(response.statutaireNaam == statutaireNaam)
        #expect(response.naam == naam)
        #expect(response.ookGenoemd == nil)
        #expect(response.startdatum == startdatum)
        #expect(response.einddatum == nil)

        // Verify vestigingen
        let vestigingen = try #require(response.vestigingen)

        let count: Int? = switch testStrategy {
        case .local: 2
        case .liveTest: 2
        case .live: 1
        }

        #expect(vestigingen.count == count)
//
//        // Verify commerciele vestiging
//        if case let .commercieel(commercieel) = vestigingen[0] {
//            #expect(commercieel.vestigingsnummer == "000012345678")
//            #expect(commercieel.eersteHandelsnaam == "Test Bedrijf Amsterdam")
//            #expect(commercieel.handelsnamen.count == 2)
//            #expect(commercieel.handelsnamen[0].naam == "Test Bedrijf Amsterdam")
//            #expect(commercieel.handelsnamen[1].naam == "TB Amsterdam")
//        } else {
//            throw TestFailure("Vestiging should be commercieel")
//        }
//        
//        // Verify links
//        #expect(response.links.`self`.href == "https://api.kvk.nl/api/v1/naamgevingen/12345678")
//        #expect(response.links.basisprofiel.href == "https://api.kvk.nl/api/v1/basisprofielen/12345678")
    }

    @Test("Should handle non-existent KvK number")
    func testNonExistentKvKNumber() async throws {
        @Dependency(AuthenticatedClient.self) var client
        @Dependency(TestStrategy.self) var testStrategy
        print("testStrategy", testStrategy)

        await #expect(throws: Error.self) {
            _ = try await client.get("00000000")
        }
    }
}

struct TestFailure: Swift.Error {
    let message: String

    public init(_ message: String) {
        self.message = message
    }
}
