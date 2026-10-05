import 'package:flutter/material.dart';
import 'package:xadrez_app/service/chessservice.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final _service = ChessApiService();

  List<dynamic> _top10Diario = [];
  List<dynamic> _top10Blitz = [];
  bool _carregando = true;
  String _mensagemErro = "";

  @override
  void initState() {
    super.initState();
    _carregarRankings();
  }

  void _carregarRankings() async {
    try {
      var dados = await _service.getLeaderboards();
      
      List listaDiaria = dados['daily'] ?? [];
      List listaBlitz = dados['live_blitz'] ?? [];

      setState(() {
        _top10Diario = listaDiaria.take(10).toList();
        _top10Blitz = listaBlitz.take(10).toList();
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _mensagemErro = "Erro ao carregar os rankings.";
        _carregando = false;
      });
    }
  }

  Widget _construirListaRanking(List<dynamic> lista) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: lista.length,
      itemBuilder: (context, index) {
        var jogador = lista[index];
        String avatarUrl = jogador['avatar'] ?? "";

        return Card(
          color: Color(0xFF262421),
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF81B64C),
              child: Text(
                "#${index + 1}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              jogador['username'] ?? "Jogador",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Pontos: ${jogador['score'] ?? 0}",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: avatarUrl.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                  )
                : Icon(Icons.person, color: Colors.grey),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFF312E2B),
        appBar: AppBar(
          title: Text(
            "Rankings Globais", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF262421),
          foregroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Color(0xFF81B64C),
            labelColor: Color(0xFF81B64C),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Diário (Daily)"),
              Tab(text: "Blitz Ao Vivo"),
            ],
          ),
        ),
        body: _carregando
            ? Center(child: CircularProgressIndicator(color: Color(0xFF81B64C)))
            : _mensagemErro.isNotEmpty
                ? Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  )
                : TabBarView(
                    children: [
                      _construirListaRanking(_top10Diario),
                      _construirListaRanking(_top10Blitz),
                    ],
                  ),
      ),
    );
  }
}