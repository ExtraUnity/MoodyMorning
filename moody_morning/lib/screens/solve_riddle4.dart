/*import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../widgets/logo_app_bar.dart';


class SolveRiddle4 extends StatefulWidget {
  @override
  _SlidePuzzleBoardState4 createState() => _SlidePuzzleBoardState4();
}

class _SlidePuzzleBoardState4 extends State<SolveRiddle4> {
  final List<int> tiles = List.generate(16, (index) => index); // Create a list of tile numbers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF423E72),
      appBar: LogoAppBar(
      ),
      body: GridView.builder(
        itemCount: tiles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              } else if (index < 12 && tiles[index + 3] == 15) {
                // Clicked tile can slide down
                setState(() {
                  tiles[index + 3] = tiles[index];
                  tiles[index] = 15;
                });
              } else if (index >= 3 && tiles[index - 3] == 15) {
                // Clicked tile can slide up
                setState(() {
                  tiles[index - 3] = tiles[index];
                  tiles[index] = 15;
                });
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                 padding: const EdgeInsets.all(33),
                  margin: EdgeInsets.all(2),
                  color: tiles[index] != 15 ? Color(0xFF8F8BBF) : Colors.white, // Set tile color
                  child: Center(
                    child: Container(
                      //height: 126,
                      child: Text(
                        tiles[index] != 15 ? tiles[index].toString() : '', // Display tile number
                        style: const TextStyle(
                          //height: 4,
                          fontSize: 24,
                          color: Colors.white,
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8F8BBF),
              ),
              onPressed: () => print("Reset"),
                child: const Text("Reset", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),  
        ),
          );
         }
        }






import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../widgets/logo_app_bar.dart';


class SolveRiddle extends StatefulWidget {
  @override
  _SlidePuzzleBoardState createState() => _SlidePuzzleBoardState();
}

class _SlidePuzzleBoardState extends State<SolveRiddle> {
  final List<int> tiles = List.generate(9, (index) => index); // Create a list of tile numbers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF423E72),
      appBar: LogoAppBar(
      ),
      body: GridView.builder(
        itemCount: tiles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (tiles[index] == 8) {
                // if Empty tile was clicked, do nothing
                return;
              }
              if (index % 3 != 2 && tiles[index + 1] == 8) {
                // Clicked tile can slide right
                setState(() {
                  tiles[index + 1] = tiles[index];
                  tiles[index] = 8;
                });
              } else if (index % 3 != 0 && tiles[index - 1] == 8) {
                // Clicked tile can slide left
                setState(() {
                  tiles[index - 1] = tiles[index];
                  tiles[index] = 8;
                });
              } else if (index < 6 && tiles[index + 3] == 8) {
                // Clicked tile can slide down
                setState(() {
                  tiles[index + 3] = tiles[index];
                  tiles[index] = 8;
                });
              } else if (index >= 3 && tiles[index - 3] == 8) {
                // Clicked tile can slide up
                setState(() {
                  tiles[index - 3] = tiles[index];
                  tiles[index] = 8;
                });
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                 padding: const EdgeInsets.all(49),
                  margin: EdgeInsets.all(2),
                  color: tiles[index] != 8 ? Color(0xFF8F8BBF) : Colors.white, // Set tile color
                  child: Center(
                    child: Container(
                      //height: 126,
                      child: Text(
                        tiles[index] != 8 ? tiles[index].toString() : '', // Display tile number
                        style: const TextStyle(
                          //height: 4,
                          fontSize: 24,
                          color: Colors.white,
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8F8BBF),
              ),
              onPressed: () => print("Reset"),
                child: const Text("Reset", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),  
             ),
            );
           }
         }
