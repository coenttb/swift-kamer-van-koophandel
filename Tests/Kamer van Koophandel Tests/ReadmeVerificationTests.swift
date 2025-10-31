//
//  ReadmeVerificationTests.swift
//  swift-kamer-van-koophandel
//
//  Created for README validation
//

import Dependencies
import Foundation
import Testing

@testable import Kamer_van_Koophandel

@Suite("README Verification")
struct ReadmeVerificationTests {
  @Test("Example from README lines 30-37: Dependency configuration")
  func exampleDependencyConfiguration() throws {
    // This test verifies the README example for configuring the client as a dependency

    // The example shows how to extend AuthenticatedClient to be a DependencyKey
    // We verify the structure exists and is accessible
    let _: AuthenticatedClient.Type = AuthenticatedClient.self

    // Verify the client has the expected sub-clients
    @Dependency(\.kamerVanKoophandel) var kvkConfig
    #expect(kvkConfig.baseUrl.absoluteString.contains("api.kvk.nl"))
  }

  @Test("Example from README lines 30-39: Client usage with @Dependency macro")
  func exampleClientUsage() throws {
    // This test verifies that the client can be accessed via @Dependency macro
    // as shown in the README

    withDependencies {
      $0.kamerVanKoophandel = .testValue
    } operation: {
      @Dependency(\.kamerVanKoophandel) var kvkConfig

      // Verify base URL is accessible
      #expect(kvkConfig.baseUrl.absoluteString == "https://api.kvk.nl")
    }
  }

  @Test("Verify package structure matches README description")
  func verifyPackageStructure() throws {
    // Verify the main client exists and has the structure described in README
    let client = Client(
      basisprofiel: .testValue,
      naamgeving: .testValue,
      vestigingsprofiel: .testValue,
      zoeken: .init(v1: .testValue, v2: .testValue)
    )

    // Verify all sub-clients are accessible
    let _: Basisprofielen.Client = client.basisprofiel
    let _: Naamgevingen.Client = client.naamgeving
    let _: Vestigingsprofielen.Client = client.vestigingsprofiel
    let _: Client.Zoeken = client.zoeken
  }

  @Test("Verify module imports work as documented")
  func verifyModuleImports() throws {
    // This test verifies that the modules mentioned in the README
    // can be imported and used together

    // The package provides access to multiple API endpoint modules
    // as stated in the Features section

    let _: Basisprofielen.Client.Type = Basisprofielen.Client.self
    let _: Naamgevingen.Client.Type = Naamgevingen.Client.self
    let _: Vestigingsprofielen.Client.Type = Vestigingsprofielen.Client.self
    let _: Zoeken_V1.Client.Type = Zoeken_V1.Client.self
    let _: Zoeken_V2.Client.Type = Zoeken_V2.Client.self
  }
}
