import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home screen'),
    );
  }
  
}

class _DDay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Text('DDay widget');
  }
}

class _CoupleImage extends StatelㅇessWidget{
  @override
  Widget build(BuildContext context) {
    return Text('커플 이미지 위젯');
  }

}