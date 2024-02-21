import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Product App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('hallo'),
        ),
        body: const Center(child: Text('oke')),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
