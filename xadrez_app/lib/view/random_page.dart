import 'package:flutter/material.dart';
import 'package:xadrez_app/service/chessservice.dart';

class RandomPage extends StatefulWidget {
  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  final _service = ChessApiService();

  String _titulo = "Clique no botão para carregar";
  String _imagemUrl = "";

  void _carregarAleatorio() async {
    try {
      var dados = await _service.getRandom();
      setState(() {
        _titulo = dados['title'] ?? "Puzzle Aleatório";
        _imagemUrl = dados['image'] ?? "";
      });
    } catch (e) {
      setState(() {
        _titulo = "Erro ao carregar puzzle aleatório.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF312E2B),
      appBar: AppBar(
        title: Text(
          "Puzzle Aleatório", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF262421),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _titulo,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _imagemUrl.isNotEmpty
                ? Image.network(_imagemUrl, height: 250)
                : Icon(Icons.casino, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF81B64C)),
              onPressed: _carregarAleatorio,
              child: Text("Gerar Novo Puzzle", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}