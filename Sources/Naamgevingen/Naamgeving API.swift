//
//  Billing API.swift
//  coenttb-stripe
//
//  Created by Coen ten Thije Boonkkamp on 05/01/2025.
//

import Foundation
import URLRouting
import UrlFormCoding
import Dependencies
import Kamer_van_Koophandel_Shared
import Kamer_van_Koophandel_Models

public enum API: Equatable, Sendable {
    case get(kvkNummer: Kamer_van_Koophandel_Models.Number)
}

extension API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<API> {
            OneOf {
                URLRouting.Route(.case(API.get)) {
                    Method.get
                    Path.v1
                    Path.naamgevingen
                    Path.kvknummer
                    Path { Parse(.string.representing(Kamer_van_Koophandel_Models.Number.self)) }
                }
            }
        }
    }
}

// Add path extensions
extension Path<PathBuilder.Component<String>> {
    nonisolated(unsafe) public static let naamgevingen = Path {
        "naamgevingen"
    }
    
    nonisolated(unsafe) public static let kvknummer = Path {
        "kvknummer"
    }
}

extension API.Router: TestDependencyKey {
    public static let testValue: API.Router = .init()
}
