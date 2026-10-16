import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  late final VideoPlayerController _videoPlayerController;

  bool isOpen = false;
  bool isEnding = false;
  @override
  void initState() {
    _controller.play();
    _videoPlayerController = VideoPlayerController.asset('lib/vv.mp4');
    _videoPlayerController.initialize().whenComplete(() {
      setState(() {
        isOpen = false;
        isEnding = true;
      });
    });
    super.initState();
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
        body: Container(
          color: const Color.fromARGB(255, 254, 59, 137),
          child: Stack(
            children: [
              Padding(
                padding: isEnding
                    ? const EdgeInsets.only(bottom: 100)
                    : EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isOpen = true;
                      _videoPlayerController.play().whenComplete(() {
                        setState(() {
                          isEnding = true;
                        });
                      });
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/aa.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          isEnding
                              ? Container(
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
                                )
                              : SizedBox.shrink(),

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
              ),
              isEnding
                  ? Align(
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
                                'Soon',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 34,

                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              isEnding
                  ? Align(
                      alignment: Alignment(0, -1.3),
                      child: ConfettiWidget(
                        confettiController: _controller,
                        blastDirectionality: BlastDirectionality.explosive,
                        emissionFrequency: 0.01,
                        gravity: 0.1,
                        minimumSize: Size(10, 5),
                        maximumSize: Size(20, 30),
                        shouldLoop: true,
                        colors: const [
                          Color.fromARGB(255, 224, 3, 3),
                          Colors.white,
                        ],
                      ),
                    )
                  : SizedBox.shrink(),

              isOpen
                  ? SizedBox.expand(
                      child: _videoPlayerController.value.isInitialized
                          ? FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _videoPlayerController.value.size.width,
                                height:
                                    _videoPlayerController.value.size.height,
                                child: VideoPlayer(_videoPlayerController),
                              ),
                            )
                          : Center(child: CircularProgressIndicator()),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
