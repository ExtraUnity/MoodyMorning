import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/widgets/solveEquation/alarm_display.dart';

class SolveRiddle extends StatefulWidget {
  const SolveRiddle({super.key});

  @override
  SlidePuzzleBoardState createState() => SlidePuzzleBoardState();
}

class SlidePuzzleBoardState extends State<SolveRiddle> {
  final List<int> _tiles =
      List.generate(9, (index) => index); // Create a list of tile numbers

  @override
  void initState() {
    super.initState();
    _shuffleBoard();
  }

  void _shuffleBoard() {
    //make sure that
    while (!_isSolvable() || _alarmOff()) {
      _tiles.shuffle();
    }
    debugPrint(_tiles.toString());
  }

  //board is solvable only if there are an even amount of inversions
  bool _isSolvable() {
    int switches = 0;
    var filledTiles = _tiles.where((tileValue) => tileValue != 8);
    for (int i = 0; i < filledTiles.length - 1; i++) {
      for (int j = i + 1; j < filledTiles.length; j++) {
        if (filledTiles.elementAt(i) > filledTiles.elementAt(j)) switches++;
      }
    }
    return switches % 2 == 0;
  }

  bool _alarmOff() {
    for (int i = 0; i < _tiles.length; i++) {
      if (_tiles[i] != i) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF423E72),
        appBar: LogoAppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const AlarmDisplay(),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: _tiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (_tiles[index] == 8) {
                        // if Empty tile was clicked, do nothing
                        return;
                      }
                      if (index % 3 != 2 && _tiles[index + 1] == 8) {
                        // Clicked tile can slide right
                        setState(() {
                          _tiles[index + 1] = _tiles[index];
                          _tiles[index] = 8;
                          if (_alarmOff()) {
                            // If the board is in the right order, show a dialog indicating the win
                            challengeSolved(context);
                          }
                        });
                      } else if (index % 3 != 0 && _tiles[index - 1] == 8) {
                        // Clicked tile can slide left
                        setState(() {
                          _checkSlide(index, context);
                        });
                      } else if (index < 6 && _tiles[index + 3] == 8) {
                        // Clicked tile can slide down
                        setState(() {
                          _tiles[index + 3] = _tiles[index];
                          _tiles[index] = 8;
                          if (_alarmOff()) {
                            // If the board is in the right order, show a dialog indicating the win
                            challengeSolved(context);
                          }
                        });
                      } else if (index >= 3 && _tiles[index - 3] == 8) {
                        // Clicked tile can slide up
                        setState(() {
                          _tiles[index - 3] = _tiles[index];
                          _tiles[index] = 8;
                          if (_alarmOff()) {
                            // If the board is in the right order, show a dialog indicating the win
                            challengeSolved(context);
                          }
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(49),
                      margin: const EdgeInsets.all(2),
                      color: _tiles[index] != 8
                          ? const Color(0xFF8F8BBF)
                          : Colors.white, // Set tile color
                      child: Center(
                        child: Text(
                          _tiles[index] != 8
                              ? _tiles[index].toString()
                              : '', // Display tile number
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8F8BBF),
            ),
            onPressed: () {
              // Perform reset action
              setState(() {
                _shuffleBoard();
              });
            },
            child: const Text(
              'Randomize',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void _checkSlide(int index, BuildContext context) {
    _tiles[index - 1] = _tiles[index];
    _tiles[index] = 8;
    if (_alarmOff()) {
      challengeSolved(context);
    }
  }
}
