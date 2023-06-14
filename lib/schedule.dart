import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_setup.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  bool isAfternoon = true;
  bool isStudent = true;

  void toggleAfternoon() {
    setState(() {
      isAfternoon = !isAfternoon;
    });
  }

  String name = '';
  String userType = '';
  void loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    String? typeData = prefs.getString('userType');

    if (userData != null && typeData != null) {
      Map<dynamic, dynamic> dataMap = jsonDecode(userData);
      Map<dynamic, dynamic> typeMap = jsonDecode(typeData);

      setState(() {
        name = dataMap['name'] ?? '';
        userType = typeMap['userType'] ?? '';

        if (userType != 'STU') {
          isStudent = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy.MM.dd.EEE', 'ko_KR').format(now);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 20.0),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 348,
              child: Text(formattedDate,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
          Center(
            child: Container(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: isStudent
                          ? Text('$name님의 시간표',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xff595959),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500))
                          : Text('$name자녀의 시간표',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xff595959),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500))),
                  Row(children: [
                    isAfternoon
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                toggleAfternoon();
                              });
                            },
                            child: Container(
                              width: 65.57,
                              height: 25,
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
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          )
                        : Container(
                            width: 65.57,
                            height: 25,
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                    isAfternoon
                        ? Container(
                            width: 65.57,
                            height: 25,
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                toggleAfternoon();
                              });
                            },
                            child: Container(
                              width: 65.57,
                              height: 25,
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
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                  ])
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              child: TimeTable(
                  isAfternoon: isAfternoon, toggleAfternoon: toggleAfternoon)),
        ],
      ),
    ));
  }
}

class TimeTable extends StatefulWidget {
  const TimeTable(
      {super.key, required this.isAfternoon, required this.toggleAfternoon});
  final bool isAfternoon;
  final VoidCallback toggleAfternoon;

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  double kFirstColumnHeight = 20;
  int getkColumnLength() {
    return widget.isAfternoon ? 24 : 16;
  }

  double kBoxSize = 60.0;
  double left = 22.6;
  double width = 46;
  List week = ['월', '화', '수', '목', '금', '토', '일'];
  static List<dynamic> morningDataList = [];
  static List<dynamic> afternoonDataList = [];
  Map<int, dynamic> lectureStart = {
    13: 20,
    14: 20 + 60,
    15: 20 + 60 * 2,
    16: 20 + 60 * 3,
    17: 20 + 60 * 4,
    18: 20 + 60 * 5,
    19: 20 + 60 * 6,
    20: 20 + 60 * 7,
    21: 20 + 60 * 8,
    22: 20 + 60 * 9,
    23: 20 + 60 * 10,
  };
  Map<int, dynamic> dayStart = {
    1: 21.0,
    2: 21.0 + 46.9,
    3: 21.0 + 46.9 * 2,
    4: 21.0 + 46.9 * 3,
    5: 21.0 + 46.9 * 4,
    6: 21.0 + 46.9 * 5,
    7: 21.0 + 46.9 * 6,
  };

  double? getDay(int dayNumber) {
    return dayStart[dayNumber];
  }

  int getTime(int item) {
    return lectureStart[item];
  }

  String name = '';
  String userType = '';
  String studentKey = '';
  void loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    String? typeData = prefs.getString('userType');

