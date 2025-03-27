import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  EstadoApp createState() => EstadoApp();
}

class EstadoApp extends State<App> {
  final List<String> opcoes = ['pedra', 'papel', 'tesoura'];
  final Random random = Random();
  String escolhaUsuario = '';
  String escolhaApp = '';
  int pontosUsuario = 0;
  int pontosEmpate = 0;
  int pontosApp = 0;

  void jogar(String escolha) {
    setState(() {
      escolhaUsuario = escolha;
      escolhaApp = opcoes[random.nextInt(3)];
      if (escolhaUsuario == escolhaApp) {
        pontosEmpate++;
      } else if ((escolhaUsuario == 'pedra' && escolhaApp == 'tesoura') ||
          (escolhaUsuario == 'tesoura' && escolhaApp == 'papel') ||
          (escolhaUsuario == 'papel' && escolhaApp == 'pedra')) {
        pontosUsuario++;
      } else {
        pontosApp++;
      }
    });
  }

  Widget exibirImagem(String escolha) {
    return escolha.isEmpty
        ? Container(height: 100)
        : Image.asset('assets/images/$escolha.png', height: 100);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Pedra, Papel, Tesoura')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Disputa', style: TextStyle(fontSize: 22)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                exibirImagem(escolhaUsuario),
                SizedBox(width: 20),
                Text('vs', style: TextStyle(fontSize: 22)),
                SizedBox(width: 20),
                exibirImagem(escolhaApp),
              ],
            ),
            SizedBox(height: 20),
            Text('Placar', style: TextStyle(fontSize: 22)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                placarItem('Você', pontosUsuario),
                placarItem('Empate', pontosEmpate),
                placarItem('Máquina', pontosApp),
              ],
            ),
            SizedBox(height: 20),
            Text('Opções', style: TextStyle(fontSize: 22)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: opcoes.map((escolha) => botaoEscolha(escolha)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget botaoEscolha(String escolha) {
    return GestureDetector(
      onTap: () => jogar(escolha),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Image.asset('assets/images/$escolha.png', height: 80),
      ),
    );
  }

  Widget placarItem(String titulo, int pontuacao) {
    return Column(
      children: [
        Text(titulo, style: TextStyle(fontSize: 18)),
        Container(
          width: 80,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Text('$pontuacao', style: TextStyle(fontSize: 22)),
        ),
      ],
    );
  }
}
