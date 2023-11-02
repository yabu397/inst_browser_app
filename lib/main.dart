import 'package:flutter/material.dart';
import 'package:flutter_project/main/app.dart';
import 'package:flutter_project/main/observers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => mainCommon();

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    observers: [
      Observers(),
    ],
    child: const MyApp(),
  ));
}
