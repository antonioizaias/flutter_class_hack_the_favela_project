// Importa o pacote HTTP para fazer requisições web
import 'package:http/http.dart' as http;

// Importa o Flutter para construir a interface de usuário
import 'package:flutter/material.dart';

// Importa a biblioteca 'dart:convert' para converter JSON
import 'dart:convert';

// Declara a classe HomePageView como um widget de estado mutável
class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  // Variável para armazenar o termo de pesquisa
  String search = '';

  // Função para buscar GIFs da API do Giphy
  Future getGifs() async {
    http.Response response;

    // Se a pesquisa estiver vazia, busca GIFs em alta
    if (search == '') {
      response = await http.get(
        Uri.parse(
            'https://api.giphy.com/v1/gifs/trending?api_key=KOqsgGxUoXOVRqDyXxOavlKQkKihNIly&limit=20&offset=0&rating=g&bundle=messaging_non_clips'),
      );
    }
    // Caso contrário, faz uma busca com o termo fornecido
    else {
      response = await http.get(
        Uri.parse(
            'https://api.giphy.com/v1/gifs/search?api_key=KOqsgGxUoXOVRqDyXxOavlKQkKihNIly&q=$search&limit=20&offset=0&rating=g&lang=pt&bundle=messaging_non_clips'),
      );
    }
    // Decodifica o corpo da resposta em JSON e retorna
    return json.decode(response.body);
  }

  // Função chamada quando o widget é inicializado
  @override
  void initState() {
    debugPrint('Início');
    final stopwatch = Stopwatch();
    stopwatch.start();

    // Chama a função getGifs() e mede o tempo de execução
    getGifs().then((response) {
      stopwatch.stop();
      debugPrint('Tempo de execução: ${stopwatch.elapsedMilliseconds}ms');
      debugPrint('Response: $response');
    });

    debugPrint('Fim');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
          'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif',
        ),
      ),
      body: Column(
        children: [
          // Campo de texto para a pesquisa de GIFs
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Pesquise aqui',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              // Atualiza o termo de pesquisa ao submeter
              onSubmitted: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          // Exibe os GIFs usando um FutureBuilder
          Expanded(
            child: FutureBuilder(
              future: getGifs(), // Chama a função para buscar GIFs
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    // Mostra um indicador de carregamento enquanto aguarda a resposta
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white,
                        ),
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      // Mostra uma mensagem de erro se algo der errado
                      return const Center(
                        child: Text(
                          'Erro ao carregar os dados',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      // Exibe os GIFs em um GridView se os dados forem recebidos com sucesso
                      return gridViewGifs(
                        context,
                        snapshot,
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Função para criar uma grade de imagens de GIFs
Widget gridViewGifs(BuildContext context, AsyncSnapshot snapshot) {
  return GridView.builder(
    padding: const EdgeInsets.all(10.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Define 2 colunas na grade
      crossAxisSpacing: 10.0, // Espaçamento horizontal entre os itens
      mainAxisSpacing: 10.0, // Espaçamento vertical entre os itens
    ),
    itemCount: snapshot
        .data["data"].length, // Número de itens baseado na resposta da API
    itemBuilder: (context, index) {
      // Cada item é uma imagem de GIF da resposta da API
      return GestureDetector(
        child: Image.network(
          snapshot.data['data'][index]['images']['fixed_height']['url'],
          height: 300.0,
          fit: BoxFit.cover, // Ajusta a imagem para preencher a área disponível
        ),
      );
    },
  );
}
