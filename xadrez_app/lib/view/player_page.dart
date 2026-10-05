import 'package:flutter/material.dart';
import 'package:xadrez_app/service/chessservice.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final _service = ChessApiService();
  final _nomeController = TextEditingController();

  Map<String, dynamic>? _jogador;
  String _mensagemErro = "";
  bool _carregando = false;

  String _formatarData(int? timestamp) {
    if (timestamp == null) return "Não informado";
    var data = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";
  }

  void _buscar() async {
    String nome = _nomeController.text.trim();

    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Digite o nome de um jogador!")),
      );
      return;
    }

    setState(() {
      _carregando = true;
      _mensagemErro = "";
      _jogador = null;
    });

    try {
      var dados = await _service.getPlayer(nome);
      setState(() {
        _jogador = dados;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _mensagemErro = "Jogador não encontrado!";
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String avatarUrl = _jogador?['avatar'] ?? "";

    return Scaffold(
      backgroundColor: Color(0xFF312E2B),
      appBar: AppBar(
        title: Text(
          "Buscar Jogador", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF262421),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Nome do jogador",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF81B64C)),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF81B64C)),
              onPressed: _buscar,
              child: Text("Buscar", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 25),

            if (_carregando)
              CircularProgressIndicator(color: Color(0xFF81B64C)),

            if (_mensagemErro.isNotEmpty)
              Text(
                _mensagemErro,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),

            if (_jogador != null) ...[
              avatarUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(avatarUrl, height: 140),
                    )
                  : Icon(Icons.person, size: 120, color: Colors.grey),

              SizedBox(height: 15),

              Text(
                _jogador!['username'] ?? "",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (_jogador!['name'] != null)
                Text(
                  _jogador!['name'],
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

              SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF262421),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_jogador!['title'] != null)
                      _itemInfo("Título Oficial", _jogador!['title'], corValor: Colors.amber),
                    _itemInfo("ID do Jogador", "${_jogador!['player_id'] ?? 'N/A'}"),
                    _itemInfo("Seguidores", "${_jogador!['followers'] ?? 0}"),
                    _itemInfo("Status da Conta", _jogador!['status'] ?? "Ativo"),
                    _itemInfo("Liga Atual", _jogador!['league'] ?? "Sem liga"),
                    _itemInfo("Conta Verificada", _jogador!['verified'] == true ? "Sim" : "Não"),
                    _itemInfo("Data de Cadastro", _formatarData(_jogador!['joined'])),
                    _itemInfo("Último Acesso", _formatarData(_jogador!['last_online'])),
                    if (_jogador!['location'] != null)
                      _itemInfo("Localização", _jogador!['location']),
                    if (_jogador!['is_streamer'] == true)
                      _itemInfo("Streamer", "Sim (${_jogador!['twitch_url'] ?? 'Twitch'})"),
                    if (_jogador!['url'] != null)
                      _itemInfo("Perfil Chess.com", _jogador!['url']),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _itemInfo(String titulo, String valor, {Color corValor = Colors.white}) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$titulo: ",
            style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              valor,
              style: TextStyle(color: corValor, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}