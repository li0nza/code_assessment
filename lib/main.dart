import 'package:code_assesment/bloc_observer.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_cubit.dart';
import 'package:code_assesment/presentation/pages/gilded_rose_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

/// This widget is the entry-point of the Widget-tree.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Initialize global state management, keep this to a minimum.
      providers: [
        BlocProvider(
          create: (_) => di.locator<GildedRoseCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'The Gilded Rose',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFFA10123),
            secondary: const Color(0xFF312E39),
            background: const Color(0xFF312E39).withOpacity(0.4),
            onBackground: Colors.black12,
            onSecondary: Colors.white,
          ),
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 22.0),
              labelLarge: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: TextStyle(
                fontSize: 14.0,
              ),
              titleMedium: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              labelSmall: TextStyle(
                fontSize: 12,
                color: Colors.white70,
                letterSpacing: 0.2,
              )),
        ),
        home: const GildedRosePage(),
      ),
    );
  }
}
