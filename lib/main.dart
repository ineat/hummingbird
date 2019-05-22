import 'package:flutter_web/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const _redPrimaryValue = 0xFFeb1e54;

  static const MaterialColor red = const MaterialColor(
    _redPrimaryValue,
    const <int, Color>{
      50: const Color(0xFFfde4ea),
      100: const Color(0xFFf9bccc),
      200: const Color(0xFFf58faa),
      300: const Color(0xFFf16287),
      400: const Color(0xFFee406e),
      500: const Color(_redPrimaryValue),
      600: const Color(0xFFe91a4d),
      700: const Color(0xFFe51643),
      800: const Color(0xFFe2123a),
      900: const Color(0xFFdd0a29),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: red,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Lato",
        textTheme: TextTheme(
          title: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900, fontFamily: "Lato-Bold"),
          body1: TextStyle(fontSize: 17.0),
          caption: TextStyle(fontSize: 28.0),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}