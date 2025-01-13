//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import Foundation
import Coenttb_Web
import Testing
import EmailAddress

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URL {
    package static var projectRoot: URL {
        return .init(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }
}

extension EnvironmentVariables {
    package var kvkApiKey: String? {
        get { self["KVK_API_KEY"] }
    }
}


