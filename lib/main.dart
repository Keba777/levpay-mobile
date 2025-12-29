import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/network/dio_client.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load from asset bundle

  // Dependencies
  final dio = Dio();
  const storage = FlutterSecureStorage();
  final dioClient = DioClient(dio, storage);
  final authRepository = AuthRepository(dioClient);

  runApp(
    ProviderScope(
      child: RepositoryProvider.value(
        value: authRepository,
        child: BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: authRepository, storage: storage)
                ..add(AuthCheckRequested()),
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'LevPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.deepTeal),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
