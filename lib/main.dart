import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_constants.dart';
import 'core/navigation/app_router.dart';
import 'features/auth/presentation/providers/auth_providers.dart';
import 'theme/shadcn_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const LguApp(),
    ),
  );
}

class LguApp extends StatelessWidget {
  const LguApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ShadcnTheme.createTheme(),
      darkTheme: ShadcnTheme.createTheme(), // TODO: Create dark theme
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
