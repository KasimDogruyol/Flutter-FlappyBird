import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bird.dart';
import 'barriers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 0;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.5;
        }
      });
      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.5;
        }
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }
  

  void resetGame(){
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = birdYaxis;
    });
  }
  void _showDialog(){
    showDialog(
      context : context,
      barrierDismissible: false,
      builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.red,
        title: Center(
          child : Text(
            "G A M E  O V E R",
            style: TextStyle(
              color: Colors.white,

            ),
          )
        ),
        actions: [
          GestureDetector(
            onTap : resetGame,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child : Container(
                padding: EdgeInsets.all(7),
                color : Colors.white,
                child: Text(
                  "PLAY AGAIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            )
          )
        ],
      );
    }
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            jump();
          } else {
            startGame();
          }
        },
        child: Scaffold(
            body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: Text(
                        gameHasStarted ? '' : 'T A P  T O  P L A Y',
                      style: TextStyle(color: Colors.white,
                      fontSize: 20,),
                      )
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SCORE",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text("0",
                          style: TextStyle(color: Colors.white, fontSize: 35)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("BEST",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text("10",
                          style: TextStyle(color: Colors.white, fontSize: 35)),
                    ],
                  ),
                ],
              ),
            )),
          ],
        )));
  }
}
