//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Coenttb_Web
import Dependencies
import DependenciesTestSupport
import EmailAddress
import Foundation
import Testing

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Kamer_van_Koophandel_Shared.AuthenticatedClient {
  package static func test(
    router: APIRouter,
    buildClient: @escaping @Sendable (
      _ makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest
    ) -> ClientOutput
  ) throws -> Self where Auth == String, AuthRouter == KvKAuthRouter {

    @Dependency(TestStrategy.self) var testStrategy

    return try withDependencies {
      let kvkTestEnv: EnvVars = try! .init(
        dictionary: [
          // Public test key provided by Kamer van Koophandel
          "KVK_API_KEY": "l7xx1f2691f2520d487b902f4e0b57a0b197"
        ],
        requiredKeys: ["KVK_API_KEY"]
      )

      $0.envVars =
        switch testStrategy {
        case .local: kvkTestEnv
        case .liveTest: kvkTestEnv
        case .live:
          try! .live(localDevelopment: .projectRoot.appendingPathComponent(".env.development"))
        }
    } operation: {
      @Dependency(\.envVars) var envVars

      let kvkApiKey = try #require(envVars.kvkApiKey)

      return Kamer_van_Koophandel_Shared.AuthenticatedClient(
        kvkApiKey: kvkApiKey,
        router: router,
        buildClient: { buildClient($0) }
      )
    }
  }
}

extension Kamer_van_Koophandel_Shared.AuthenticatedClient
where APIRouter: TestDependencyKey, APIRouter.Value == APIRouter {
  package static func test(
    _ buildClient: @escaping @Sendable (
      _ makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest
    ) -> ClientOutput
  ) throws -> Self where Auth == String, AuthRouter == KvKAuthRouter {
    @Dependency(APIRouter.self) var router
    return try .test(
      router: router,
      buildClient: buildClient
    )
  }
}

extension Kamer_van_Koophandel_Shared.AuthenticatedClient
where APIRouter: TestDependencyKey, APIRouter.Value == APIRouter {
  package static func test(
    buildClient: @escaping @Sendable () -> ClientOutput
  ) throws -> Self where Auth == String, AuthRouter == KvKAuthRouter {
    @Dependency(APIRouter.self) var router
    return try .test(
      router: router
    ) { _ in buildClient() }
  }
}
