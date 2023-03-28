import 'package:auto_size_text/auto_size_text.dart';
import 'package:edu_application_pre/user/attendance_status.dart';
import 'package:flutter/material.dart';
import 'newList.dart';
import 'lecture.dart';

class Class extends StatefulWidget {
  const Class({Key? key}) : super(key: key);
  @override
  State<Class> createState() => _ClassState();
}

class MyData {
  final String lectureName;
  final String person;
  final String place;
  final String time;
  MyData(this.lectureName, this.person, this.place, this.time);
  //List<Map<String,String>>형식으로 받아와서 List<MyData>로 변환->fromMap() 생성자를 구현하여 Map 데이터를 MyData 객체로 변환
  MyData.fromMap(Map<String, dynamic> map)
      : lectureName = map['lectureName'],
        place = map['place'],
        time = map['time'],
        person = map['person'];
}

class _ClassState extends State<Class> {
  bool isAfternoon = true;

  static List<String> lectureTime = [
    '17시 월,수,금',
    '18시 월',
    '17시 월,수',
    '18시 월,수',
    '17시 월,수,목',
  ];
  static List<String> lectureNam = [
    '기하와 백터',
    '말하기 듣기 쓰기 읽기 외우기',
    '과학',
    '영어',
    '한국사',
  ];
  static List<String> location = [
    'MIT',
    'RIO',
    'MIT',
    'DJO',
    'SKS',
  ];
  static List<String> name = [
    'rosa',
    'sin',
    'chun',
    'asdf',
    'rosa',
  ];

  final List<Map<String, String>> mydatalist = [
    {'lectureName': '수학', 'person': 'rosa', 'place': 'NIT', 'time': '17시 화,수'},
    {'lectureName': '국어', 'person': 'sin', 'place': 'RNR', 'time': '17시 화,목'},
    {'lectureName': '영어', 'person': 'chnn', 'place': 'SII', 'time': '18시 월,수'},
    {
      'lectureName': '한국사',
      'person': 'rosa',
      'place': 'NIT',
      'time': '18시 월,화,수'
    },
  ];

//강의 객체들의 리스트이므로 클래스 이름인 LectureInformation 로
  final List<LectureInformation> lectureData = List.generate(
      name.length,
      (index) => LectureInformation(
          lectureTime[index], lectureNam[index], location[index], name[index]));
  //강의 데이터 변수
  @override
  Widget build(BuildContext context) {
    List<MyData> mylist =
        mydatalist.map((data) => MyData.fromMap(data)).toList();
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Image.asset(
              "assets/img/whitelogo.png",
              height: 80,
            ),
          ),
          automaticallyImplyLeading: false, //기본 왼ㅉ고 토굴 안생기게
          backgroundColor: Color(0xff0099FF),
          toolbarHeight: 80,
          elevation: 0.0, //앱바 입체감 없애기
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              iconSize: 30,
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    isAfternoon
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                isAfternoon = false;
                              });
                            },
                            child: Container(
                              width: 65.57,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color: Color(0xff9c9c9c),
                                  )),
                              child: Center(
                                  child: Text(
                                "오전",
                                textAlign: TextAlign.center,
                              )),
                            ),
                          )
                        : Container(
                            width: 65.57,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xff0099ee),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(12),
                                ),
                                border: Border.all(
                                  color: Color(0xff0099ee),
                                )),
                            child: Center(
                              child: Text(
                                "오전",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                    isAfternoon
                        ? Container(
                            width: 65.57,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xff0099ee),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(12),
                                ),
                                border: Border.all(
                                  color: Color(0xff0099ee),
                                )),
                            child: Center(
                              child: Text(
                                "오후",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                isAfternoon = true;
                              });
                            },
                            child: Container(
                              width: 65.57,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color: Color(0xff9c9c9c),
                                  )),
                              child: Center(
                                  child: Text(
                                "오후",
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                //index 값으로 리스트 표현할때
                isAfternoon
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: name.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AttendanceStatus(
                                        lecture: lectureData[index],
                                      )));
                              print(lectureData[index].name);
                            },
                            child: Container(
                              width: 358,
                              height: 71,
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                              decoration: BoxDecoration(
                                  color: Color(0xffE39177),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 110,
                                    child: Text(
                                      lectureData[index].lectureTime,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 115,
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      lectureData[index].lectureNam,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      minFontSize: 14,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    width: 73,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '강의실|',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    lectureData[index].location,
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '강사명|',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              TextSpan(
                                                text: lectureData[index].name,
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: mylist.length,
                        itemBuilder: (context, index) {
                          MyData data = mylist[index];
                          return ListTile(
                            title: Text(data.person),
                            subtitle: Column(
                              children: [
                                for (final entry in mydatalist[index].entries)
                                  Text(entry.value),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
