import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_setup.dart';

class ClassMain extends StatefulWidget {
  const ClassMain({Key? key}) : super(key: key);

  @override
  State<ClassMain> createState() => ClassMainState();
}

class ClassMainState extends State<ClassMain> {
  static String roomKey = '';
  static List<dynamic> lectureList = [];
  static List<dynamic> todayLectures = [];
  static Map<String, dynamic> lectureDetail = {};

  Future setRoomData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roomData = prefs.getString('roomData');

    roomKey = jsonDecode(roomData!)['roomKey'];
  }

  Future<void> getLectureList() async {
    Map<String, dynamic> data = {
      'userKey': '',
      'roomKey': roomKey,
      'roomName': '',
      'lectureName': '',
      'target': '',
    };

    var result = await post('/lectures/getLectureList/', jsonEncode(data));
    if (result.statusCode == 200) {
      List<Map<String, dynamic>> filteredLectures =
          List<Map<String, dynamic>>.from(result.data['resultData'])
              .where((lecture) => lecture['progress'] == '등록')
              .toList();
      setState(() {
        lectureList = filteredLectures;
      });
    }

    DateTime now = DateTime.now();
    int todayWeekday = now.weekday;

    todayLectures = lectureList.where((lecture) {
      int lectureWeekday = lecture['day'];

      if (lectureWeekday != todayWeekday) {
        return false;
      }

      int lectureStartHour = int.parse(lecture['startTime'].substring(0, 2));
      int lectureStartMinute = int.parse(lecture['startTime'].substring(3, 5));
      int lectureDuration = lecture['duration'];

      DateTime lectureStartTime = DateTime(
          now.year, now.month, now.day, lectureStartHour, lectureStartMinute);
      DateTime lectureEndTime =
          lectureStartTime.add(Duration(minutes: lectureDuration));

      return now.isAfter(lectureStartTime) && now.isBefore(lectureEndTime);
    }).toList();

    lectureDetail = todayLectures[0];

    print('현재 시간대에 진행 중인 강의 여부: ${lectureDetail.isNotEmpty}');
    print(todayLectures[0]['lectureName']);
  }

  @override
  void initState() {
    setRoomData();
    getLectureList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        lectureDetail.isNotEmpty
            ? Text(lectureDetail['lectureName'])
            : Text("현재 진행 중인 강의가 없습니다."),
      ],
    ));
  }
}
