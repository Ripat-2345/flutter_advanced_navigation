import 'package:flutter/material.dart';
import 'package:flutter_advanced_navigation/db/auth_repository.dart';
import 'package:flutter_advanced_navigation/provider/auth_provider.dart';
import 'package:flutter_advanced_navigation/routes/router_delegate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({super.key});

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    authProvider = AuthProvider(authRepository);
    myRouterDelegate = MyRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MaterialApp(
        title: 'Quotes App',
        home: Router(
          routerDelegate: myRouterDelegate,
          // Untuk memaksimalkan penggunaan widget Router, Anda perlu menambahkan properti backButtonDispatcher. Properti ini digunakan untuk mengatasi perilaku System Back Button pada perangkat Android.
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
