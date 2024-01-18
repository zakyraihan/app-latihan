// ignore_for_file: avoid_unnecessary_containers

import 'package:app_latihan/user.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final data2 = ModalRoute.of(context)!.settings.arguments as Produk;

    return Scaffold(
        appBar: AppBar(
          title: const Text('page 1'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: TextEditingController(),
              ),
              Container(
                child: Text(
                    'dan data produk adalah ${data2.merek} dan harganya adalah ${data2.harga}'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/page2');
                  },
                  child: const Text("Next Page 2"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back"),
              )
            ],
          ),
        ));
  }
}
