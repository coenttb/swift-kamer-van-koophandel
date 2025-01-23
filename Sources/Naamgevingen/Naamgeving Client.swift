//
//  Products Client.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//


import Foundation
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@DependencyClient
public struct Client: Sendable {
    @DependencyEndpoint
    public var get: @Sendable (_ kvkNummer: Kamer_van_Koophandel_Models.Number) async throws -> Naamgeving
}

public typealias AuthenticatedClient = Kamer_van_Koophandel_Shared.AuthenticatedClient<
    API,
    API.Router,
    Client
>
