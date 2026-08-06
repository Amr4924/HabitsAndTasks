import 'package:flutter/material.dart';
import 'package:to_do_list/Home.dart';

class LodingPage extends StatefulWidget {
  const LodingPage({super.key});

  @override
  State<LodingPage> createState() => _LodingPageState();
}

class _LodingPageState extends State<LodingPage> {
  @override
  void initState() {
    super.initState();
    _lodingScreen();
  }

  void _lodingScreen() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) {
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1),
                duration: Duration(seconds: 2),
                builder: (context, valueLoding, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value: valueLoding,
                      minHeight: 8,
                      color: Color(0xffF08080),
                    ),
                  );
                },
              ),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 1, end: 100),
                duration: Duration(seconds: 2),
                builder: (context, valueLoding, child) {
                  return Text(
                    "$valueLoding",
                    style: const TextStyle(
                      color: Color(0xffF08080),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
