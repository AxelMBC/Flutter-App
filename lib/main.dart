import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart'; // Asegúrate de importar el paquete crypto
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String apiResponse = '';

  // Reemplaza estos valores con tus propias claves
  final String publicKey = 'af519fae84fa8ac473c02331d4de6d0b';
  final String privateKey =
      '0c677a8885006ae695f75054dc1e948fed9509a2'; // Tu clave privada

  Future<void> fetchMarvelData() async {
    final String ts = DateTime.now().millisecondsSinceEpoch.toString();
    final String hash =
        md5.convert(utf8.encode(ts + privateKey + publicKey)).toString();

    final Uri url = Uri.https(
      'gateway.marvel.com',
      '/v1/public/characters',
      {
        'apikey': publicKey,
        'ts': ts,
        'hash': hash,
      },
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final characters = data['data']['results'] as List;
        setState(() {
          apiResponse = characters.map((char) => char['name']).join(',\n ');
        });
      } else {
        setState(() {
          apiResponse =
              'Error ${response.statusCode}: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        apiResponse = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 103, 174, 192),
          title: const Text(
            'My Flutter App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            // Imagen de fondo
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // Contenido principal
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Aplicación de Flutter',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '¡Bienvenido a la aplicación!',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: fetchMarvelData,
                    child: const Text('Obtener datos de Marvel'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(apiResponse),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
