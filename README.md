# 🛍️ Suits - E-Commerce Flutter Application

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)

A modern, feature-rich e-commerce mobile application built with Flutter, featuring a clean architecture pattern, multiple payment gateways, and real-time notifications.

[Features](#-features) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [Screenshots](#-screenshots) • [Contributing](#-contributing)

</div>

---

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Configuration](#-configuration)
- [Backend](#-backend)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

### 🔐 Authentication & User Management
- Email & Password Authentication
- Google Sign-In Integration
- Facebook Authentication
- OTP Verification
- Secure User Profile Management
- Local Storage with Hive

### 🛒 Shopping Experience
- Intuitive Product Browsing
- Advanced Product Categories
- Favorites/Wishlist Management
- Shopping Cart with Real-time Updates
- Product Search & Filtering
- Image Gallery with Cached Network Images

### 💳 Payment Integration
- **Stripe Payment Gateway**
- **PayPal Payment Integration**
- Saved Cards Management
- Cash on Delivery (COD)
- Secure Payment Processing

### 📦 Order Management
- Order Placement & Tracking
- Order History
- Real-time Order Status Updates
- Location-based Delivery
- Agent (Mandoob) Flow Integration

### 🔔 Notifications
- Firebase Cloud Messaging (FCM)
- Local Push Notifications
- Payment Success Notifications
- Order Status Updates
- Real-time Agent Notifications

### 🎨 UI/UX
- Modern Material Design
- Custom Fonts (Poppins, Montserrat)
- Smooth Animations
- Skeleton Loading States
- Custom App Launcher Icons
- Responsive Design

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns:

```
lib/
├── core/                    # Core functionality & shared resources
│   ├── api/                # API configuration
│   ├── constant/           # App constants
│   ├── error/              # Error handling
│   ├── helper/             # Helper utilities
│   ├── routes/             # App routing (GoRouter)
│   ├── secret/             # API keys & secrets
│   ├── service/            # Core services (DI, Notifications)
│   ├── utils/              # Utility functions
│   └── widgets/            # Reusable widgets
│
└── features/               # Feature modules
    ├── auth/               # Authentication
    ├── cart/               # Shopping cart
    ├── favorite/           # Favorites/Wishlist
    ├── home/               # Home & product listing
    ├── location/           # Location services
    ├── onboarding/         # Onboarding screens
    ├── orders/             # Order management
    ├── payment/            # Payment processing
    ├── profile/            # User profile
    └── splash/             # Splash screen
```

### Feature Architecture Pattern

Each feature follows a consistent 3-layer architecture:

```
feature/
├── data/                   # Data layer
│   ├── models/            # Data models
│   ├── datasources/       # Remote & local data sources
│   └── repositories/      # Repository implementations
│
├── domain/                # Business logic layer
│   ├── entities/          # Domain entities
│   ├── repositories/      # Repository interfaces
│   └── usecases/          # Business use cases
│
└── presentation/          # Presentation layer
    ├── bloc/              # State management (BLoC/Cubit)
    ├── views/             # UI screens
    └── widgets/           # Feature-specific widgets
```

---

## 🛠️ Tech Stack

### Frontend (Flutter)
- **State Management**: BLoC & Cubit (flutter_bloc)
- **Dependency Injection**: GetIt
- **Navigation**: GoRouter
- **Local Storage**: Hive
- **Networking**: Dio
- **Functional Programming**: Dartz

### Backend & Services
- **Authentication**: Firebase Auth
- **Database**: Cloud Firestore
- **Cloud Messaging**: Firebase Cloud Messaging (FCM)
- **Image Storage**: Cloudinary
- **Backend Server**: Dart Backend (Custom)

### Payment Gateways
- Stripe (flutter_stripe)
- PayPal (flutter_paypal_payment)
- Credit Card UI (flutter_credit_card)

### UI & Design
- Material Design
- Custom Fonts (Poppins, Montserrat)
- SVG Support (flutter_svg)
- Image Caching (cached_network_image)
- Skeleton Loading (skeletonizer)
- Page Indicators (smooth_page_indicator)

---

## 📁 Project Structure

```
suits/
├── android/                # Android native code
├── ios/                    # iOS native code
├── web/                    # Web support
├── linux/                  # Linux support
├── macos/                  # macOS support
├── windows/                # Windows support
├── backend/                # Dart backend server
│   ├── bin/               # Server entry point
│   ├── routes/            # API routes & webhooks
│   ├── services/          # Backend services
│   └── test/              # Backend tests
├── assets/                 # Static assets
│   ├── images/            # App images
│   ├── icons/             # App icons
│   ├── fonts/             # Custom fonts
│   ├── signin_icon/       # Auth icons
│   ├── textfield_icon/    # Input icons
│   ├── home/              # Home screen assets
│   └── category/          # Category images
├── lib/                    # Flutter source code
│   ├── core/              # Core functionality
│   ├── features/          # Feature modules
│   ├── firebase_options.dart
│   └── main.dart          # App entry point
├── test/                   # Flutter tests
├── pubspec.yaml           # Dependencies
└── README.md              # This file
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.9.2`
- Dart SDK `>=3.9.2`
- Firebase Account
- Stripe Account
- PayPal Business Account
- Android Studio / Xcode (for mobile development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/suits.git
   cd suits
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android and iOS apps to your Firebase project
   - Download and place configuration files:
     - `google-services.json` for Android → `android/app/`
     - `GoogleService-Info.plist` for iOS → `ios/Runner/`
   - Run FlutterFire CLI:
     ```bash
     flutterfire configure
     ```

4. **Set up API Keys**
   - Create `lib/core/secret/secret.dart`:
     ```dart
     class ApiKeys {
       static const String publishableKey = 'your_stripe_publishable_key';
       static const String secretKey = 'your_stripe_secret_key';
       static const String cloudinaryCloudName = 'your_cloudinary_cloud_name';
       static const String cloudinaryApiKey = 'your_cloudinary_api_key';
       static const String cloudinaryApiSecret = 'your_cloudinary_api_secret';
     }
     ```

5. **Generate App Icons**
   ```bash
   flutter pub run flutter_launcher_icons
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

---

## ⚙️ Configuration

### Firebase Setup

1. **Enable Authentication Methods**:
   - Email/Password
   - Google Sign-In
   - Facebook Login

2. **Firestore Database**:
   - Configure security rules
   - Set up collections for users, products, orders, etc.

3. **Cloud Messaging**:
   - Enable FCM for push notifications
   - Configure Android & iOS for notifications

### Android Configuration

Update `android/app/build.gradle`:
```gradle
android {
    compileSdkVersion 34
    minSdkVersion 21
    targetSdkVersion 34
    
    compileOptions {
        coreLibraryDesugaringEnabled true
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}

dependencies {
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.0.4'
}
```

### iOS Configuration

Update `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>your-url-scheme</string>
        </array>
    </dict>
</array>
```

---

## 🔧 Backend

The project includes a Dart backend server for handling webhooks and server-side operations:

```bash
cd backend
dart pub get
dart run bin/server.dart
```

### Backend Features
- Payment webhook handlers
- Notification services
- Order processing
- Authentication services

---

## 📱 Screenshots

> _Add your app screenshots here_

<div align="center">
  <img src="screenshots/home.png" width="200" alt="Home Screen"/>
  <img src="screenshots/product.png" width="200" alt="Product Details"/>
  <img src="screenshots/cart.png" width="200" alt="Shopping Cart"/>
  <img src="screenshots/payment.png" width="200" alt="Payment"/>
</div>

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Backend tests
cd backend
dart test
```

---

## 🔨 Build

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

---

## 📦 Dependencies

### Main Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_bloc | ^9.1.1 | State management |
| get_it | ^9.0.5 | Dependency injection |
| go_router | ^17.0.0 | Navigation |
| firebase_core | ^4.2.0 | Firebase integration |
| firebase_auth | ^6.1.1 | Authentication |
| cloud_firestore | ^6.0.3 | Database |
| flutter_stripe | ^12.0.2 | Stripe payments |
| flutter_paypal_payment | ^1.0.8 | PayPal integration |
| flutter_local_notifications | ^19.5.0 | Local notifications |
| hive_flutter | ^1.1.0 | Local storage |
| dio | ^5.9.0 | HTTP client |
| dartz | ^0.10.1 | Functional programming |
| cached_network_image | ^3.2.3 | Image caching |

View full dependency list in [`pubspec.yaml`](pubspec.yaml)

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style

- Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Write unit tests for new features

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Your Name**

- GitHub: [@yourusername](https://github.com/MahmoudDahy11)
- Email: dahym2028@gmail.com

---

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - UI framework
- [Firebase](https://firebase.google.com/) - Backend services
- [Stripe](https://stripe.com/) - Payment processing
- [PayPal](https://www.paypal.com/) - Payment gateway
- All open-source contributors

---

## 📞 Support

For support, email dahym2028@gmail.com or open an issue in the GitHub repository.

---

<div align="center">

**⭐ Star this repository if you find it helpful!**

Made with ❤️ using Flutter

</div>

