import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            height: mq.height * .45,
            width: mq.width * .8,
            top: mq.height * .28,
            left: mq.width * .11,
            child: Image.asset('images/chat.png'),
          ),
          Positioned(
            top: mq.height * .71,
            left: mq.width * .4,
            child: Text('Hello',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.amber,
                  letterSpacing: 3,
                  fontSize: 35,
                )),
          ),
         
             
        ],
      ),
    );
  }
}