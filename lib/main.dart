import 'package:flutter/material.dart';
import 'package:list_product/detail/product_detail.dart';
import 'package:list_product/home/list_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const ListProduct(),
        '/detail': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;

          if (arguments is String) {
            return ProductDetail(id: arguments);
          } else {
            return Scaffold(appBar: AppBar(), body: Container());
          }
        },
      },
    );
  }
}
