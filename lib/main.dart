import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

var request = Uri.https('api.hgbrasil.com', '/finance');

void main() async {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? ibovespaNome;
  String? ibovespaLocal;
  String? ibovespaPontos;
  String? ibovespaVariacao;

  String? nasdaqNome;
  String? nasdaqLocal;
  String? nasdaqPontos;
  String? nasdaqVariacao;

  String? nikkeiNome;
  String? nikkeiLocal;
  String? nikkeiVariacao;

  String? cacNome;
  String? cacLocal;
  String? cacVariacao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0B0B45),
      appBar: AppBar(
        title: Text("Bolsa de Valores no Mundo"),
        backgroundColor: Color(0xff0B0B45),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: pegarDados(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    "Carregando Dados...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Erro ao Carregar os Dados",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  ibovespaNome =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["IBOVESPA"]["name"]
                          .toString();
                  ibovespaLocal =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["IBOVESPA"]["location"]
                          .toString();
                  ibovespaPontos =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["IBOVESPA"]["points"]
                          .toString();
                  ibovespaVariacao =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["IBOVESPA"]["variation"]
                          .toString();

                  nasdaqNome =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["NASDAQ"]["name"]
                          .toString();
                  nasdaqLocal =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["NASDAQ"]["location"]
                          .toString();
                  nasdaqPontos =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["NASDAQ"]["points"]
                          .toString();
                  nasdaqVariacao =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["NASDAQ"]["variation"]
                          .toString();

                  nikkeiNome =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["NIKKEI"]["name"]
                          .toString();
                  nikkeiLocal =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["NIKKEI"]["location"]
                          .toString();
                  nikkeiVariacao =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["NIKKEI"]["variation"]
                          .toString();

                  cacNome = (snapshot.data as Map<String, dynamic>)["results"]
                          ["stocks"]["CAC"]["name"]
                      .toString();
                  cacLocal = (snapshot.data as Map<String, dynamic>)["results"]
                          ["stocks"]["CAC"]["location"]
                      .toString();
                  cacVariacao =
                      (snapshot.data as Map<String, dynamic>)["results"]
                              ["stocks"]["CAC"]["variation"]
                          .toString();

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          "images/bolsa.jpg",
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                        const SizedBox(height: 60),
                        construirTexto(ibovespaNome!),
                        construirTexto(ibovespaLocal!),
                        construirTexto(ibovespaPontos!),
                        construirTexto(ibovespaVariacao!),
                        const SizedBox(height: 40),
                        construirTexto(nasdaqNome!),
                        construirTexto(nasdaqLocal!),
                        construirTexto(nasdaqPontos!),
                        construirTexto(nasdaqVariacao!),
                        const SizedBox(height: 40),
                        construirTexto(nikkeiNome!),
                        construirTexto(nikkeiLocal!),
                        construirTexto(nikkeiVariacao!),
                        const SizedBox(height: 40),
                        construirTexto(cacNome!),
                        construirTexto(cacLocal!),
                        construirTexto(cacVariacao!),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Future<Map> pegarDados() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

Widget construirTexto(String texto) {
  return Text(
    texto,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.white,
      fontSize: 25,
    ),
  );
}
