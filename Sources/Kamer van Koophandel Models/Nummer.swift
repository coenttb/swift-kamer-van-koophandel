//
//  File.swift
//  swift-kamer-van-koophandel
//
//  Created by Coen ten Thije Boonkkamp on 10/01/2025.
//

import Foundation

/// A Dutch Chamber of Commerce (KvK) number consisting of exactly 8 digits
public struct Nummer: Hashable, Sendable {
  /// The underlying KvK number string
  private let value: String

  /// Initialize with a KvK number string
  /// - Parameter string: An 8-digit string representing a KvK number
  /// - Throws: NummerError if the string is not exactly 8 digits
  public init(_ string: String) throws {
    guard string.count == 8,
      string.allSatisfy({ $0.isNumber })
    else {
      throw NummerError.invalidFormat(description: "KvK number must be exactly 8 digits")
    }
    self.value = string
  }
}

public typealias Number = Nummer

// MARK: - Integer Initialization
extension Nummer {
  /// Initialize with an integer value
  /// - Parameter value: An integer that will be zero-padded to 8 digits
  /// - Throws: NummerError if the number cannot be represented as exactly 8 digits
  public init(_ value: Int) throws {
    // Check if number would exceed 8 digits
    guard value >= 0 && value <= 99_999_999 else {
      throw NummerError.invalidFormat(description: "KvK number must be between 0 and 99999999")
    }

    // Zero-pad to 8 digits
    let string = String(format: "%08d", value)
    try self.init(string)
  }
}

// MARK: - Errors
extension Nummer {
  public enum NummerError: Error, Equatable, LocalizedError {
    case invalidFormat(description: String)

    public var errorDescription: String? {
      switch self {
      case .invalidFormat(let description):
        return "Invalid KvK number format: \(description)"
      }
    }
  }
}

// MARK: - Protocol Conformances
extension Nummer: CustomStringConvertible {
  public var description: String { value }
}

extension Nummer: Codable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(self.value)
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    try self.init(string)
  }
}

extension Nummer: RawRepresentable {
  public init?(rawValue: String) {
    self.value = rawValue
  }

  public var rawValue: String { value }
}

extension Nummer: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    try! self.init(value)
  }
}

extension Nummer: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    try! self.init(value)
  }
}
