import 'package:webview_example/views/home_page_view.dart'; // Importa a tela inicial HomePageView.
import 'package:flutter/material.dart'; // Importa o pacote Flutter para construir a interface do usuário.

void main() async {
  // Função principal que inicia o aplicativo.
  runApp(
    const MaterialApp(
      // `MaterialApp` é o widget raiz que configura o aplicativo com estilo Material Design.
      home:
          HomePageView(), // Define a tela inicial do aplicativo como HomePageView.
    ),
  );
}
