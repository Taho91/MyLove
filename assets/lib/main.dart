import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:video_player/video_player.dart';

import 'dart:async';

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
  VideoPlayerController _videoPlayerController = VideoPlayerController.asset(
    'lib/xx.mp4',
  );

  bool isEnding = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _videoPlayerController.value.isInitialized
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 254, 59, 137),
                  image: DecorationImage(
                    image: AssetImage('lib/doha.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Center(child: SizedBox(height: 20)),
                      ),
                    ),

                    Align(
                      alignment: Alignment(0.5, -1.3),
                      child: ConfettiWidget(
                        confettiController: _controller,
                        blastDirectionality: BlastDirectionality.directional,
                        emissionFrequency: 0.02,
                        gravity: 0.1,
                        minimumSize: Size(10, 5),
                        maximumSize: Size(10, 20),
                        shouldLoop: true,
                        colors: const [Color.fromARGB(255, 177, 7, 7)],
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 254, 59, 137),
                            const Color.fromARGB(255, 254, 59, 137),
                            const Color.fromARGB(134, 254, 59, 137),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            _audioPlayer.play(AssetSource('m.mp3'));
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'زفـــــاف',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 38,
                                  fontFamily: 'pp',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'احمــد ♡ ضحــى',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 38,
                                  fontFamily: 'pp',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'حب من اول نظرة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontFamily: 'pp',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              CountdownPage(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {},
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _videoPlayerController.value.size.width,
                            height: _videoPlayerController.value.size.height,
                            child: VideoPlayer(_videoPlayerController),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _videoPlayerController.play();
                      },
                      child: Text("sadsa"),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator(color: Colors.red)),
      ),
    );
  }
}

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  // Set your specific target date and time here.
  final DateTime targetDate = DateTime(2026, 10, 24, 16, 0, 0);

  Timer? timer;
  Duration remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    updateCountdown();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => updateCountdown(),
    );
  }

  void updateCountdown() {
    final difference = targetDate.difference(DateTime.now());

    if (!mounted) return;

    setState(() {
      remaining = difference.isNegative ? Duration.zero : difference;
    });

    if (difference.inSeconds <= 0) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Text(
          '$days ايام',
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontSize: 38,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          '${hours.toString().padLeft(2, '0')} : '
          '${minutes.toString().padLeft(2, '0')} : '
          '${seconds.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 32, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "قاعة المولى / حي البكر",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(width: 10),
            Icon(Icons.location_on_outlined, color: Colors.white),
          ],
        ),
      ],
    );
  }
}
