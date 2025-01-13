//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import URLRouting
import Authentication
import Coenttb_Web

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public typealias _KvKAuthenticatedClient<
    API: Equatable & Sendable,
    APIRouter: ParserPrinter & Sendable,
    Client: Sendable
> = Authentication.Client<
    String,
    KvKAuthRouter,
    API,
    APIRouter,
    Client
> where APIRouter.Output == API, APIRouter.Input == URLRequestData

extension _KvKAuthenticatedClient {
    public init(
        baseURL: URL = .init(string: "https://api.kvk.nl")!,
        kvkApiKey: String,
        session: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse) = { request in try await URLSession.shared.data(for: request) },
        router: APIRouter,
        buildClient: @escaping @Sendable (@escaping @Sendable (API) throws -> URLRequest) -> ClientOutput
    ) where Auth == String, AuthRouter == KvKAuthRouter {
        
        @Dependency(TestStrategy.self) var testStrategy
        
        let includeTestPathComponent: Bool = switch testStrategy {
        case .local: true
        case .liveTest: true
        case .live: false
        }
        
        print("includeTestPathComponent", includeTestPathComponent)
        
        self = .init(
            baseURL: baseURL,
            auth: kvkApiKey,
            session: session,
            router: router,
            authRouter: KvKAuthRouter(includeTestPathComponent: includeTestPathComponent),
            buildClient: buildClient
        )
    }
}

public struct KvKAuthRouter: ParserPrinter, Sendable {
    
    let includeTestPathComponent: Bool
    
    public init(includeTestPathComponent: Bool) {
        self.includeTestPathComponent = includeTestPathComponent
    }
    
    public var body: some URLRouting.Router<String> {
        if includeTestPathComponent {
            Path { "test" }
        }
        Path { "api" }
        Headers {
            Field("apikey") {
                Parse(.string)
            }
        }
    }
}



