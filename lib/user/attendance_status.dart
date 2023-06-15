import 'dart:convert';

import 'package:edu_application_pre/user/class.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_setup.dart';

class AttendanceStatus extends StatefulWidget {
  AttendanceStatus({
    Key? key,
    required this.morning,
    required this.afternoon,
    required this.isAfternoon,
  }) : super(key: key);

  //MyData = 컬리브레이스를 가지고 있음 ->Key? , required가 붙어서 반드시 구현해야하는 알규먼트
  final Map<String, dynamic> morning;
  final Map<String, dynamic> afternoon;
  final bool isAfternoon;
  static const routeName = "/attendance";

  @override
  State<AttendanceStatus> createState() => _AttendanceStatusState();
}

class StateData {
  final String date;
  final String status;
  StateData(
    this.date,
    this.status,
  );

  StateData.fromMap(Map<String, dynamic> map)
      : date = map['date'],
        status = map['status'];
}

class _AttendanceStatusState extends State<AttendanceStatus> {
  static List<dynamic> statusList = [];

  String studentKey = '';
  String name = '';
  Future<void> loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      Map<String, dynamic> dataMap = jsonDecode(userData);
      setState(() {
        studentKey = dataMap['studentKey'] ?? '';
        name = dataMap['name'] ?? '';
      });
    }
    // await getLectureList(studentKey);
  }

  Future<void> getAttendList() async {
    Map<String, dynamic> data = {
      'userKey': '',
      'lectureKey': widget.isAfternoon
          ? widget.afternoon['lectureKey']
          : widget.morning['lectureKey'],
    };
    statusList = [];
    var res = await post('/info/getAttendList/', jsonEncode(data));
    // mounted 속성을 확인하여 현재 위젯이 여전히 트리에 존재하는지 확인
    if (res.statusCode == 200) {
      setState(() {
        for (Map<String, dynamic> state in res.data['resultData']) {
          if (name == state['studentName']) {
            statusList.add(state);
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {
      getAttendList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color morningtitlecolor =
        Color(int.parse('0xFF${widget.morning['color'].substring(1)}'));
    Color afternoontitlecolor =
        Color(int.parse('0xFF${widget.afternoon['color'].substring(1)}'));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        elevation: 4.0, //앱바 입체감 없애기
        title: Center(
          child: Text(
            '출결현황',
            style: TextStyle(
                color: Color(0xff0099ff), fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        leading: Container(
          child: IconButton(
            icon: FaIcon(FontAwesomeIcons.angleLeft),
            color: Color(0xff0099ff),
            onPressed: () {
              //현재 페이지를 스택에서 제거하고 이전 페이지로 돌아감
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          //title 센터 주려고 넣음
          Container(
            width: 60,
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                height: 35,
                decoration: BoxDecoration(
                    color: morningtitlecolor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  widget.isAfternoon == true
                      ? widget.afternoon['lectureName']
                      : widget.morning['lectureName'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 78,
                    height: 29,
                    decoration: BoxDecoration(
                      color: Color(0xffEAEAEA),
                    ),
                    child: Center(
                        child: Text("날짜",
                            style: TextStyle(
                                color: Color(0xff848484), fontSize: 14))),
                  ),
                  Container(
                    width: 280,
                    height: 29,
                    decoration: BoxDecoration(
                      color: Color(0xffEAEAEA),
                    ),
                    child: Center(
                        child: Text("출석",
                            style: TextStyle(
                                color: Color(0xff848484), fontSize: 14))),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Expanded(
                //스크롤되게
                child: ListView.builder(
                  shrinkWrap: true, //스크롤되게
                  itemCount: statusList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> getStatusList = statusList[index];
                    String formattedDate = DateFormat('MM.dd')
                        .format(DateTime.parse(getStatusList['createDate']));

                    Color bgColor = Colors.white;
                    Color textColor = Color(0xff565656);
                    Color bg2Color = Colors.white;
                    Color text2Color = Color(0xff565656);
                    Color bg3Color = Colors.white;
                    Color text3Color = Color(0xff565656);
                    Color bg4Color = Colors.white;
                    Color text4Color = Color(0xff565656);
                    if (getStatusList['state'] == '출석') {
                      textColor = Colors.white;
                      bgColor = Color(0xffA4CAF8);
                    }
                    if (getStatusList['state'] == '결석') {
                      text2Color = Colors.white;
                      bg2Color = Color(0xffFD9494);
                    }
                    if (getStatusList['state'] == '지각') {
                      text3Color = Colors.white;
                      bg3Color = Color(0xFFF4C784);
                    }
                    if (getStatusList['state'] == '보류') {
                      text4Color = Colors.white;
                      bg4Color = Color(0xffBBBBBB);
                    }
                    return Container(
                      width: 360,
                      height: 37,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 78,
                            height: 37,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  left: BorderSide(
                                      width: 2, color: Color(0xffeaeaea)),
                                  right: BorderSide(
                                      width: 1, color: Color(0xffeaeaea)),
                                  top: BorderSide(
                                      width: 1, color: Color(0xffeaeaea)),
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffeaeaea)),
                                )),
                            child: Center(
                                child: Text(formattedDate,
                                    style: TextStyle(
                                      color: Color(0xff9c9c9c),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ),
                          Container(
                            width: 70,
                            height: 37,
                            decoration: BoxDecoration(
                                color: bgColor,
                                border: Border.all(
                                    color: Color(0xffeaeaea), width: 1)),
                            child: Center(
                                child: Text("출석",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ),
                          Container(
                            width: 70,
                            height: 37,
                            decoration: BoxDecoration(
                                color: bg2Color,
                                border: Border.all(
                                    color: Color(0xffeaeaea), width: 1)),
                            child: Center(
                                child: Text("결석",
                                    style: TextStyle(
                                      color: text2Color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ),
                          Container(
                            width: 70,
                            height: 37,
                            decoration: BoxDecoration(
                                color: bg3Color,
                                border: Border.all(
                                    color: Color(0xffeaeaea), width: 1)),
                            child: Center(
                                child: Text("지각",
                                    style: TextStyle(
                                      color: text3Color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ),
                          Container(
                              width: 70,
                              height: 37,
                              decoration: BoxDecoration(
                                  color: bg4Color,
                                  border: Border(
                                    left: BorderSide(
                                        width: 1, color: Color(0xffeaeaea)),
                                    right: BorderSide(
                                        width: 2, color: Color(0xffeaeaea)),
                                    top: BorderSide(
                                        width: 1, color: Color(0xffeaeaea)),
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffeaeaea)),
                                  )),
                              child: Center(
                                  child: Text("보류",
                                      style: TextStyle(
                                        color: text4Color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      )))),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
