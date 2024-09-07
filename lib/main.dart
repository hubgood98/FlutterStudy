import 'package:flutter/material.dart';

void main() {
  runApp(AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Confirmation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // "debug" 표시 제거
      home: AttendanceForm(),
    );
  }
}

class AttendanceForm extends StatefulWidget {
  @override
  _AttendanceFormState createState() => _AttendanceFormState();
}

class _AttendanceFormState extends State<AttendanceForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('매개변수 입력'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationScreen(),
                      ),
                    );
                  }
                },
                child: Text('확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  DateTime selectedAttendanceDate = DateTime.now();
  DateTime selectedConfirmationDate = DateTime.now();
  String selectedService = '수요'; // 초기값을 '수요'로 설정
  DateTime selectedServiceDate = DateTime.now();

  Future<void> _selectDateTime(BuildContext context, DateTime initialDate, ValueChanged<DateTime> onDateTimeSelected) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime != null) {
        final DateTime newDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onDateTimeSelected(newDateTime);
      }
    }
  }

  Future<void> _selectService(BuildContext context) async {
    // 예배 종류 선택
    final String? service = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('예배 선택'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, '주일'),
              child: Text('주일'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, '수요'),
              child: Text('수요'),
            ),
          ],
        );
      },
    );

    if (service != null) {
      // 날짜 선택
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedServiceDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        setState(() {
          selectedService = service;
          selectedServiceDate = pickedDate;
        });
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year.toString().padLeft(4, '0')}-'
        '${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.day.toString().padLeft(2, '0')}T'
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:00+09:00';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year.toString().padLeft(4, '0')}'
        '${dateTime.month.toString().padLeft(2, '0')}'
        '${dateTime.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 출결 조회'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '나의 예배 출결 조회',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0), // 전체 화면 패딩
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0), // 'v' 아이콘의 패딩 추가
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '예배 인증 완료',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0), // 컨테이너 내부 여백
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // 그림자 위치 조정
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    Row(
                      children: [
                        Text('예배 : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectService(context),
                            child: Text(
                              '$selectedService ${_formatDate(selectedServiceDate)}', // '-' 제거
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('출석 상태 : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.green[100], // 연한 초록색 배경
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            '출석완료',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('출석일시 : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDateTime(context, selectedAttendanceDate, (newDate) {
                              setState(() {
                                selectedAttendanceDate = newDate;
                              });
                            }),
                            child: Text(
                              _formatDateTime(selectedAttendanceDate),
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('확인일시 : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDateTime(context, selectedConfirmationDate, (newDate) {
                              setState(() {
                                selectedConfirmationDate = newDate;
                              });
                            }),
                            child: Text(
                              _formatDateTime(selectedConfirmationDate),
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // 파란색 배경
                  foregroundColor: Colors.white, // 흰색 글씨
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text('다시 확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
