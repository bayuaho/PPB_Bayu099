import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(

        appBar: AppBar(
          title: const Text("Layout Flutter"),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              Container(
                width: double.infinity,
                height: 100,
                color: Colors.blue,

                child: const Center(
                  child: Text(
                    "Header",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 100,
                      color: Colors.orange,

                      child: const Center(
                        child: Text("Menu 1"),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      height: 100,
                      color: Colors.green,

                      child: const Center(
                        child: Text("Menu 2"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}