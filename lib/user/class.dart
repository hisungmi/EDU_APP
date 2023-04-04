import 'package:auto_size_text/auto_size_text.dart';
import 'package:edu_application_pre/user/attendance_status.dart';
import 'package:flutter/material.dart';

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
  final String color;

  MyData(
    this.lectureName,
    this.person,
    this.place,
    this.time,
    this.color,
  );
  //mydata변수에 각 샘플데이터 정의
  //List<Map<String,String>>형식으로 받아와서 List<MyData>로 변환->fromMap() 생성자를 구현하여 Map 데이터를 MyData 객체로 변환
  MyData.fromMap(Map<String, dynamic> map)
      : lectureName = map['lectureName'],
        place = map['place'],
        time = map['time'],
        color = map['color'],
        person = map['person'];
}

class _ClassState extends State<Class> {
  bool isAfternoon = true;

  final List<Map<String, dynamic>> morningdatalist = [
    {
      'lectureName': '대회버전1',
      'person': 'chun',
      'place': 'MAT',
      'time': '수요일',
      'color': 'e55c65'
    },
    {
      'lectureName': '수능논술2',
      'person': 'Kan',
      'place': 'MIT',
      'time': '목요일',
      'color': 'cc6699'
    },
    {
      'lectureName': '나답게사는법',
      'person': 'Aan',
      'place': 'SDF',
      'time': '월요일',
      'color': 'a4a6d2'
    },
    {
      'lectureName': '화학과발명',
      'person': 'dani',
      'place': 'SKS',
      'time': '금요일',
      'color': '678cbf'
    },
    {
      'lectureName': '조선의발자취',
      'person': 'Anny',
      'place': 'KOR',
      'time': '토요일',
      'color': '80bdca'
    },
    {
      'lectureName': '수능영어1',
      'person': 'jain',
      'place': 'TIT',
      'time': '금요일',
      'color': 'eeb958'
    },
    {
      'lectureName': '수능국어2',
      'person': 'sin',
      'place': 'IDS',
      'time': '월요일',
      'color': 'd57a7b'
    },
    {
      'lectureName': '기하와벡터',
      'person': 'rosa',
      'place': 'NIT',
      'time': '일요일',
      'color': 'e39177'
    },
  ];
  final List<Map<String, dynamic>> eveningdatalist = [
    {
      'lectureName': '수능수학',
      'person': 'rosa',
      'place': 'NIT',
      'time': '화요일',
      'color': 'e39177'
    },
    {
      'lectureName': '수능국어2',
      'person': 'sin',
      'place': 'IDS',
      'time': '목요일',
      'color': 'd57a7b'
    },
    {
      'lectureName': '수능영어1',
      'person': 'jain',
      'place': 'TIT',
      'time': '금요일',
      'color': 'eeb958'
    },
    {
      'lectureName': '고려의발전',
      'person': 'Anny',
      'place': 'KOR',
      'time': '토요일',
      'color': '80bdca'
    },
    {
      'lectureName': '물리적탐구',
      'person': 'dani',
      'place': 'SKS',
      'time': '일요일',
      'color': '678cbf'
    },
    {
      'lectureName': '무슨수업',
      'person': 'Aan',
      'place': 'SDF',
      'time': '월요일',
      'color': 'a4a6d2'
    },
    {
      'lectureName': '똑똑해지는법',
      'person': 'Kan',
      'place': 'MIT',
      'time': '수요일',
      'color': 'cc6699'
    },
    {
      'lectureName': '대회버전2',
      'person': 'chun',
      'place': 'MAT',
      'time': '수요일',
      'color': 'e55c65'
    },
  ];

  //강의 데이터 변수
  @override
  Widget build(BuildContext context) {
    //list를 MyData클래스의 list로 변환, fromMap으로 Map을 MyData객체로 변환, toList로 map()에서 반환된 Iterable을 리스트로 변환
    List<MyData> myeveninglist =
        eveningdatalist.map((data) => MyData.fromMap(data)).toList();
    List<MyData> mymorninglist =
        morningdatalist.map((data) => MyData.fromMap(data)).toList();

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
          padding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 30.0),
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
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: mymorninglist.length,
                        itemBuilder: (context, index) {
                          MyData data = myeveninglist[index];
                          //컬러타입변환 inp.parse(), 16진수로 표현된 색상코드를 읽어와 알파값을 255로 설정한 color객체 생성
                          // 16진수를 10진수 정수형으로 변환과정  '0xff000000' 은 color에 알파값은 필수, 알파값 = 투명도, 알파값을 255로 설정한 것
                          Color color = Color(
                              int.parse(data.color, radix: 16) + 0xFF000000);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isAfternoon = true;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AttendanceStatus(
                                      isAfternoon: isAfternoon,
                                      morning: mymorninglist[index],
                                      evening: myeveninglist[index])));
                            },
                            child: Container(
                              width: 358,
                              height: 71,
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 110,
                                    child: Text(
                                      data.time,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 115,
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      data.lectureName,
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
                                                text: data.place,
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
                                                text: data.person,
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
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: mymorninglist.length,
                        itemBuilder: (context, index) {
                          MyData data = mymorninglist[index];
                          //컬러타입변환 inp.parse()
                          Color color = Color(
                              int.parse(data.color, radix: 16) + 0xFF000000);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isAfternoon = false;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AttendanceStatus(
                                        morning: mymorninglist[index],
                                        evening: myeveninglist[index],
                                        isAfternoon: isAfternoon,
                                      )));
                            },
                            child: Container(
                              width: 358,
                              height: 71,
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 110,
                                    child: Text(
                                      data.time,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 115,
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      data.lectureName,
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
                                                text: data.place,
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
                                                text: data.person,
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
                      ),
                    ),
            ],
          ),
        ));
  }
}
