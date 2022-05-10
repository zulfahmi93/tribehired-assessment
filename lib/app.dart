import 'package:flutter/material.dart';

import 'routes/routes.dart';

class App extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const App({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      title: 'Comments Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