    if (userData != null && typeData != null) {
      Map<dynamic, dynamic> dataMap = jsonDecode(userData);
      Map<dynamic, dynamic> typeMap = jsonDecode(typeData);

      setState(() {
        name = dataMap['name'] ?? '';
        userType = typeMap['userType'] ?? '';
        studentKey = dataMap['studentKey'] ?? '';

        getLectureList(studentKey);
      });
    }
  }

  Future<void> getLectureList(String studentKey) async {
    Map<String, dynamic> data = {
      'userKey': studentKey,
      'roomKey': '',
      'roomName': '',
      'lectureName': '',
      'target': '',
    };
    afternoonDataList = [];
    morningDataList = [];
    var res = await post('/lectures/getLectureList/', jsonEncode(data));
    // if(mounted){
    setState(() {
      if (res.statusCode == 200) {
        for (Map<String, dynamic> lecture in res.data['resultData']) {
          int startTime = int.parse(lecture['startTime'].substring(0, 2));
          int day = lecture['day'];
          if (lecture['progress'] == "등록" && startTime >= 13) {
            int gettime = getTime(startTime);
            double? getday = getDay(day);
            lecture['startTime'] =
                gettime; //gettime 으로 startTime에 시작 높이를 지정해서 넣음
            lecture['day'] = getday;
            afternoonDataList.add(lecture);
          } else if (lecture['progress'] == "등록" && startTime < 13) {
            int gettime = getTime(startTime + 8);
            double? getday = getDay(day);
            lecture['startTime'] =
                gettime; //gettime 으로 startTime에 시작 높이를 지정해서 넣음
            lecture['day'] = getday;
            morningDataList.add(lecture);
          }
        }
      }
    });
  }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  //매개변수로 int~~ 로 값 전달
  List<Widget> builDayColumn(int index, int kColumnLength) {
    return [
      //높이가 부모와 동일한 회색 수직 선
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      //확장 가능한 공간을 만들수 있음, 부모위젯 내에서 사용시 자식위젯들 사이에서 사용가능한 모든 공간을 차지하도록 확장됨, flex로 확장 가능정도를 지정할 수 있음.
      Expanded(
        flex: 7, //해당 Expanded위젯은 부모위젯 내에서 7등분이 공간을 차지함
        //Stack : column위젯과 겹치지 않는 container, position 위젯을 자식으로 가질수 있음
        //여러개의 자식 위젯을 세로로 배치
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Center(
                    child: Text(
                      week[index],
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                //List.generate() 함수는 첫 번째 인자로 전달한 수만큼 인덱스를 생성하고, 두 번째 인자로 전달한 함수를 이용하여 해당 인덱스의 값으로 구성된 리스트를 생성
                //스프레드 연산자 ... 는 리스트나 맵ㅇ르 펼쳐서 다른 리스트나 맵에 추가함,
                ...List.generate(
                  kColumnLength,
                  (index) {
                    //짝수인 경우선위젯, 홀수인 경우 container.
                    if (index % 2 == 0) {
                      return Divider(
                        color: Colors.grey,
                        height: 0,
                      );
                    }
                    //return : 함수내에서 값을 반환할떄, list.generate 함수는 리스트를 생성하여 반환하기에 return 키워드를 씀
                    return SizedBox(
                      height: kBoxSize,
                      child: Container(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> buildTimeColumn(int index, int kColumnLength) {
    return [
      Expanded(
        flex: 3,
        child: Column(
          children: [
            SizedBox(
              height: kFirstColumnHeight,
              width: kFirstColumnHeight,
            ),
            ...List.generate(
              kColumnLength,
              (index) {
                if (index % 2 == 0) {
                  return const Divider(
                    color: Colors.grey,
                    height: 0,
                  );
                }
                return SizedBox(
                  height: kBoxSize,
                  child: Center(
                      child: widget.isAfternoon
                          ? Text('${index ~/ 2 + 13}',
                              style: TextStyle(fontSize: 14))
                          : Text('${index ~/ 2 + 5}',
                              style: TextStyle(fontSize: 14))),
                );
              },
            ),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    int kColumnLength = getkColumnLength();

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
            width: 351,
            height: widget.isAfternoon
                ? kColumnLength / 2 * kBoxSize + kColumnLength
                : kColumnLength / 2 * kBoxSize + kColumnLength + 6,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              // borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    ...buildTimeColumn(0, kColumnLength),
                    //spread operator(...)를 사용
                    ...builDayColumn(0, kColumnLength),
                    ...builDayColumn(1, kColumnLength),
                    ...builDayColumn(2, kColumnLength),
                    ...builDayColumn(3, kColumnLength),
                    ...builDayColumn(4, kColumnLength),
                    ...builDayColumn(5, kColumnLength),
                    ...builDayColumn(6, kColumnLength),
                  ],
                ),
                if (widget.isAfternoon)
                  ...List.generate(afternoonDataList.length, (index) {
                    Color color = Colors.black;
                    String? colorValue = afternoonDataList[index]['color'];
                    if (colorValue != null && colorValue.isNotEmpty) {
                      color = Color(int.parse(
                          '0xFF${afternoonDataList[index]['color'].substring(1)}'));
                    }
                    return Positioned(
                        left: afternoonDataList[index]['day'],
                        top: afternoonDataList[index]['startTime']
                            .toDouble(), //int 타입을 double? 타입으로 변환하는거 ,소수점땜시
                        height: afternoonDataList[index]['duration'].toDouble(),
                        width: width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                          ),
                          child: Center(
                              child: Text(
                                  afternoonDataList[index]['lectureName'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10))),
                        ));
                  })
                else
                  ...List.generate(morningDataList.length, (index) {
                    Color color = Colors.black;
                    String? colorValue = morningDataList[index]['color'];
                    if (colorValue != null && colorValue.isNotEmpty) {
                      color = Color(int.parse(
                          '0xFF${morningDataList[index]['color'].substring(1)}'));
                    }
                    return Positioned(
                        left: morningDataList[index]['day'],
                        top: morningDataList[index]['startTime']
                            .toDouble(), //int 타입을 double? 타입으로 변환하는거 ,소수점땜시
                        height: morningDataList[index]['duration'].toDouble(),
                        width: width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                          ),
                          child: Center(
                              child: Text(morningDataList[index]['lectureName'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10))),
                        ));
                  }),
              ],
            )),
      ),
    );
  }
}
