//
//  File.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import URLRouting
import Coenttb_Web
import Coenttb_Authentication

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public typealias _KvKAuthenticatedClient<
    API: Equatable & Sendable,
    APIRouter: ParserPrinter & Sendable,
    Client: Sendable
> = Coenttb_Authentication.Client<
    String,
    KvKAuthRouter,
    API,
    APIRouter,
    Client
> where APIRouter.Output == API, APIRouter.Input == URLRequestData

extension _KvKAuthenticatedClient {
    public init(
        kvkApiKey: String,
        router: APIRouter,
        buildClient: @escaping @Sendable (@escaping @Sendable (API) throws -> URLRequest) -> ClientOutput
    ) where Auth == String, AuthRouter == KvKAuthRouter {
        
        @Dependency(TestStrategy.self) var testStrategy
        @Dependency(\.kamerVanKoophandel.baseUrl) var baseUrl
        
        let includeTestPathComponent: Bool = switch testStrategy {
        case .local: true
        case .liveTest: true
        case .live: false
        }
        
        
        self = .init(
            baseURL: baseUrl,
            auth: kvkApiKey,
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



