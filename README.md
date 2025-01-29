# WeatherConnect SDK Integration

The **WeatherConnect SDK** allows developers to seamlessly integrate weather information into their iOS apps using Swift and SwiftUI. Follow the steps below to integrate and use the SDK in your project.

---

## Table of Contents
1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Integration Guide](#integration-guide)
4. [Example Usage](#example-usage)
5. [Customization](#customization)
6. [Troubleshooting](#troubleshooting)

---

## Requirements
- **iOS**: 16.0+
- **Swift**: 5.7+
- **Xcode**: 16.2

---

## Installation

Add the **WeatherConnect SDK** to your project via Swift Package Manager (SPM):

1. Open your Xcode project.
2. Go to **File > Add Packages**.
3. Paste the following URL into the search bar:
   ```
   https://github.com/YourGitHubUsername/WeatherConnect
   ```
4. Select the package and add it to your target.

Alternatively, you can manually add it to your `Package.swift` file:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "YourProjectName",
    dependencies: [
        .package(url: "https://github.com/YourGitHubUsername/WeatherConnect", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourProjectTarget",
            dependencies: ["WeatherConnect"]
        )
    ]
)
```

---

## Integration Guide

### Step 1: Configure the SDK
In your `MainViewModel`, initialize the `WeatherSDK` with an API key and city name.

```swift
import WeatherConnect

class MainViewModel: ObservableObject {
    var weatherSdk: WeatherSDK?

    init() {
        let configuration = Configurations(apiKey: "YOUR_API_KEY", cityName: "Berlin")
        weatherSdk = try? WeatherSDK(configuration: configuration, delegate: self)
    }
}
```

### Step 2: Implement Delegates
Conform to the `WeatherSDKDelegate` to handle events like successful completion or errors.

```swift
extension MainViewModel: WeatherSDKDelegate {
    func onFinished() {
        print("Weather dismissed successfully.")
    }

    func onFinishedWithError(_ error: Error) {
        print("Weather dismissed with error: \(error.localizedDescription)")
    }
}
```

### Step 3: Display Weather View
Use `getWeatherView` to fetch the weather UI as an `AnyView` and present it in your SwiftUI application.

```swift
@Published var isWeatherViewPresented: Bool = false

func getWeatherView() async -> AnyView? {
    guard let sdk = weatherSdk else { return nil }
    return await sdk.getWeather()
}
```

---

## Example Usage

Below is a complete example of integrating the WeatherConnect SDK into a SwiftUI app.

```swift
import SwiftUI
import WeatherConnect

struct ClientAppContentView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State private var weatherView: AnyView?

    var body: some View {
        NavigationStack {
            VStack {
                Button("Show Weather View") {
                    loadWeatherView()
                }
            }
            .navigationDestination(isPresented: $mainViewModel.isWeatherViewPresented) {
                if let weatherView = weatherView {
                    weatherView
                }
            }
        }
    }

    private func loadWeatherView() {
        Task {
            if let view = await mainViewModel.getWeatherView() {
                DispatchQueue.main.async {
                    self.weatherView = view
                    mainViewModel.isWeatherViewPresented = true
                }
            } else {
                print("Failed to load WeatherView")
            }
        }
    }
}
```

---

## Customization

The SDK allows customization through the `Configurations` class:
- **API Key**: Use your unique key.
- **City Name**: Specify the city for weather data.

Example:

```swift
let configuration = Configurations(apiKey: "YOUR_API_KEY", cityName: "Munich")
```

---

## Troubleshooting

### Common Issues
1. **Invalid API Key**: Ensure your API key is correct.
2. **Network Errors**: Check your internet connection.

### Logging
Use the delegate methods to log errors or successful operations:

```swift
func onFinishedWithError(_ error: Error) {
    print("Error: \(error.localizedDescription)")
}
```

---

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

---

Happy coding! 🚀
