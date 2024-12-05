// Importação do pacote Flutter, que contém todos os Widgets e ferramentas necessárias para criar interfaces.
import 'package:flutter/material.dart';

import 'package:imc/views/imc_calculator_view.dart';

// O ponto de entrada do aplicativo Flutter.
void main() => runApp(const MyApp());

// Criação da classe MyApp, que será o Widget principal do aplicativo.
// Essa classe estende StatelessWidget, ou seja, representa uma interface que não muda
class MyApp extends StatelessWidget {
  // O construtor constante, útil para widgets imutáveis e otimizações.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // O MaterialApp é o Widget raiz do aplicativo, que configura o tema e a navegação.
    return MaterialApp(
      // Título do aplicativo, exibido em alguns lugares dependendo da plataforma.
      title: 'Índice de Massa Corporal',
      debugShowCheckedModeBanner: false,

      // Tema do aplicativo, usado para configurar a base de cores, fontes e outros estilos.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // Propriedade (home) define a primeira tela do aplicativo.

      home: const ImcCalculatorView(),
    );
  }
}
