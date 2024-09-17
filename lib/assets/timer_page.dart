import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class CircularTimer extends StatefulWidget {
  final int duration;
  final Widget returnRoute;
  const CircularTimer(
      {super.key, required this.duration, required this.returnRoute});

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer>
    with SingleTickerProviderStateMixin {
  late CountDownController _controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _controller = CountDownController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigator.pop(context); // Close the CircularTimer page

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.returnRoute,
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        _showExitConfirmationDialog();
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2D003D), Color(0xFF000000)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple[700]!.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5 + 10 * _animationController.value,
                        ),
                      ],
                    ),
                    child: CircularCountDownTimer(
                      duration: widget.duration,
                      initialDuration: 0,
                      controller: _controller,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.7,
                      ringColor: Colors.grey[800]!,
                      ringGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey[700]!, Colors.grey[900]!],
                      ),
                      fillColor: Colors.purple[300]!,
                      fillGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.purple[400]!, Colors.purple[700]!],
                      ),
                      backgroundColor: Colors.black12,
                      backgroundGradient: null,
                      strokeWidth: 20.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                        fontSize: 40.0,
                        color: Colors.purple[100],
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                      isReverse: true,
                      isReverseAnimation: true,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        debugPrint('Countdown Started');
                      },
                      onComplete: () {
                        debugPrint('Countdown Ended');
                        // Navigator.pop(context);
                      },
                      onChange: (String timeStamp) {
                        debugPrint('Countdown Changed $timeStamp');
                      },
                      timeFormatterFunction:
                          (defaultFormatterFunction, duration) {
                        if (duration.inSeconds == 0) {
                          return "Time's up!";
                        } else {
                          return formatTime(duration.inSeconds);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 95,
            ),
            SizedBox(
              width: 150, // Adjust width here
              height: 60, // Adjust height here
              child: FloatingActionButton(
                onPressed: _showExitConfirmationDialog,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Exit",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400]!,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
