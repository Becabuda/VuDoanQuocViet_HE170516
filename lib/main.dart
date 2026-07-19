import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/user_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: UserManagerApp()));
}

class UserManagerApp extends StatelessWidget {
  const UserManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF3949AB));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Manager',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      home: const UserListScreen(),
    );
  }
}
