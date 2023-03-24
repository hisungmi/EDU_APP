import 'package:flutter/material.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({Key? key}) : super(key: key);

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

TableRow tableData = TableRow(children: [
  TableCell(
    child: Text(
      "건의일자",
      textAlign: TextAlign.center,
    ),
  ),
  TableCell(
    child: Text(
      "유형",
      textAlign: TextAlign.center,
    ),
  ),
  TableCell(
    child: Container(
      height: 80,
      child: Text(
        "내용",
        textAlign: TextAlign.center,
      ),
    ),
  ),
]);

class _SuggestionsState extends State<Suggestions> {
  bool isProcess = true;

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Positioned(
                      top: 0,
                      left: 25,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isProcess = true;
                              });
                            },
                            child: isProcess
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff0099ff),
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                        )),
                                    width: 90,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        "처리중",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Color(0xff9c9c9c))),
                                    width: 90,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        "처리중",
                                        textAlign: TextAlign.center,
                                        // style: TextStyle(fontSize: 18)
                                      ),
                                    ),
                                  ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isProcess = false;
                              });
                            },
                            child: isProcess
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Color(0xff9c9c9c))),
                                    width: 90,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        "답변완료",
                                        textAlign: TextAlign.center,
                                        // style: TextStyle(fontSize: 18)
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff0099ff),
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                        )),
                                    width: 90,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        "답변완료",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      )),
                  Container(
                      height: 450,
                      margin: EdgeInsets.fromLTRB(25.0, 29.0, 25.0, 0),
                      padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Color(0xff0099ff),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isProcess
                              ? Table(
                                  border: TableBorder(
                                    verticalInside: BorderSide(
                                      color: Color(0xffcfcfcf),
                                      width: 1,
                                    ),
                                  ),
                                  columnWidths: const {
                                    0: FlexColumnWidth(3),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(4),
                                  },
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: <TableRow>[
                                    // tableData,
                                    TableRow(children: [
                                      TableCell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Color(0xff9c9c9c)))),
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              "건의일자",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Color(0xff9c9c9c)))),
                                          child: Center(
                                            child: Text(
                                              "유형",
                                              textAlign: TextAlign.center,
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
                                                      color:
                                                          Color(0xff9c9c9c)))),
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              "내용",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                "2023/03/16",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            "학생",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            width: 160,
                                            child: Center(
                                              child: Text(
                                                "내 짝이 이상해욜로욜로욜로욜로리욜로리",
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Text(
                                            "2023/03/14",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            "시설물",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                "너무 낡음.어쩌구어저국저거거주겆거적ㅈ거적ㅈ겆거",
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Table(
                                  border: TableBorder(
                                    verticalInside: BorderSide(
                                      color: Color(0xffcfcfcf),
                                      width: 1,
                                    ),
                                  ),
                                  columnWidths: const {
                                    0: FlexColumnWidth(3),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(4),
                                  },
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: <TableRow>[
                                    // tableData,
                                    TableRow(children: [
                                      TableCell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Color(0xff9c9c9c)))),
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              "건의일자",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Color(0xff9c9c9c)))),
                                          child: Center(
                                            child: Text(
                                              "유형",
                                              textAlign: TextAlign.center,
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
                                                      color:
                                                          Color(0xff9c9c9c)))),
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              "내용",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                "2023/03/08",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            "기타",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            width: 160,
                                            child: Center(
                                              child: Text(
                                                "버스좀 늘려주세요",
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Text(
                                            "2023/03/01",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            "기타",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                "학원시러시러시러시러시러시러시러",
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      )),
                ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Color(0xff9c9c9c))),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Colors.white, //버튼 색변경
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "건의하기",
                          style:
                              TextStyle(color: Color(0xff9c9c9c), fontSize: 16),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
