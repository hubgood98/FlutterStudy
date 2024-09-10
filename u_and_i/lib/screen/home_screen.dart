import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(top: true, bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_DDay(),_CoupleImage(),],
        ),
      ),
    );
  }
  
}

class _DDay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Text('DDay widget');
  }
}

class _CoupleImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('asset/img/love.png',height: MediaQuery.of(context).size.height/2,
      ),
    );
  }

}