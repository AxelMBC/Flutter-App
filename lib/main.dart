import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text('My Flutter App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text Widget
              const Text(
                'Hello  World!',
                style: TextStyle(fontSize: 24, color: Colors.indigo),
              ),

              // Container Widget
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                color: Colors.deepPurple[100],
                child: const Text('Estoy en un contenedor'),
              ),

              // Row Widget
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(10),
                    child: const Text('Row 1'),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text('Row 2'),
                  ),
                ],
              ),

              // Stack Widget
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(top: 20),
                    color: Colors.blueAccent,
                  ),
                  const Positioned(
                    top: 50,
                    child: Text(
                      'Stacked Text',
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
