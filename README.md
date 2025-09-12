# LGU Mobile - Local Government Unit Mobile Application

A comprehensive Flutter cross-platform application for Local Government Units (LGUs) and residents, built with shadcn/ui design philosophy and modern Flutter architecture.

## 🚀 Features

### Phase 1 MVP Functionalities

#### High-Demand, High-Frequency Services

- **Business Permits (BPLS)**
  - New/Renew/Amend forms with mock JSON schema
  - SLA timers and fee calculator
  - E-signature placeholders
  - Status tracking dashboard

- **Real Property Tax (RPT) Payments**
  - Property lookup by TD No./PIN
  - Payment flow with mock payment gateway
  - E-receipt generator

- **Local Digital ID (LGU ID)**
  - Registration & profile verification
  - Status tracker with QR code display
  - Lost/damaged replacement request flow

- **Civil Registry Documents**
  - Request for birth/marriage/death certificates
  - Delivery/pick-up scheduling
  - Online payment integration

- **Work/Health/Sanitation Permits**
  - Application forms with health exam scheduling
  - Inspection scheduling
  - Reminders via push/SMS/email

- **Citizen Assistance & Social Programs**
  - Aid/scholarship/training/medical program applications
  - Mayor can post opportunities
  - Citizens can apply with QR-based verification

#### Information & Community-Building

- **LGU Map** - Offices, businesses, hospitals, households
- **Bayanihan Board** - Solicitations, volunteers, donations
- **Jobs Map** - Job postings with simple inbox for applications
- **E-Palengke (Marketplace)** - Residents post goods/services
- **Local Calendar of Events** - Fiestas, ayuda distribution, community meetups
- **Announcements Carousel** - Work/class suspensions, LGU notices
- **Citizen Reports** - Emergency reports with photos and optional anonymity
- **Projects Info** - LGU projects in article format
- **Profile & Preferences** - Survey-based persona creation

## 🏗️ Architecture

### Feature-First Structure
```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants
│   ├── errors/            # Error handling
│   ├── network/           # API client and network info
│   ├── navigation/        # App routing
│   └── utils/             # Utility functions
├── features/              # Feature modules
│   ├── auth/              # Authentication
│   ├── business_permits/  # Business permits
│   ├── property_tax/      # Property tax payments
│   ├── digital_id/        # Digital ID management
│   ├── civil_registry/    # Civil registry documents
│   ├── permits/           # Health/work permits
│   ├── social_programs/   # Social assistance
│   ├── community/         # Community features
│   └── profile/           # User profile
└── shared/                # Shared components
    ├── widgets/           # Reusable UI components
    ├── services/          # Shared services
    └── models/            # Data models
```

### Clean Architecture
- **Entities** → **Repositories** → **UseCases** → **UI**
- **Riverpod** for state management
- **Mock repositories** first, real API integration later
- **Feature-first** organization for scalability

## 🎨 Design System

### shadcn/ui Inspired Components
- **ShadButton** - Multiple variants (primary, secondary, outline, ghost)
- **ShadCard** - Clean, modern card component
- **ShadInput** - Form input with validation
- **ShadBanner** - Alert/notification banners
- **ShadSkeleton** - Loading placeholders
- **ServiceCard** - Specialized service display cards

### Design Tokens
- Consistent spacing (4px, 8px, 12px, 16px, etc.)
- Border radius (6px, 8px, 12px, 16px)
- Typography scale with proper line heights
- Color palette with LGU-specific colors
- Shadow system (sm, md, lg)

## 🛠️ Technology Stack

### Core Dependencies
- **Flutter** - Cross-platform framework
- **Riverpod** - State management
- **GoRouter** - Navigation and routing
- **Hive** - Local storage
- **HTTP** - API communication

### UI & UX
- **Material Design 3** - Modern Material Design
- **Custom shadcn/ui components** - Clean, accessible UI
- **Responsive design** - Works on mobile, tablet, and desktop
- **Dark/Light mode support** - System theme adaptation

### Utilities
- **Formz** - Form validation
- **JSON Annotation** - Serialization
- **QR Flutter** - QR code generation
- **PDF** - Document generation
- **Image Picker** - Photo/document capture
- **Local Notifications** - Push notifications

## 📱 Cross-Platform Support

- **iOS** - Native iOS app
- **Android** - Native Android app
- **Web** - Progressive Web App
- **Desktop** - Windows, macOS, Linux support

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- VS Code / Android Studio (recommended IDE)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd e_lgu_mob
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (if needed)
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Development Commands

```bash
# Get dependencies
flutter pub get

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d windows         # Windows
flutter run -d macos           # macOS
flutter run -d linux           # Linux

# Build for production
flutter build apk              # Android APK
flutter build ios              # iOS
flutter build web              # Web
flutter build windows          # Windows
flutter build macos            # macOS
flutter build linux            # Linux

# Run tests
flutter test

# Analyze code
flutter analyze
```

## 🔧 Configuration

### Environment Setup
- Update `lib/core/constants/app_constants.dart` with your LGU information
- Configure API endpoints in the same file
- Set up mock data in `assets/data/mock_data.dart`

### API Integration
- Replace mock repositories with real API calls
- Update `lib/core/network/api_client.dart` with your backend endpoints
- Implement authentication flow in `lib/features/auth/`

## 📊 Mock Data

The app includes comprehensive mock data for testing:
- User profiles and authentication
- Business permit applications
- Property tax records
- Notifications and announcements
- Community events and job postings
- Social programs and marketplace items

## 🎯 Roadmap

### Phase 1 (Current)
- ✅ Basic app structure and navigation
- ✅ shadcn/ui design system
- ✅ Authentication flow (mock)
- ✅ Service pages and navigation
- ✅ Mock data integration

### Phase 2 (Next)
- [ ] Real API integration
- [ ] Payment gateway integration
- [ ] Document upload and management
- [ ] Push notifications
- [ ] Offline support

### Phase 3 (Future)
- [ ] Advanced features (maps, real-time updates)
- [ ] Multi-language support
- [ ] Advanced analytics
- [ ] Admin dashboard
- [ ] Third-party integrations

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:
- Email: support@lgu-mobile.ph
- Documentation: [docs.lgu-mobile.ph](https://docs.lgu-mobile.ph)
- Issues: [GitHub Issues](https://github.com/your-org/e_lgu_mob/issues)

## 🙏 Acknowledgments

- **shadcn/ui** - Design system inspiration
- **Flutter Team** - Amazing cross-platform framework
- **Riverpod** - Excellent state management solution
- **Local Government Units** - For their valuable input and requirements

---

**Built with ❤️ for Local Government Units and their residents**