import 'package:flutter/material.dart';
import 'package:xadrez_app/service/chessservice.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  final _service = ChessApiService();

  String _titulo = "Carregando...";
  String _imagemUrl = "";

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _carregar() async {
    try {
      var dados = await _service.getDaily();
      setState(() {
        _titulo = dados['title'] ?? "Puzzle do Dia";
        _imagemUrl = dados['image'] ?? "";
      });
    } catch (e) {
      setState(() {
        _titulo = "Erro ao carregar puzzle do dia.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF312E2B),
      appBar: AppBar(
        title: Text(
          "Puzzle do Dia", 
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
                : Icon(Icons.image, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF81B64C)),
              onPressed: _carregar,
              child: Text("Recarregar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}