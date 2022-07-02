import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_pvd/provider_setup.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) => MaterialApp.router(
        title: 'PDV Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routeInformationParser:
            context.watch<GoRouter>().routeInformationParser,
        routeInformationProvider:
            context.watch<GoRouter>().routeInformationProvider,
        routerDelegate: context.watch<GoRouter>().routerDelegate,
      ),
    );
  }
}
