//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import Coenttb_Web
import EmailAddress
import Foundation
import Testing

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
    self["KVK_API_KEY"]
  }
}
