import 'package:flutter/material.dart';
import 'player_page.dart';
import 'daily_page.dart';
import 'random_page.dart';
import 'leaderboards_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF312E2B),
      appBar: AppBar(
        title: Text(
          "Chess.com App", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF262421),
        foregroundColor: Colors.white, 
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF81B64C),
                padding: EdgeInsets.all(20.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayerPage()),
                );
              },
              child: Text("Buscar Jogador", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF81B64C),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DailyPage()),
                );
              },
              child: Text("Puzzle do Dia", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF81B64C),
                padding: EdgeInsets.all(20.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RandomPage()),
                );
              },
              child: Text("Puzzle Aleatório", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF81B64C),
                padding: EdgeInsets.all(20.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardPage()),
                );
              },
              child: Text("Ranking Global", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}