import 'dart:convert';
import 'package:edu_application_pre/http_setup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Assignment extends StatefulWidget {
  const Assignment(
      {Key? key,
      required this.morning,
      required this.afternoon,
      required this.isAfternoon})
      : super(key: key);

  final Map<String, dynamic> morning;
  final Map<String, dynamic> afternoon;
  final bool isAfternoon;
  @override
  State<Assignment> createState() => _TaskState();
}

class _TaskState extends State<Assignment> {
  bool isSubmission = false;
  static List<dynamic> assignmentList = [];

  Future<void> getAssignList() async {
    Map<String, dynamic> data = {
      'lectureKey': widget.isAfternoon
          ? widget.afternoon['lectureKey']
          : widget.morning['lectureKey'],
    };

    assignmentList = [];
    var res = await post('/lectures/getAssignList/', jsonEncode(data));
    if (res.statusCode == 200) {
      setState(() {
        for (Map<String, dynamic> assignment in res.data['resultData']) {
          assignmentList.add(assignment);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR'); //한글 로케일 데이터를 초기화 ( 오전,오후로 사용하려고
    setState(() {
      getAssignList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> morningList = widget.morning;
    Map<String, dynamic> afterList = widget.afternoon;
    bool isAfternoon = widget.isAfternoon;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          elevation: 4.0, //앱바 입체감 없애기
          title: Center(
            child: Text(
              '과제',
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
          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 35,
                color: Color(0xffbbbbbb),
                child: Center(
                    child: Text(
                        isAfternoon
                            ? afterList['lectureName']
                            : morningList['lectureName'],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white))),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: assignmentList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> assignList = assignmentList[index];
                        String formattedDate =
                            DateFormat('MM월 dd일 a h:mm', 'ko_KR')
                                .format(DateTime.parse(assignList['deadLine']));
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            // padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xff9c9c9c)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.library_books,
                                        size: 32,
                                        color: Color(0xffA9A9A9),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text.rich(TextSpan(children: [
                                            TextSpan(
                                              text: ('${assignList['type']}\n'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                                text: formattedDate,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ))
                                          ])),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 57,
                                      height: 19,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Color(0xff9c9c9c),
                                      ),
                                      child: Center(
                                        child: Text(
                                          isSubmission ? '제출됨' : '미제출',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.angleRight,
                                      size: 25.0,
                                      color: Color(0xffA9A9A9),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}
