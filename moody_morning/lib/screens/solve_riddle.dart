import 'package:flutter/material.dart';
import '../widgets/logo_app_bar.dart';

class SolveRiddle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide Puzzle',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SlidePuzzleBoard(),
    );
  }
}


class SlidePuzzleBoard extends StatefulWidget {
  @override
  _SlidePuzzleBoardState createState() => _SlidePuzzleBoardState();
}

class _SlidePuzzleBoardState extends State<SlidePuzzleBoard> {
  final List<int> tiles = List.generate(16, (index) => index); // Create a list of tile numbers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF423E72),
      appBar: LogoAppBar(
      ),
      body: GridView.builder(
        itemCount: tiles.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Number of columns
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle tile click
              if (tiles[index] == 15) {
                // Empty tile was clicked, do nothing
                return;
              }
              if (index % 4 != 3 && tiles[index + 1] == 15) {
                // Clicked tile can slide right
                setState(() {
                  tiles[index + 1] = tiles[index];
                  tiles[index] = 15;
                });
              } else if (index % 4 != 0 && tiles[index - 1] == 15) {
                // Clicked tile can slide left
                setState(() {
                  tiles[index - 1] = tiles[index];
                  tiles[index] = 15;
                });
              } else if (index < 12 && tiles[index + 4] == 15) {
                // Clicked tile can slide down
                setState(() {
                  tiles[index + 4] = tiles[index];
                  tiles[index] = 15;
                });
              } else if (index >= 4 && tiles[index - 4] == 15) {
                // Clicked tile can slide up
                setState(() {
                  tiles[index - 4] = tiles[index];
                  tiles[index] = 15;
                });
              }
            },
            child: Container(
              margin: EdgeInsets.all(2),
              color: tiles[index] != 15 ? Color(0xFF8F8BBF) : Colors.white, // Set tile color
              child: Center(
                child: Text(
                  tiles[index] != 15 ? tiles[index].toString() : '', // Display tile number
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
