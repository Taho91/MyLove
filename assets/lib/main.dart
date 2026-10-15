import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyLove());
}

class MyLove extends StatefulWidget {
  const MyLove({super.key});

  @override
  State<MyLove> createState() => _MyLoveState();
}

class _MyLoveState extends State<MyLove> {
  final _controller = ConfettiController(duration: const Duration(seconds: 10));
  AudioPlayer _audioPlayer = AudioPlayer();
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 254, 59, 137),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/doha.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 254, 59, 137),
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // CountdownTimer(
                        //   controller: controller,
                        //   onEnd: onEnd,
                        //   endTime: endTime,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      _audioPlayer.play(AssetSource('m.mp3'));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'زفاف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'pp',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'احمد ♡ ضحى',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'pp',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '2026/10/24',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: 'pp',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -1.3),
                child: ConfettiWidget(
                  confettiController: _controller,
                  blastDirectionality: BlastDirectionality.explosive,
                  emissionFrequency: 0.01,
                  gravity: 0.1,
                  minimumSize: Size(10, 5),
                  maximumSize: Size(20, 30),
                  shouldLoop: true,
                  colors: const [Colors.white, Colors.black],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
