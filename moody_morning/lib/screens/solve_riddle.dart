import 'package:flutter/material.dart';
import '../widgets/logo_app_bar.dart';

class SolveRiddle extends StatefulWidget {
  @override
  _SlidePuzzleBoardState createState() => _SlidePuzzleBoardState();
}

class _SlidePuzzleBoardState extends State<SolveRiddle> {
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
          crossAxisCount: 4, 
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (tiles[index] == 15) {
                // if Empty tile was clicked, do nothing
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
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF8F8BBF),
            ),
            onPressed: () => print("hej"),
            child: FloatingActionButton(
              onPressed: null, // Set this to null since onPressed is handled by ElevatedButton
              child: Text("Reset"),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              ),
            ),
          );
         }
        }
