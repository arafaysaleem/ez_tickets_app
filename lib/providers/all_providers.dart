import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/networking/api_service.dart';

import 'auth_provider.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService(ref.read));

final authProvider = Provider<AuthProvider>((ref) => AuthProvider(ref.read));


