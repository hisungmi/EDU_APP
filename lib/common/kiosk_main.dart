import 'dart:convert';
import 'package:edu_application_pre/http_setup.dart';
import 'package:edu_application_pre/types.dart';
import 'package:flutter/material.dart';

class KioskMain extends StatefulWidget {
  KioskMain({Key? key}) : super(key: key);

  @override
  State<KioskMain> createState() => KioskMainState();
}

class KioskMainState extends State<KioskMain> {
  static List<dynamic> lectureList = [];

  void getLectureList() async {
    Map<String, dynamic> data = {
      'userKey': '',
      'roomKey': '',
      'roomName': '',
      'lectureName': '',
      'target': '',
    };

    var res = await post('/lectures/getLectureList/', jsonEncode(data));
    if (res.statusCode == 200) {
      for (Map<String, dynamic> lecture in res.data['resultData']) {
        if (lecture['progress'] == '등록') {
          lectureList.add(lecture);
        }
      }
      // lectureList = res.data['resultData'];
    }
  }

  @override
  void initState() {
    super.initState();
    getLectureList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('../assets/img/background01.jpg'))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    height: 580.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: lectureList.length,
                      itemBuilder: (context, index) {
                        String room = lectureList[index]['roomName'];
                        String name = lectureList[index]['lectureName'];
                        String startTime = lectureList[index]['startTime']
                            .toString()
                            .replaceAll('-', ':');
                        if (startTime.length < 3) {
                          startTime = '$startTime:00';
                        }
                        String teacher = lectureList[index]['teacherName'];

                        return Stack(children: [
                          Container(
                              width: 330,
                              height: 580,
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    room,
                                  ),
                                  Text(
                                    name,
                                  ),
                                  Text(
                                    startTime,
                                  ),
                                  Text(
                                    '$teacher 강사님',
                                  ),
                                  Text(
                                    '출석 표시',
                                  ),
                                ],
                              )),
                        ]);
                        // child: Text(
                        //   name,
                        // ));
                      },
                    ))
              ],
            )));
  }
}
