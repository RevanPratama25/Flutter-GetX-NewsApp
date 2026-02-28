import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  // 1️ Pastikan binding Flutter siap sebelum async
  WidgetsFlutterBinding.ensureInitialized();

  // 2️ Load ENV (API Key, Base URL, dll)
  await dotenv.load(fileName: ".env");

  // 3️ Jalankan app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0E1117), // dark navy
        primaryColor: const Color(0xFF1F6FEB), // tech blue
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1F6FEB),
          secondary: Color(0xFF58A6FF),
          surface: Color(0xFF161B22),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0E1117),
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFB1BAC4)),
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
