import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/data/repositories/remote_register_repository.dart';
import 'package:flutter_chat/firebase_options.dart';
import 'package:flutter_chat/ui/auth/widgets/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'data/services/firebase_register.dart';
import 'data/services/register_client.dart';
import 'ui/auth/viewmodel/register_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        Provider<RegisterClient>(create: (context) => FirebaseRegister()),
        ChangeNotifierProvider(
          create: (context) =>
              FirebaseRegisterRepository(service: context.read()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen(
          viewModel: RegisterViewModel(repository: context.read()),
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}
