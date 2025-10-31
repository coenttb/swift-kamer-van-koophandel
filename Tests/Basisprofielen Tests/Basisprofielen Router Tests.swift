//
//  Basisprofiel Router Tests.swift
//  coenttb-kvk
//
//  Created by Assistant on 10/01/2025.
//

import Dependencies
import DependenciesTestSupport
import Foundation
import Kamer_van_Koophandel_Shared
import Testing
import URLRouting

@testable import Basisprofielen
@testable import Kamer_van_Koophandel_Models

@Suite("Basisprofiel Router Tests")
struct BasisprofielRouterTests {

  @Test("Creates correct URL for basisprofiel retrieval")
  func testRetrieveBasisprofielURL() throws {
    @Dependency(API.Router.self) var router

    let kvkNummer: Kamer_van_Koophandel_Models.Number = "59581883"
    let url = router.url(for: .get(kvkNummer: kvkNummer, geoData: nil))

    #expect(url.path == "/v1/basisprofielen/59581883")

    // Verify no query parameters when geoData is nil
    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    #expect(components?.queryItems == nil || components?.queryItems?.isEmpty == true)
  }

  @Test("Creates correct URL with geoData parameter")
  func testGeoDataParameter() throws {
    @Dependency(API.Router.self) var router

    let kvkNummer: Kamer_van_Koophandel_Models.Number = "59581883"
    let urlWithGeoData = router.url(for: .get(kvkNummer: kvkNummer, geoData: true))

    let components = URLComponents(url: urlWithGeoData, resolvingAgainstBaseURL: false)
    #expect(components?.queryItems?.count == 1)
    #expect(components?.queryItems?.first?.name == "geoData")
    #expect(components?.queryItems?.first?.value == "true")
  }

  @Test("Creates correct URLs for all basisprofiel endpoints")
  func testAllEndpoints() throws {
    @Dependency(API.Router.self) var router

    let kvkNummer: Kamer_van_Koophandel_Models.Number = "12345678"

    // Test main basisprofiel endpoint
    let basisprofielURL = router.url(for: .get(kvkNummer: kvkNummer, geoData: nil))
    #expect(basisprofielURL.path == "/v1/basisprofielen/12345678")

    // Test eigenaar endpoint
    let eigenaarURL = router.url(for: .getEigenaar(kvkNummer: kvkNummer, geoData: nil))
    #expect(eigenaarURL.path == "/v1/basisprofielen/12345678/eigenaar")

    // Test hoofdvestiging endpoint
    let hoofdvestigingURL = router.url(for: .getHoofdvestiging(kvkNummer: kvkNummer, geoData: nil))
    #expect(hoofdvestigingURL.path == "/v1/basisprofielen/12345678/hoofdvestiging")

    // Test vestigingen endpoint
    let vestigingenURL = router.url(for: .getVestigingen(kvkNummer: kvkNummer))
    #expect(vestigingenURL.path == "/v1/basisprofielen/12345678/vestigingen")
  }

  @Test("URL maintains KvK number format")
  func testKvKNumberFormat() throws {
    @Dependency(API.Router.self) var router

    // Test with KvK numbers containing leading zeros
    let kvkNummer: Kamer_van_Koophandel_Models.Number = "00123456"

    // Test all endpoints
    let urls = [
      router.url(for: .get(kvkNummer: kvkNummer, geoData: nil)),
      router.url(for: .getEigenaar(kvkNummer: kvkNummer, geoData: nil)),
      router.url(for: .getHoofdvestiging(kvkNummer: kvkNummer, geoData: nil)),
      router.url(for: .getVestigingen(kvkNummer: kvkNummer)),
    ]

    for url in urls {
      #expect(url.pathComponents.contains("00123456"), "Leading zeros should be preserved")
    }
  }

  @Test("Handles different KvK numbers correctly")
  func testDifferentKvKNumbers() throws {
    @Dependency(API.Router.self) var router

    let testCases: [Kamer_van_Koophandel_Models.Number] = [
      "12345678",
      "00012345",
      "98765432",
      "11111111",
    ]

    for kvkNummer in testCases {
      // Test main basisprofiel endpoint
      let url = router.url(for: .get(kvkNummer: kvkNummer, geoData: nil))

      // Verify path components
      let pathComponents = url.pathComponents
      #expect(pathComponents.contains("v1"))
      #expect(pathComponents.contains("basisprofielen"))
      #expect(pathComponents.contains(kvkNummer.description))

      // Verify order of path components
      #expect(pathComponents[1] == "v1")
      #expect(pathComponents[2] == "basisprofielen")
      #expect(pathComponents[3] == kvkNummer.description)
    }
  }

  @Test("Correctly handles geoData parameter for all applicable endpoints")
  func testGeoDataForAllEndpoints() throws {
    @Dependency(API.Router.self) var router

    let kvkNummer: Kamer_van_Koophandel_Models.Number = "12345678"
    let endpoints = [
      router.url(for: .get(kvkNummer: kvkNummer, geoData: true)),
      router.url(for: .getEigenaar(kvkNummer: kvkNummer, geoData: true)),
      router.url(for: .getHoofdvestiging(kvkNummer: kvkNummer, geoData: true)),
    ]

    for url in endpoints {
      let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
      #expect(components?.queryItems?.count == 1)
      #expect(components?.queryItems?.first?.name == "geoData")
      #expect(components?.queryItems?.first?.value == "true")
    }

    // Verify vestigingen endpoint doesn't accept geoData
    let vestigingenURL = router.url(for: .getVestigingen(kvkNummer: kvkNummer))
    let components = URLComponents(url: vestigingenURL, resolvingAgainstBaseURL: false)
    #expect(components?.queryItems == nil || components?.queryItems?.isEmpty == true)
  }
}
