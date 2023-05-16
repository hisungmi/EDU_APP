import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> morningList = widget.morning;
    Map<String, dynamic> afterList = widget.afternoon;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0099FF),
          toolbarHeight: 70,
          elevation: 0.0, //앱바 입체감 없애기
          title: Center(
            child: Text(
              '시험',
              textAlign: TextAlign.center,
            ),
          ),
          leading: Container(
            child: IconButton(
              icon: FaIcon(FontAwesomeIcons.angleLeft),
              color: Colors.white,
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
                color: Color(0xff9c9c9c),
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
                                    width: 2, color: Color(0xff9c9c9c)))),
                        height: 40,
                        child: Center(
                          child: Text(
                            "시험 일자",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xff565656)),
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
                                    width: 2, color: Color(0xff9c9c9c)))),
                        child: Center(
                          child: Text(
                            "시험 유형",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff565656),
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
                                    width: 2, color: Color(0xff9c9c9c)))),
                        height: 40,
                        child: Center(
                          child: Text(
                            "",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xff565656)),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Color(0xff9c9c9c)))),
                        height: 40,
                        child: Center(
                          child: Text(
                            "상태",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xff565656)),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
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
                                        width: 1, color: Color(0xff9c9c9c)))),
                            height: 55,
                            child: Center(
                              child: Text(
                                "12월09일 14시",
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
                              padding: EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 0.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xff9c9c9c)))),
                              height: 55,
                              child: Center(
                                child: Text(
                                  '대면 TEST1쏼라쏼라쏼라',
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
                                                color: Color(0xff9c9c9c)))),
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
                                                color: Color(0xff9c9c9c)))),
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
                                                BorderRadius.circular(7),
                                            color: Color(0xff9c9c9c),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '성적확인',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
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
                                          width: 1, color: Color(0xff9c9c9c)))),
                              height: 55,
                              child: Center(
                                child: Text(
                                  isComplete ? "완료" : "예정",
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
                  );
                },
              ))
            ],
          ),
        ));
  }
}
