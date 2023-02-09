import 'package:clima_app/pages/home_page.dart';
import 'package:clima_app/providers/basedatos_provider.dart';
import 'package:clima_app/providers/shearch_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShearchPlacesProvider()),
        ChangeNotifierProvider(create: (_) => DataBaseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<DataBaseProvider>(context, listen: false);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PorrazoApp',
      home: HomePage(),
    );
  }
}
