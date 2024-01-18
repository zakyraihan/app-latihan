import 'package:app_latihan/page1.dart';
import 'package:app_latihan/page2.dart';
import 'package:app_latihan/page3.dart';
import 'package:app_latihan/user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/page1': (context) => const Page1(),
        '/page2': (context) => const Page2(),
        '/page3': (context) => const Page3()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/page1',
                    arguments:
                        // User('example@gmail.com', '12345', 12),
                        Produk('odol pepsodent', 20.000),
                  );
                },
                child: const Text("Next Page 1"),
              )
            ],
          ),
        ));
  }
}
