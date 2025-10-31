# swift-kamer-van-koophandel

[![CI](https://github.com/coenttb/swift-kamer-van-koophandel/workflows/CI/badge.svg)](https://github.com/coenttb/swift-kamer-van-koophandel/actions/workflows/ci.yml)
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

An unofficial Swift SDK for the Kamer van Koophandel (KvK) API, providing type-safe access to the Dutch Chamber of Commerce business registry.

## Overview

This package provides a Swift interface to the KvK API, enabling integration with the Dutch business registry. It includes support for searching businesses, retrieving company profiles, and accessing establishment information.

## Features

- Type-safe API client with structured query support
- Comprehensive data models for KvK business entities
- Multiple API endpoint modules: Search (V1 & V2), Company Profiles, Establishments, Trade Names
- Built on Point-Free's Dependencies library for testable architecture
- Actor-based concurrency with Swift 6.0

## Installation

You can add `swift-kamer-van-koophandel` to an Xcode project by including it as a package dependency:

Repository URL: https://github.com/coenttb/swift-kamer-van-koophandel

For a Swift package, add the dependency in your Package.swift file:
```
dependencies: [
  .package(url: "https://github.com/coenttb/swift-kamer-van-koophandel", branch: "main")
]
```

You can finalize the Dependency as follows: 

```swift
import Kamer_van_Koophandel
extension Kamer_van_Koophandel.AuthenticatedClient: DependencyKey {
    public static var liveValue: Self {
        let apiKey = ProcessInfo.processInfo.environment["KVK_API_KEY"]!
        return try! .live(apiKey: apiKey)
    }
}
```

Which makes the Client available anywhere using `@Dependency(Kamer_van_Koophandel.AuthenticatedClient.self) var kvkClient`.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## Related Packages

### Dependencies

- [swift-authentication](https://github.com/coenttb/swift-authentication): A Swift package for type-safe HTTP authentication with URL routing integration.
- [coenttb-web](https://github.com/coenttb/coenttb-web): A Swift package with tools for web development building on swift-web.

### Used By

- [coenttb-kamer-van-koophandel](https://github.com/coenttb/coenttb-kamer-van-koophandel): A Swift package integrating swift-kamer-van-koophandel with Vapor.

### Third-Party Dependencies

- [pointfreeco/swift-dependencies](https://github.com/pointfreeco/swift-dependencies): A dependency management library for controlling dependencies in Swift.

## License

This project is licensed under the **Apache 2.0 License**.  
You are free to use, modify, and distribute this project under the terms of the Apache 2.0 License.  
For full details, please refer to the [LICENSE](LICENSE) file.
