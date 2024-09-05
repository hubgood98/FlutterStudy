import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
        Padding(padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
          Text('홈 화면',style: TextStyle(fontSize: 15)),
          Text('두번째 텍스트'),
          ],
        )
       ),
      );
  }

}