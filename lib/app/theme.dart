import 'package:flutter/material.dart';

ThemeData buildTheme() {
  const seedColor = Color(0xFF2B2D42);
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
    textTheme: const TextTheme(
      displaySmall: TextStyle(fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
