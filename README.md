# Union Shop - Bearbrick E-Commerce Flutter App

A fully functional e-commerce mobile application built with Flutter, specializing in Bearbrick collectibles and merchandise. This app recreates the University of Portsmouth Student Union shop experience with modern UI/UX and comprehensive shopping features.

## 📱 Features

### Core Functionality
- **🏠 Home Page**: Dynamic product showcase with promotional banners and featured collections
- **🛍️ Product Catalog**: Browse Bearbrick products with detailed information, pricing, and images
- **🔍 Search**: Real-time product search with filtering capabilities
- **🛒 Shopping Cart**: Full cart management with quantity controls, price calculations, and checkout
- **📦 Collections**: Organized product collections (BE@RBRICKS 100%, BE@RBRICKS 1000%)
- **💰 Sales**: Dedicated sale section with discounted products
- **👕 Print Shack**: Custom t-shirt personalization with dynamic form updates
- **👤 Authentication**: Login and signup pages with form validation
- **ℹ️ About Us**: Company information and brand story
- **📱 Responsive Design**: Optimized for mobile view with adaptive layouts

### Technical Features
- **State Management**: Provider pattern for cart and search functionality
- **Navigation**: Named routes with parameter passing
- **Custom Widgets**: Reusable components (AppHeader, AppDrawer, Footer)
- **Product Models**: Structured data models for products and cart items
- **Testing**: Comprehensive test suite with 88.55% code coverage (252 passing tests)

## 🚀 Getting Started

### Prerequisites

Before running this project, ensure you have the following installed:

- **Flutter SDK** (>=2.17.0 <4.0.0)
- **Dart SDK** (included with Flutter)
- **Git**
- **Visual Studio Code** or **Android Studio** (recommended)
- **Google Chrome** (for web development)

To verify your Flutter installation, run:
```bash
flutter doctor
```

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Xeniosgeorgakis/union_shop.git
   cd union_shop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   
   For web (recommended for mobile view):
   ```bash
   flutter run -d chrome
   ```
   
   For other platforms:
   ```bash
   flutter run
   ```

4. **View in mobile mode** (Chrome)
   - Open Chrome DevTools (F12 or right-click → Inspect)
   - Click the "Toggle device toolbar" button
   - Select a mobile device preset (e.g., iPhone 12 Pro, Pixel 5)

## 💻 Usage

### Running Tests

Run all tests:
```bash
flutter test
```

Run tests with coverage report:
```bash
flutter test --coverage
```

### Main User Flows

1. **Browse Products**
   - Navigate to Collections from the home page
   - Select a collection (BE@RBRICKS 100% or 1000%)
   - View individual product details

2. **Shopping Cart**
   - Add products to cart from product pages
   - View cart from the navigation header
   - Adjust quantities or remove items
   - Proceed to checkout

3. **Search Products**
   - Click the search icon in the header
   - Enter product name or keywords
   - Browse filtered results

4. **Personalize T-Shirts**
   - Navigate to Print Shack from home page
   - Select size, quantity, and usage type
   - Add custom text
   - Preview and add to cart

## 📁 Project Structure

```
union_shop/
├── lib/
│   ├── main.dart                  # App entry point and home screen
│   ├── models/
│   │   ├── all_products.dart      # Product data repository
│   │   ├── cart_provider.dart     # Cart state management
│   │   ├── product_model.dart     # Product data model
│   │   └── search_provider.dart   # Search state management
│   ├── widgets/
│   │   ├── app_drawer.dart        # Navigation drawer
│   │   ├── app_header.dart        # Custom app header
│   │   └── header_search_widget.dart # Search widget
│   ├── about_us_page.dart         # About page
│   ├── cart_page.dart             # Shopping cart page
│   ├── collections_page.dart      # Collections overview
│   ├── collection_one_page.dart   # BE@RBRICKS 100% collection
│   ├── collection_two_page.dart   # BE@RBRICKS 1000% collection
│   ├── footer.dart                # Footer widget
│   ├── login_page.dart            # Login page
│   ├── personalise_page.dart      # T-shirt personalization
│   ├── printshark_page.dart       # Print Shack info page
│   ├── product_page.dart          # Product details page
│   ├── sale_page.dart             # Sale items page
│   ├── search_delegate.dart       # Search functionality
│   └── signup_page.dart           # Sign up page
├── test/                          # Test files (252 tests)
├── assets/
│   └── images/                    # Product and UI images
├── pubspec.yaml                   # Dependencies and configuration
└── README.md                      # This file
```

## 🛠️ Technologies Used

### Framework & Language
- **Flutter** - UI framework
- **Dart** - Programming language

### Key Dependencies
- **provider** (^6.1.2) - State management solution
- **cupertino_icons** (^1.0.2) - iOS-style icons

### Development Tools
- **flutter_test** - Widget and unit testing
- **flutter_lints** (^2.0.0) - Code linting and best practices

### Design Patterns
- **Provider Pattern** - For state management
- **Repository Pattern** - For data management
- **Widget Composition** - Reusable UI components

## ✅ Testing & Quality

- **Total Tests**: 252 tests
- **Test Status**: All passing ✅
- **Code Coverage**: 88.55%
  - Total Lines: 1,362
  - Lines Covered: 1,206
  - Lines Uncovered: 156

### Coverage by Component
- **Models**: 100% (CartProvider, ProductModel, SearchProvider)
- **Widgets**: 95%+ (AppDrawer, HeaderSearchWidget)
- **Pages**: 80-100% (Product, Cart, Collections, etc.)

## 🐛 Known Issues & Limitations

### Current Limitations
- **Authentication**: Login/signup forms are UI-only (no backend integration)
- **Payment**: Checkout simulates transaction without real payment processing
- **Product Images**: Uses local assets and placeholder images
- **Backend**: No real database integration (hardcoded product data)

### Future Improvements
- [ ] Integrate Firebase Authentication for real user accounts
- [ ] Add Firebase Firestore for dynamic product management
- [ ] Implement real payment gateway (Stripe/PayPal)
- [ ] Add user order history and account dashboard
- [ ] Enhance search with filters (price range, categories)
- [ ] Add product reviews and ratings
- [ ] Implement wishlist functionality
- [ ] Add desktop responsiveness optimization

## 👤 Developer

**Xenios Georgakis**
- GitHub: [@Xeniosgeorgakis](https://github.com/Xeniosgeorgakis)
- Repository: [union_shop](https://github.com/Xeniosgeorgakis/union_shop)

## 📄 License

This project was developed as coursework for the University of Portsmouth.

## 🙏 Acknowledgments

- University of Portsmouth - Module: Programming Applications and Programming Languages (M30235)
- Original Union Shop website: [shop.upsu.net](https://shop.upsu.net)
- Flutter documentation and community resources

---

**Note**: This application is designed primarily for mobile view. For the best experience, view in Chrome DevTools mobile device mode.
