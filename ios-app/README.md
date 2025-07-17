# 19 Trillion Solution iOS App

<div align="center">

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0-green.svg)
![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue.svg)

</div>

## 📱 About

The official iOS application for the $19 Trillion Solution - Australia's comprehensive economic reform proposal. This app provides mobile access to the complete solution framework, allowing citizens to explore how Australia's $19 trillion national balance sheet can be leveraged to create systemic change.

## 🌟 Features

### Current Features
- **Full Web Experience**: Access the complete 19 Trillion Solution website
- **Native iOS Navigation**: Seamless integration with iOS design patterns
- **Responsive Design**: Optimized for all iOS devices (iPhone & iPad)
- **Offline Caching**: View previously loaded content without internet connection

### Planned Features (v2.0)
- **Native Components**: 
  - Dashboard with key metrics
  - Interactive calculators
  - Asset allocation visualizers
  - UBI impact calculator
- **Push Notifications**: Updates on policy developments
- **Sharing Features**: Share insights via iOS share sheet
- **Dark Mode Support**: Full dark mode integration
- **Widgets**: Home screen widgets showing key economic metrics
- **Apple Watch Companion**: Quick stats on your wrist

## 🚀 Getting Started

### Prerequisites
- macOS 13.0 or later
- Xcode 15.0 or later
- iOS 16.0+ deployment target
- Apple Developer Account (for device testing)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/tiation/19-trillion-solution.git
   cd 19-trillion-solution/ios-app
   ```

2. **Open in Xcode**
   ```bash
   open NineteenTrillionSolution.xcodeproj
   ```

3. **Configure Signing**
   - Select the project in Xcode
   - Go to "Signing & Capabilities"
   - Select your development team
   - Xcode will automatically manage provisioning

4. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

## 🏗 Project Structure

```
ios-app/
├── NineteenTrillionSolution/
│   ├── App/
│   │   ├── NineteenTrillionSolutionApp.swift
│   │   └── Info.plist
│   ├── Views/
│   │   ├── ContentView.swift
│   │   ├── WebView.swift
│   │   ├── DashboardView.swift (v2.0)
│   │   └── CalculatorView.swift (v2.0)
│   ├── Models/
│   │   └── EconomicData.swift (v2.0)
│   ├── Resources/
│   │   ├── Assets.xcassets
│   │   └── Localizable.strings
│   └── Tests/
│       └── NineteenTrillionSolutionTests.swift
├── NineteenTrillionSolution.xcodeproj
└── README.md
```

## 🎨 Design Principles

The app follows Apple's Human Interface Guidelines with:
- **Clarity**: Clear typography and intuitive navigation
- **Deference**: Content takes center stage
- **Depth**: Layered interface with smooth transitions

## 🔧 Configuration

### App Transport Security
The app is configured to load the secure HTTPS site. No special ATS exceptions required.

### Capabilities
- **Internet Access**: Required for loading web content
- **Background Modes**: For content updates (v2.0)
- **Push Notifications**: For policy updates (v2.0)

## 📊 Technical Details

### Architecture
- **SwiftUI**: Modern declarative UI framework
- **WebKit**: For web content rendering
- **Combine**: Reactive programming for data flow (v2.0)
- **Core Data**: Local data persistence (v2.0)

### Performance
- Lazy loading of web content
- Efficient memory management
- Smooth 60fps scrolling
- Optimized for battery life

## 🧪 Testing

Run tests with:
```bash
xcodebuild test -scheme NineteenTrillionSolution -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 📦 Distribution

### TestFlight
1. Archive the app in Xcode
2. Upload to App Store Connect
3. Distribute via TestFlight

### App Store
- Complete App Store listing
- Submit for review
- Target launch: Q3 2025

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](../CONTRIBUTING.md).

### Development Workflow
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

## 🔗 Related Projects

- [19 Trillion Solution Web](../) - Main web application
- [ChaseWhiteRabbit iOS](../../ChaseWhiteRabbit/ios-app) - Partner organization app
- [Tiation Mobile Suite](../../tiation/mobile) - Complete mobile ecosystem

## 📞 Support

- **Email**: ios@tiation.org
- **Issues**: [GitHub Issues](https://github.com/tiation/19-trillion-solution/issues)
- **Documentation**: [Developer Docs](https://docs.tiation.org/ios)

## 🎯 Roadmap

### Version 1.0 (Current)
- ✅ WebView implementation
- ✅ Basic navigation
- ✅ iOS integration

### Version 2.0 (Q4 2025)
- Native UI components
- Offline functionality
- Push notifications
- Widgets

### Version 3.0 (2026)
- AR visualization of economic data
- Apple Watch app
- Siri integration
- Machine learning insights

---

*Part of the [Tiation](../../tiation/) ecosystem - Building technology that serves humanity*
