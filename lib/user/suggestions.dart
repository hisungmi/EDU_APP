import 'dart:convert';

import 'package:edu_application_pre/http_setup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({Key? key}) : super(key: key);

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  bool isProcess = true;
  static List<dynamic> ySuggestList = [];
  static List<dynamic> nSuggestList = [];

  String studentKey = '';
  Future<void> loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      Map<String, dynamic> dataMap = jsonDecode(userData);
      setState(() {
        studentKey = dataMap['studentKey'] ?? '';
      });
      print('key: $studentKey');
      //stdentKey를 사용하여 getSuggestList() 함수 호출
      await getSuggestList(studentKey);
    }
  }

  //건의사항 리스트 불러오기
  //void는 반환값이 없음을 나타냄
  //퓨터void는 비동기작업의 결과를반환함
  Future<void> getSuggestList(String studentKey) async {
    //data 맵 객체 생성시 매개변수로 전달
    Map<String, dynamic> data = {
      'userKey': studentKey,
      'userType': 'STU',
      'search': '',
      'writerType': '',
    };
    ySuggestList = [];
    nSuggestList = [];
    var res = await post('/info/getSuggestList/', jsonEncode(data));
    if (res.statusCode == 200) {
      for (Map<String, dynamic> suggest in res.data['resultData']) {
        //state - Y or N
        print('suggest : $suggest');
        if (suggest['state'] == 'Y') {
          ySuggestList.add(suggest);
        }
        if (suggest['state'] == 'N') {
          nSuggestList.add(suggest);
        }
      }
      // lectureList = res.data['resultData'];
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

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
                          Table(
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
                                                color: Color(0xff9c9c9c)))),
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
                                                color: Color(0xff9c9c9c)))),
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
                                                color: Color(0xff9c9c9c)))),
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
                            ],
                          ),
                          isProcess
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: ySuggestList.length,
                                  itemBuilder: (context, index) {
                                    String createDate = ySuggestList[index]
                                            ['createDate']
                                        .toString(); //문자열로 변환
                                    DateTime dateTime = DateTime.parse(
                                        createDate); //datetime객체로변환후 날짜정보추출
                                    String dateString =
                                        '${dateTime.year}/${dateTime.month}/${dateTime.day}';
                                    String type = ySuggestList[index]['type'];
                                    String content =
                                        ySuggestList[index]['content'];
                                    return Container(
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 106.6,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffcfcfcf)))),
                                              child: Center(
                                                  child: Text(
                                                dateString,
                                                textAlign: TextAlign.center,
                                              ))),
                                          Container(
                                              width: 70.9,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffcfcfcf)))),
                                              child: Center(
                                                  child: Text(type,
                                                      textAlign:
                                                          TextAlign.center))),
                                          Container(
                                            width: 141,
                                            height: 40,
                                            decoration: BoxDecoration(),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Text(
                                                  content,
                                                  textAlign: TextAlign.end,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: nSuggestList.length,
                                  itemBuilder: (context, index) {
                                    String createDate = nSuggestList[index]
                                            ['createDate']
                                        .toString(); //문자열로 변환
                                    DateTime dateTime = DateTime.parse(
                                        createDate); //datetime객체로변환후 날짜정보추출
                                    String dateString =
                                        '${dateTime.year}/${dateTime.month}/${dateTime.day}';
                                    String type = nSuggestList[index]['type'];
                                    String content =
                                        nSuggestList[index]['content'];
                                    return Container(
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 106.6,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffcfcfcf)))),
                                              child: Center(
                                                  child: Text(
                                                dateString,
                                                textAlign: TextAlign.center,
                                              ))),
                                          Container(
                                              width: 70.9,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffcfcfcf)))),
                                              child: Center(
                                                  child: Text(type,
                                                      textAlign:
                                                          TextAlign.center))),
                                          Container(
                                            width: 141,
                                            height: 40,
                                            decoration: BoxDecoration(),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Text(
                                                  content,
                                                  textAlign: TextAlign.end,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/enter-suggestion');
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Colors.white, //버튼 색변경
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "건의하기",
                          style: TextStyle(
                              color: Color(0xff9c9c9c),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
