import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//providers
import '../../providers/all_providers.dart';

//routes
import 'home_screen.dart';
import 'welcome_screen.dart';

class AppStartupScreen extends HookWidget {
  const AppStartupScreen();

  Widget build(BuildContext context) {
    final authState = useProvider(authProvider);
    return authState.maybeWhen(
      authenticated: (fullName) => const WelcomeScreen(),
      orElse: () => const HomeScreen(),
    );
  }
}

