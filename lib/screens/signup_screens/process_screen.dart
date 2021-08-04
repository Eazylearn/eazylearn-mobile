import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ProcessScreen extends StatefulWidget {
  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  bool init = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      await Future.delayed(Duration(seconds: 2));
      setState(() => init = false);
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: init
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: signupColor,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "In process...",
                  style: TextStyle(color: signupColor, fontSize: 20),
                )
              ],
            )
          : Text(
              "EAZYLEARN",
              style: TextStyle(
                  color: signupColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
    )));
  }
}