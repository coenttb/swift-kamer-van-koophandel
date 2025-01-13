//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import Coenttb_Web
import Dependencies
import DependenciesTestSupport
import EmailAddress
import Testing
import BearerAuth

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension _KvKAuthenticatedClient {
    package static func test(
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { request in try await URLSession.shared.data(for: request) },
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
            
            $0.envVars = switch testStrategy {
            case .local: kvkTestEnv
            case .liveTest: kvkTestEnv
            case .live: try! .live(localDevelopment: .projectRoot.appendingPathComponent(".env.development"))
            }
        } operation: {
            @Dependency(\.envVars) var envVars
                        
            let kvkApiKey = try #require(envVars.kvkApiKey)
            
            return _KvKAuthenticatedClient(
                kvkApiKey: kvkApiKey,
                session: session,
                router: router,
                buildClient: { buildClient($0) }
            )
        }
    }
}

extension _KvKAuthenticatedClient where APIRouter: TestDependencyKey, APIRouter.Value == APIRouter {
    package static func test(
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { request in try await URLSession.shared.data(for: request) },
        _ buildClient: @escaping @Sendable (
            _ makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest
        ) -> ClientOutput
    ) throws -> Self where Auth == String, AuthRouter == KvKAuthRouter {
        @Dependency(APIRouter.self) var router
        return try .test(
            session: session,
            router: router,
            buildClient: buildClient
        )
    }
}

extension _KvKAuthenticatedClient where APIRouter: TestDependencyKey, APIRouter.Value == APIRouter {
    package static func test(
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { request in try await URLSession.shared.data(for: request) },
        buildClient: @escaping @Sendable () -> ClientOutput
    ) throws -> Self where Auth == String, AuthRouter == KvKAuthRouter {
        @Dependency(APIRouter.self) var router
        return try .test(
            session: session,
            router: router
        ) { _ in buildClient() }
    }
}
