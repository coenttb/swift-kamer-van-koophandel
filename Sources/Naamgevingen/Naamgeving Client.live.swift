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
import Coenttb_Web

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Client {
    public static func live(
        makeRequest: @escaping @Sendable (_ route: API) throws -> URLRequest
    ) -> Self {
        
        @Dependency(URLRequest.Handler.self) var handleRequest
        
        return Self(
            get: { kvkNummer in
                try await handleRequest(
                    for: makeRequest(.get(kvkNummer: kvkNummer)),
                    decodingTo: Naamgeving.self
                )
            }
        )
    }
}

extension Client {
    public static func live(
        apiKey: String
    ) -> AuthenticatedClient {
        
        @Dependency(API.Router.self) var router
        
        return AuthenticatedClient(
            kvkApiKey: apiKey,
            router: router
        ) { makeRequest in
            Client.live(
                makeRequest: makeRequest
            )
        }
    }
}

extension AuthenticatedClient {
    package static var liveTest: Self {
        try! AuthenticatedClient.test { .live(makeRequest: $0) }
    }
}
