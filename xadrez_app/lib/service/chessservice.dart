import 'dart:convert';
import 'package:http/http.dart' as http;

class ChessApiService {
  Future<Map<String, dynamic>> getPlayer(String nome) async {
    final response = await http.get(
      Uri.parse("https://api.chess.com/pub/player/${nome.trim()}"),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Jogador não encontrado');
  }

  Future<Map<String, dynamic>> getDaily() async {
    final response = await http.get(
      Uri.parse("https://api.chess.com/pub/puzzle"),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Erro ao carregar puzzle do dia');
  }

  Future<Map<String, dynamic>> getRandom() async {
    final response = await http.get(
      Uri.parse("https://api.chess.com/pub/puzzle/random"),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Erro ao carregar puzzle aleatório');
  }

  Future<Map<String, dynamic>> getLeaderboards() async {
    final response = await http.get(
      Uri.parse("https://api.chess.com/pub/leaderboards"),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Erro ao carregar ranking');
  }
}