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
  List<int> tiles =
      List.generate(9, (index) => index); // Create a list of tile numbers

  @override
  void initState() {
    super.initState();
    shuffleBoard();
  }

  void shuffleBoard() {
    //make sure that
    while (!isSolvable() && !alarmOff()) {
      tiles.shuffle();
    }
    debugPrint(tiles.toString());
  }

  //board is solvable only if there are an even amount of 'switches' that need to be done
  bool isSolvable() {
    int switches = 0;
    var filledTiles = tiles.where((tileValue) => tileValue != 8);
    for (int i = 0; i < filledTiles.length - 1; i++) {
      if (filledTiles.elementAt(i) > filledTiles.elementAt(i + 1)) switches++;
    }
    return switches % 2 == 0;
  }


  bool alarmOff() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != i) {
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
                          if (alarmOff()) {
                            // If the board is in the right order, show a dialog indicating the win
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Alarm Off'),
                                content: const Text('Puzzle solved'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                      } else if (index % 3 != 0 && tiles[index - 1] == 8) {
                        // Clicked tile can slide left
                        setState(() {
                          checkSlide(index, context);
                        });
                      } else if (index < 6 && tiles[index + 3] == 8) {
                        // Clicked tile can slide down
                        setState(() {
                          tiles[index + 3] = tiles[index];
                          tiles[index] = 8;
                          if (alarmOff()) {
                            // If the board is in the right order, show a dialog indicating the win
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Alarm Off'),
                                content: const Text('Puzzle solved'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                      } else if (index >= 3 && tiles[index - 3] == 8) {
                        // Clicked tile can slide up
                        setState(() {
                          tiles[index - 3] = tiles[index];
                          tiles[index] = 8;
                          if (alarmOff()) {
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
                      color: tiles[index] != 8
                          ? const Color(0xFF8F8BBF)
                          : Colors.white, // Set tile color
                      child: Center(
                        child: Text(
                          tiles[index] != 8
                              ? tiles[index].toString()
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
                shuffleBoard();
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

  void checkSlide(int index, BuildContext context) {
    tiles[index - 1] = tiles[index];
    tiles[index] = 8;
    if (alarmOff()) {
      challengeSolved(context);
    }
  }
}
