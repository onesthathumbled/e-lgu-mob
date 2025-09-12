# LGU Mobile App - Demo Guide

## 🚀 **How to Access All Features**

The app is running at: **http://localhost:8080**

### **Step 1: Login**
1. Open the app in your browser
2. Use these demo credentials:
   - **Email**: `john.doe@email.com`
   - **Password**: `password123`
3. Click "Sign In" or "Sign in with eGovPH"

### **Step 2: Explore the Home Page**
After login, you'll see the new **Home Page** with:
- **Welcome banner** with LGU branding
- **Quick Services Grid** showing all available services
- **Community section**
- **Information banner**

### **Step 3: Access All Services**

#### **Method 1: From Home Page (Recommended)**
Click on any service card in the "Quick Services" grid:
- 🏢 **Business Permits** (Blue) - BPLS Services
- 🏠 **Property Tax** (Green) - RPT Payments  
- 💳 **Digital ID** (Orange) - LGU ID Services
- 📄 **Civil Registry** (Purple) - Birth, Marriage, Death
- 🏥 **Permits** (Red) - Health, Work, Sanitation
- 🤝 **Social Programs** (Teal) - Assistance & Aid
- 👥 **Community** (Indigo) - Events, Jobs, Marketplace

#### **Method 2: From Services Menu**
1. Click the **hamburger menu** (☰) in the top-right corner
2. Select any service from the drawer menu

#### **Method 3: From Bottom Navigation**
- **Home** - Main dashboard
- **Services** - All LGU services
- **Community** - Community features
- **Profile** - User profile

### **Step 4: Test the Implemented Features**

#### **✅ Business Permits**
1. Go to Business Permits
2. Click "New Business Permit"
3. Fill out the comprehensive form:
   - Business information
   - Business address
   - Owner information
4. Submit the application

#### **✅ Property Tax Payment**
1. Go to Property Tax
2. Click "Pay Real Property Tax"
3. Use demo data:
   - **TD Number**: `TD-2024-001`
   - **PIN**: `PIN-123456789`
4. Click "Search Property"
5. Review property details
6. Select payment method
7. Process payment

#### **✅ Digital ID Registration**
1. Go to Digital ID
2. Click "Apply for Digital ID"
3. Fill out the registration form:
   - Personal information
   - Government IDs (optional)
   - Current address
4. Submit registration
5. View generated QR code

### **Step 5: Navigation Features**

#### **Bottom Navigation Bar**
- **Home** - Returns to main dashboard
- **Services** - Shows all LGU services
- **Community** - Community features
- **Profile** - User profile and settings

#### **Services Drawer Menu**
Access via hamburger menu (☰) in top-right:
- Business Permits
- Property Tax
- Digital ID
- Civil Registry
- Permits
- Social Programs
- Community

### **🎯 Key Features to Test**

1. **Authentication Flow**
   - Login with demo credentials
   - eGovPH SSO mock login
   - Navigation after login

2. **Business Permit Application**
   - Complete form with validation
   - Address information
   - Owner details
   - Submission confirmation

3. **Property Tax Payment**
   - Property search functionality
   - Payment method selection
   - Mock payment processing
   - Success confirmation

4. **Digital ID Registration**
   - Personal information form
   - Date picker for birth date
   - Government ID fields
   - QR code generation
   - Success page with downloadable QR

5. **Navigation & UI**
   - Responsive design
   - Loading states
   - Error handling
   - Success messages
   - Form validation

### **🔧 Technical Features**

- **State Management**: Riverpod for reactive UI
- **Navigation**: GoRouter with nested routes
- **Design System**: shadcn/ui inspired components
- **Form Validation**: Built-in validation
- **Error Handling**: User-friendly error messages
- **Loading States**: Progress indicators
- **Responsive Design**: Works on all screen sizes

### **📱 Cross-Platform Ready**

The app is built for:
- ✅ **Web** (currently running)
- ✅ **iOS** (ready to build)
- ✅ **Android** (ready to build)
- ✅ **Desktop** (Windows, macOS, Linux)

### **🚀 Next Steps**

The app is ready for:
- Real API integration
- Payment gateway integration
- Document generation
- Push notifications
- Offline support
- Multi-language support

---

**Enjoy exploring the LGU Mobile App!** 🎉
