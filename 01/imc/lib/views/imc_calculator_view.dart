import 'package:flutter/material.dart';

class ImcCalculatorView extends StatefulWidget {
  const ImcCalculatorView({super.key});

  @override
  State<ImcCalculatorView> createState() => _ImcCalculatorViewState();
}

class _ImcCalculatorViewState extends State<ImcCalculatorView> {
  // Controladores para capturar o texto inserido nos campos de altura e peso
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  // Mensagem padrão exibida para o usuário
  String info = 'Informe os seus dados.';

  // Método que limpa os campos de entrada e redefine a mensagem
  void clear() {
    heightController.clear();
    weightController.clear();
    setState(() {
      info = 'Informe os seus dados.';
    });
  }

  // Método para calcular o IMC
  void calculate() {
    // Converte os valores de peso e altura do texto digitado para números
    final double peso = double.parse(weightController.text);
    final double altura = double.parse(heightController.text) / 100;

    // Verifica se os valores inseridos são válidos
    if (peso <= 0 || altura <= 0) {
      setState(() {
        info = "Por favor, insira valores válidos!";
      });
      return;
    }

    // Fórmula para calcular o IMC
    final double imc = peso / (altura * altura);

    // Atualiza o estado com a categoria correspondente ao IMC calculado
    setState(() {
      info = getImcCategory(imc);
    });
  }

  // Método auxiliar que retorna a mensagem baseada na categoria do IMC
  String getImcCategory(double imc) {
    if (imc < 18.6) {
      return "Abaixo do peso! Seu índice é de: ${imc.toStringAsFixed(2)}";
    } else if (imc < 24.9) {
      return "Ótimo! Seu índice é de: ${imc.toStringAsFixed(2)}";
    } else if (imc < 29.9) {
      return "Acima do peso! Seu índice é de: ${imc.toStringAsFixed(2)}";
    } else if (imc < 34.9) {
      return "Obesidade I! Seu índice é de: ${imc.toStringAsFixed(2)}";
    } else if (imc < 39.9) {
      return "Obesidade II! Seu índice é de: ${imc.toStringAsFixed(2)}";
    } else {
      return "Obesidade III! Seu índice é de: ${imc.toStringAsFixed(2)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Estrutura principal da tela
    return Scaffold(
      appBar: AppBar(
        // Barra superior com título e botão de limpar os valores e resultados
        title: const Text('Índice de Massa Corporal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: clear, // Chama o método de limpar os campos
          )
        ],
      ),
      backgroundColor: Colors.white, // Cor de fundo da tela
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.deepPurple,
              ),
              Padding(
                // Campo de entrada para a altura
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Altura em centímetros",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                  ),
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                // Campo de entrada para o peso
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Peso em quilogramas",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                  ),
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                // Botão para realizar o cálculo
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: 50.0,
                  child: FilledButton(
                    onPressed: calculate, // Chama o método de cálculo
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              // Exibição do resultado
              Text(
                info,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
