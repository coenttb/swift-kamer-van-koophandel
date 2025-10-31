//import Foundation
//import Testing
//import Dependencies
//import DependenciesMacros
//import Kamer_van_Koophandel_Models
//import Kamer_van_Koophandel_Shared
//@testable import Zoeken_V1
//
//@Suite(
//    "Zoeken V1 Client Tests",
//    .dependency(TestStrategy.local)
//)
//struct ZoekenV1ClientTests {
//
//    @Test("Should successfully search with KvK number")
//    func testSearchByKvKNumber() async throws {
//        @Dependency(AuthenticatedClient.self) var client
//        @Dependency(TestStrategy.self) var testStrategy
//        print("testStrategy", testStrategy)
//
//        let response = try await client.search(
//            kvkNummer: "59581883",
//            rsin: nil,
//            vestigingsnummer: nil,
//            handelsnaam: nil,
//            straatnaam: nil,
//            plaats: nil,
//            postcode: nil,
//            huisnummer: nil,
//            huisnummerToevoeging: nil,
//            type: nil,
//            inclusiefInactieveRegistraties: nil,
//            pagina: nil,
//            aantal: nil
//        )
//
//        #expect(response.pagina == 1)
//        #expect(response.aantal == 10)
//        #expect(response.totaal >= 1)
//
//        let firstResult = try #require(response.resultaten.first)
//        #expect(firstResult.kvkNummer == "59581883")
//        #expect(firstResult.handelsnaam == "Kamer van Koophandel Utrecht")
//        #expect(firstResult.type == "hoofdvestiging")
//        #expect(firstResult.actief == "Ja")
//    }
//
//    @Test("Should successfully search by location")
//    func testSearchByLocation() async throws {
//        @Dependency(AuthenticatedClient.self) var client
//
//        let response = try await client.search(
//            kvkNummer: nil,
//            rsin: nil,
//            vestigingsnummer: nil,
//            handelsnaam: nil,
//            straatnaam: "St.-Jacobsstraat",
//            plaats: "Utrecht",
//            postcode: nil,
//            huisnummer: nil,
//            huisnummerToevoeging: nil,
//            type: nil,
//            inclusiefInactieveRegistraties: nil,
//            pagina: nil,
//            aantal: nil
//        )
//
//        #expect(response.pagina == 1)
//        #expect(response.aantal == 10)
//        #expect(response.totaal >= 1)
//
//        // At least one result should contain our search parameters
//        let hasMatch = response.resultaten.contains { result in
//            result.straatnaam?.contains("St.-Jacobsstraat") == true &&
//            result.plaats == "Utrecht"
//        }
//        #expect(hasMatch)
//    }
//
//    @Test("Should successfully search with pagination")
//    func testPagination() async throws {
//        @Dependency(AuthenticatedClient.self) var client
//
//        let response1 = try await client.search(
//            kvkNummer: nil,
//            rsin: nil,
//            vestigingsnummer: nil,
//            handelsnaam: "Test",
//            straatnaam: nil,
//            plaats: nil,
//            postcode: nil,
//            huisnummer: nil,
//            huisnummerToevoeging: nil,
//            type: nil,
//            inclusiefInactieveRegistraties: nil,
//            pagina: 1,
//            aantal: 5
//        )
//
//        #expect(response1.pagina == 1)
//        #expect(response1.aantal == 5)
//
//        let response2 = try await client.search(
//            kvkNummer: nil,
//            rsin: nil,
//            vestigingsnummer: nil,
//            handelsnaam: "Test",
//            straatnaam: nil,
//            plaats: nil,
//            postcode: nil,
//            huisnummer: nil,
//            huisnummerToevoeging: nil,
//            type: nil,
//            inclusiefInactieveRegistraties: nil,
//            pagina: 2,
//            aantal: 5
//        )
//
//        #expect(response2.pagina == 2)
//        #expect(response2.aantal == 5)
//
//        // Results should be different
//        if !response1.resultaten.isEmpty && !response2.resultaten.isEmpty {
//            #expect(response1.resultaten[0].kvkNummer != response2.resultaten[0].kvkNummer)
//        }
//    }
//
//    @Test("Should handle invalid KvK number")
//    func testInvalidKvKNumber() async throws {
//        @Dependency(AuthenticatedClient.self) var client
//
//        await #expect(throws: Error.self) {
//            _ = try await client.search(
//                kvkNummer: "00000000",
//                rsin: nil,
//                vestigingsnummer: nil,
//                handelsnaam: nil,
//                straatnaam: nil,
//                plaats: nil,
//                postcode: nil,
//                huisnummer: nil,
//                huisnummerToevoeging: nil,
//                type: nil,
//                inclusiefInactieveRegistraties: nil,
//                pagina: nil,
//                aantal: nil
//            )
//        }
//    }
//
//    @Test("Should handle combined search parameters")
//    func testCombinedSearch() async throws {
//        @Dependency(AuthenticatedClient.self) var client
//
//        let response = try await client.search(
//            kvkNummer: nil,
//            rsin: nil,
//            vestigingsnummer: nil,
//            handelsnaam: "Test",
//            straatnaam: nil,
//            plaats: "Amsterdam",
//            postcode: nil,
//            huisnummer: nil,
//            huisnummerToevoeging: nil,
//            type: "hoofdvestiging",
//            inclusiefInactieveRegistraties: false,
//            pagina: 1,
//            aantal: 10
//        )
//
//        #expect(response.pagina == 1)
//        #expect(response.aantal == 10)
//
//        // All results should match our search criteria
//        for result in response.resultaten {
//            #expect(result.handelsnaam.localizedCaseInsensitiveContains("Test"))
//            #expect(result.plaats == "Amsterdam")
//            #expect(result.type == "hoofdvestiging")
//            #expect(result.actief == "Ja")
//        }
//    }
//}
