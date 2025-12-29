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
import 'features/wallet/data/repositories/wallet_repository.dart';
import 'features/user/data/repositories/user_repository.dart';
import 'features/wallet/presentation/bloc/wallet_bloc.dart';
import 'features/wallet/presentation/bloc/send_money_bloc.dart';
import 'features/kyc/data/repositories/kyc_repository.dart';
import 'features/kyc/presentation/bloc/kyc_bloc.dart';
import 'features/user/presentation/bloc/profile_bloc.dart';
import 'features/user/data/repositories/payment_method_repository.dart';
import 'features/user/presentation/bloc/payment_method_bloc.dart';
import 'features/user/presentation/bloc/payment_method_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load from asset bundle

  // Dependencies
  final dio = Dio();
  const storage = FlutterSecureStorage();
  final dioClient = DioClient(dio, storage);
  final authRepository = AuthRepository(dioClient);
  final walletRepository = WalletRepository(dioClient);
  final userRepository = UserRepository(dioClient);
  final kycRepository = KYCRepository(dioClient);
  final paymentMethodRepository = PaymentMethodRepository(dioClient: dioClient);

  runApp(
    ProviderScope(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authRepository),
          RepositoryProvider.value(value: walletRepository),
          RepositoryProvider.value(value: userRepository),
          RepositoryProvider.value(value: kycRepository),
          RepositoryProvider.value(value: paymentMethodRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: authRepository, storage: storage)
                    ..add(AuthCheckRequested()),
            ),
            BlocProvider(create: (context) => WalletBloc(walletRepository)),
            BlocProvider(
              create: (context) => SendMoneyBloc(
                walletRepository: walletRepository,
                userRepository: userRepository,
              ),
            ),
            BlocProvider(
              create: (context) => KYCBloc(kycRepository: kycRepository),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(userRepository: userRepository),
            ),
            BlocProvider(
              create: (context) =>
                  PaymentMethodBloc(repository: paymentMethodRepository)
                    ..add(PaymentMethodListRequested()),
            ),
          ],
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
