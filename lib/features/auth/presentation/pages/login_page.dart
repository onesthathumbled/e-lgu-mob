import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../providers/auth_state_providers.dart';

/// Login page for user authentication
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    final authNotifier = ref.read(authStateProvider.notifier);
    
    await authNotifier.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _loginWithEgovPh() async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    // Mock eGovPH SSO token
    await authNotifier.loginWithEgovPh(
      ssoToken: 'mock_egovph_token_12345',
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    
    // Listen to auth state changes
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      switch (next) {
        case AuthInitial():
        case AuthLoading():
          break;
        case AuthAuthenticated():
          // Navigate to home page on successful login
          context.go(AppRouter.home);
          break;
        case AuthUnauthenticated():
          break;
        case AuthError():
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          break;
        case AuthPasswordResetEmailSent():
        case AuthPasswordResetSuccess():
        case AuthPasswordChanged():
        case AuthEmailVerified():
        case AuthVerificationEmailSent():
          break;
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                
                // Logo and title
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.account_balance,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome Back',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to your LGU account',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Email field
                ShadInput(
                  label: 'Email',
                  placeholder: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  helperText: 'Use john.doe@email.com for demo',
                ),
                
                const SizedBox(height: 16),
                
                // Password field
                ShadInput(
                  label: 'Password',
                  placeholder: 'Enter your password',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  helperText: 'Use password123 for demo',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.go(AppRouter.forgotPassword);
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Login button
                ShadButton(
                  text: 'Sign In',
                  onPressed: _login,
                  isLoading: authState is AuthLoading,
                  fullWidth: true,
                ),
                
                const SizedBox(height: 24),
                
                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // eGovPH SSO button
                ShadButton(
                  text: 'Sign in with eGovPH',
                  variant: ShadButtonVariant.outline,
                  onPressed: _loginWithEgovPh,
                  isLoading: authState is AuthLoading,
                  icon: const Icon(Icons.security),
                  fullWidth: true,
                ),
                
                const SizedBox(height: 32),
                
                // Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        context.go(AppRouter.register);
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
