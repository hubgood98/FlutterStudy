import 'package:flutter/material.dart';

void main() {
  runApp(SplashScreen());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.green,
          child:
          Center(
            child: TextButton(
              onPressed: (){},
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ), child: const Text('텍스트 버튼'),
            ),
          ),
        )
      ),
    );
  }
}

class RowWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: double.infinity,
          child: Row(
            //주축 정렬 지정
            mainAxisAlignment: MainAxisAlignment.start,
            //반대축 정렬 지정
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Container(
                height: 50,
                width: 50,
                color: Colors.lime,
            ),

              //sizebox는 일반적으로 공백생성할 때 사용
              const SizedBox(width:12.0),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.blueAccent,
              ),

              const SizedBox(width: 12.0),
              Container(
                height: 80,
                width: 80,
                color: Colors.amber,
              )
            ],
          ),
        ),
      )
    );
  }

}

class ColumnWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: double.infinity,
            child: Column(
              //주축 정렬 지정
              mainAxisAlignment: MainAxisAlignment.start,
              //반대축 정렬 지정
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  height: 50,
                  width: 50,
                  color: Colors.lime,
                ),

                //sizebox는 일반적으로 공백생성할 때 사용
                const SizedBox(width:12.0),
                Container(
                  height: 50.0,
                  width: 50.0,
                  color: Colors.blueAccent,
                ),

                const SizedBox(width: 12.0),
                Container(
                  height: 80,
                  width: 80,
                  color: Colors.amber,
                )
              ],
            ),
          ),
        )
    );
  }
}

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.green,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/apple.jpg',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                  ),
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red,),),
                ],
              )

            ],
            ),
          ),
        ),
      );
  }
}
