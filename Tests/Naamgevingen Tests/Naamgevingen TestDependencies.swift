import Coenttb_Authentication
import Dependencies
import DependenciesMacros
import DependenciesTestSupport
import EnvironmentVariables
import Foundation
import IssueReporting
import Kamer_van_Koophandel_Shared
import Testing

@testable import Kamer_van_Koophandel_Models
@testable import Naamgevingen

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Naamgevingen.AuthenticatedClient: @retroactive TestDependencyKey {
  public static let testValue: Self = {
    @Dependency(TestStrategy.self) var testStrategy

    return switch testStrategy {
    case .local:
      try! Naamgevingen.AuthenticatedClient.test { Naamgevingen.Client.testValue }
    case .liveTest:
      try! Naamgevingen.AuthenticatedClient.test { Naamgevingen.Client.live(makeRequest: $0) }
    case .live:
      try! Naamgevingen.AuthenticatedClient.test { Naamgevingen.Client.live(makeRequest: $0) }
    }
  }()
}
