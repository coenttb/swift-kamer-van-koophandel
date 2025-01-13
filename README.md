# swift-kamer-van-koophandel

`swift-kamer-van-koophandel` is an unoffical SDK for the Kamer van Koophandel (National Chamber of Commerce of the Netherlands).

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

This package is currently in active development and is subject to frequent changes. Features and APIs may change without prior notice until a stable release is available.

## Key Features
- **Built entirely in Swift**: Leverages the power of Swift and Vapor to deliver backend capabilities without JavaScript dependencies.
- **Functional Elegance**: Clean and testable architecture inspired by PointFree's best practices.
- **Hypermodular**: Highly modular design, allowing for reusable components that are easy to test, maintain, and integrate.

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

## Feedback is much appreciated!

If you’re working on your own Swift project, feel free to learn, fork, and contribute.

Got thoughts? Found something you love? Something you hate? Let me know! Your feedback helps make this project better for everyone. Open an issue or start a discussion—I’m all ears.

> [Subscribe to my newsletter](http://coenttb.com/en/newsletter/subscribe)
>
> [Follow me on X](http://x.com/coenttb)
> 
> [Link on Linkedin](https://www.linkedin.com/in/tenthijeboonkkamp)

## License

This project is licensed under the **Apache 2.0 License**.  
You are free to use, modify, and distribute this project under the terms of the Apache 2.0 License.  
For full details, please refer to the [LICENSE](LICENSE) file.
