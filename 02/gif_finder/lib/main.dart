// Importa a página inicial do aplicativo
import 'package:gif_finder/views/home_page_view.dart';

// Importa o pacote Flutter para construir interfaces de usuário
import 'package:flutter/material.dart';

// Importa a biblioteca 'dart:io' para lidar com requisições HTTP e manipulação de certificados SSL
import 'dart:io';

void main() {
  // Define um HttpOverride global para ignorar erros de certificados SSL inválidos
  HttpOverrides.global = MyHttpOverrides();

  // Inicia o aplicativo Flutter com o widget MaterialApp
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner:
          false, // Esconde o banner de debug no canto superior direito
      home: HomePageView(), // Define a página inicial como 'HomePageView'
    ),
  );
}

// Classe que sobrescreve o comportamento padrão do cliente HTTP para ignorar certificados SSL inválidos
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      // Ignora certificados SSL inválidos em conexões HTTP
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
