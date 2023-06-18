import 'dart:convert';

import 'package:edu_application_pre/http_setup.dart';
import 'package:edu_application_pre/user/detail_assignandexam.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Exam extends StatefulWidget {
  const Exam(
      {Key? key,
      required this.morning,
      required this.afternoon,
      required this.isAfternoon})
      : super(key: key);

  final Map<String, dynamic> morning;
  final Map<String, dynamic> afternoon;
  final bool isAfternoon;

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  bool isScore = false;
  bool isComplete = false;
  static List<dynamic> testList = [];
  static List<dynamic> testStatusList = [];
  String testKey = '';

  bool isSubmission = false;
  String name = '';
  Future<void> loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    String? typeData = prefs.getString('userType');

    if (userData != null && typeData != null) {
      Map<dynamic, dynamic> dataMap = jsonDecode(userData);

      setState(() {
        name = dataMap['name'] ?? '';
      });
    }
  }

  Future<void> getTestList() async {
    Map<String, dynamic> data = {
      'lectureKey': widget.isAfternoon
          ? widget.afternoon['lectureKey']
          : widget.morning['lectureKey'],
      'type': '',
      'testDate': '',
    };
    var res = await post('/lectures/getTestList/', jsonEncode(data));
    if (res.statusCode == 200) {
      setState(() {
        if (res.data['resultData'].isNotEmpty) {
          testList = res.data['resultData'];
          for (Map<String, dynamic> test in res.data['resultData']) {
            testKey = test['testKey'] ?? '';
          }
          getTestStatusList(testKey);
        } else {
          testList = res.data['resultData'];
          print('시험없음');
        }
      });
    }
  }

//시험 현황
  Future<void> getTestStatusList(String testKey) async {
    Map<String, dynamic> data = {'testKey': testKey};

    var res = await post('/lectures/getTestStatusList/', jsonEncode(data));
    if (res.statusCode == 200) {
      List<dynamic> status = res.data['resultData']
          .where((status) => status['studentName'] == name)
          .toList();
      setState(() {
        testStatusList = status;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR'); //한글 로케일 데이터를 초기화 ( 오전,오후로 사용하려고
    loadData();
    setState(() {
      getTestList();
    });
  }

  String progress = '';
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> morningList = widget.morning;
    Map<String, dynamic> afterList = widget.afternoon;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          elevation: 4.0, //앱바 입체감 없애기
          title: Center(
            child: Text(
              '시험',
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
                      widget.isAfternoon
                          ? afterList['lectureName']
                          : morningList['lectureName'],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  // tableData,
                  TableRow(children: [
                    TableCell(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Color(0xffa3a3a3)))),
                        height: 40,
                        child: Center(
                          child: Text(
                            "시험 일자",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xffa3a3a3)),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Color(0xffa3a3a3)))),
                        child: Center(
                          child: Text(
                            "시험 유형",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffa3a3a3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Color(0xffa3a3a3)))),
                        height: 40,
                        child: Center(
                          child: Text(
                            "",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xffa3a3a3)),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Color(0xffa3a3a3)))),
                        height: 40,
                        child: Center(
                          child: Text(
                            "상태",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xffa3a3a3)),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
              testList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: testList.length,
                      itemBuilder: (context, index) {
                        Map<dynamic, dynamic> testdataList = testList[index];
                        Map<dynamic, dynamic> testStatus =
                            testStatusList[index];
                        if (testStatus['testProgress'] == '예정') {
                          progress = '예정';
                          isSubmission = false;
                        } else {
                          progress = '완료';
                          isSubmission = true;
                        }
                        String formattedDate = DateFormat(
                                'MM월 dd일 HH시', 'ko_KR')
                            .format(DateTime.parse(testdataList['testDate']));
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailAssignment(
                                data: testList[index],
                                type: 'exam',
                                isSubmission: isSubmission,
                              ),
                            ));
                          },
                          child: Container(
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(2),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: <TableRow>[
                                TableRow(children: [
                                  TableCell(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Color(0xff9c9c9c)))),
                                    height: 55,
                                    child: Center(
                                      child: Text(
                                        formattedDate,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          13.0, 0.0, 0.0, 0.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xff9c9c9c)))),
                                      height: 55,
                                      child: Center(
                                        child: Text(
                                          testdataList['testType'],
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: isScore
                                        ? Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15.0, 0.0, 0.0, 0.0),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: Color(
                                                            0xff9c9c9c)))),
                                            height: 55,
                                            child: Center(
                                              child: Text(
                                                "80",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15.0, 0.0, 0.0, 0.0),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: Color(
                                                            0xff9c9c9c)))),
                                            height: 55,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isScore = true;
                                                  });
                                                },
                                                child: Container(
                                                  width: 57,
                                                  height: 19,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color(0xff9c9c9c),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '성적확인',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color(0xff9c9c9c)))),
                                      height: 55,
                                      child: Center(
                                        child: Text(
                                          progress,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        );
                      },
                    ))
                  : Container(
                      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text('시험 정보가 없습니다.',
                          style: TextStyle(color: Color(0xffb7b7b7))),
                    ),
            ],
          ),
        ));
  }
}
