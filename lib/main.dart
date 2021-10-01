import 'package:amazon_clone/globals.dart';
import 'package:amazon_clone/pages/IndexPage.dart';
import 'package:amazon_clone/providers/IndexPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexPageProvider()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'AmazonEmber-Regular',
        scaffoldBackgroundColor: Colors.grey.shade300,
      ),
      home: IndexPage(),
    );
  }
}
