import Testing
import Dependencies
import DependenciesTestSupport
import Foundation
import URLRouting
import Kamer_van_Koophandel_Shared
@testable import Zoeken_V1
@testable import Kamer_van_Koophandel_Models

@Suite("Zoeken V1 Router Tests")
struct ZoekenV1RouterTests {
    
    @Test("Creates correct URL for KvK number search")
    func testKvKNumberSearchURL() throws {
        @Dependency(APIV1.Router.self) var router
        
        let kvkNummer: Kamer_van_Koophandel_Models.Number = "59581883"
        let url = router.url(for: .search(
            kvkNummer: kvkNummer,
            rsin: nil,
            vestigingsnummer: nil,
            handelsnaam: nil,
            straatnaam: nil,
            plaats: nil,
            postcode: nil,
            huisnummer: nil,
            huisnummerToevoeging: nil,
            type: nil,
            inclusiefInactieveRegistraties: nil,
            pagina: nil,
            aantal: nil
        ))
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let kvkParam = components?.queryItems?.first(where: { $0.name == "kvkNummer" })
        
        #expect(kvkParam?.value == "59581883")
        #expect(url.path == "/v1/zoeken")
    }
    
    @Test("Creates correct URL with multiple search parameters")
    func testMultipleParametersURL() throws {
        @Dependency(APIV1.Router.self) var router
        
        let url = router.url(for: .search(
            kvkNummer: nil,
            rsin: nil,
            vestigingsnummer: nil,
            handelsnaam: "Test Company",
            straatnaam: "Test Street",
            plaats: "Amsterdam",
            postcode: "1234AB",
            huisnummer: 42,
            huisnummerToevoeging: "A",
            type: "hoofdvestiging",
            inclusiefInactieveRegistraties: true,
            pagina: 2,
            aantal: 20
        ))
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = try #require(components?.queryItems)
        
        // Verify all parameters are present and correctly formatted
        #expect(queryItems.contains(where: { $0.name == "handelsnaam" && $0.value == "Test Company" }))
        #expect(queryItems.contains(where: { $0.name == "straatnaam" && $0.value == "Test Street" }))
        #expect(queryItems.contains(where: { $0.name == "plaats" && $0.value == "Amsterdam" }))
        #expect(queryItems.contains(where: { $0.name == "postcode" && $0.value == "1234AB" }))
        #expect(queryItems.contains(where: { $0.name == "huisnummer" && $0.value == "42" }))
        #expect(queryItems.contains(where: { $0.name == "huisnummerToevoeging" && $0.value == "A" }))
        #expect(queryItems.contains(where: { $0.name == "type" && $0.value == "hoofdvestiging" }))
        #expect(queryItems.contains(where: { $0.name == "InclusiefInactieveRegistraties" && $0.value == "true" }))
        #expect(queryItems.contains(where: { $0.name == "pagina" && $0.value == "2" }))
        #expect(queryItems.contains(where: { $0.name == "aantal" && $0.value == "20" }))
    }
    
    @Test("Creates correct URL with pagination parameters")
    func testPaginationURL() throws {
        @Dependency(APIV1.Router.self) var router
        
        let url = router.url(for: .search(
            kvkNummer: nil,
            rsin: nil,
            vestigingsnummer: nil,
            handelsnaam: nil,
            straatnaam: nil,
            plaats: nil,
            postcode: nil,
            huisnummer: nil,
            huisnummerToevoeging: nil,
            type: nil,
            inclusiefInactieveRegistraties: nil,
            pagina: 5,
            aantal: 50
        ))
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = try #require(components?.queryItems)
        
        #expect(queryItems.contains(where: { $0.name == "pagina" && $0.value == "5" }))
        #expect(queryItems.contains(where: { $0.name == "aantal" && $0.value == "50" }))
    }
    
    @Test("Creates correct URL with RSIN parameter")
    func testRSINSearchURL() throws {
        @Dependency(APIV1.Router.self) var router
        
        let url = router.url(for: .search(
            kvkNummer: nil,
            rsin: "823807071",
            vestigingsnummer: nil,
            handelsnaam: nil,
            straatnaam: nil,
            plaats: nil,
            postcode: nil,
            huisnummer: nil,
            huisnummerToevoeging: nil,
            type: nil,
            inclusiefInactieveRegistraties: nil,
            pagina: nil,
            aantal: nil
        ))
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let rsinParam = components?.queryItems?.first(where: { $0.name == "rsin" })
        
        #expect(rsinParam?.value == "823807071")
        #expect(url.path == "/v1/zoeken")
    }
    
    @Test("Creates correct URL with vestigingsnummer parameter")
    func testVestigingsnummerSearchURL() throws {
        @Dependency(APIV1.Router.self) var router
        
        let url = router.url(for: .search(
            kvkNummer: nil,
            rsin: nil,
            vestigingsnummer: "000015063097",
            handelsnaam: nil,
            straatnaam: nil,
            plaats: nil,
            postcode: nil,
            huisnummer: nil,
            huisnummerToevoeging: nil,
            type: nil,
            inclusiefInactieveRegistraties: nil,
            pagina: nil,
            aantal: nil
        ))
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let vestigingsnummerParam = components?.queryItems?.first(where: { $0.name == "vestigingsnummer" })
        
        #expect(vestigingsnummerParam?.value == "000015063097")
        #expect(url.path == "/v1/zoeken")
    }
}
