//
//  File.swift
//  swift-stripe
//
//  Created by Coen ten Thije Boonkkamp on 09/01/2025.
//

import Foundation
import IssueReporting
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Client {
    public static func live(
        makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest,
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { try await URLSession.shared.data(for: $0) }
    ) -> Self {
        Self(
            get: { kvkNummer in
                try await handleRequest(
                    for: makeRequest(.get(kvkNummer: kvkNummer)),
                    decodingTo: Naamgeving.self,
                    session: session
                )
            }
        )
    }
}

extension Client {
    public static func live(
        baseURL: URL,
        apiKey: String,
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { request in try await URLSession.shared.data(for: request)}
    ) -> AuthenticatedClient {
        
        @Dependency(API.Router.self) var router
        
        return AuthenticatedClient(
            baseURL: baseURL,
            kvkApiKey: apiKey,
            session: session,
            router: router
        ) { makeRequest in
            Client.live(
                makeRequest: makeRequest,
                session: session
            )
        }
    }
}

extension AuthenticatedClient {
    package static var liveTest: Self {
        try! AuthenticatedClient.test { .live(makeRequest: $0) }
    }
}
