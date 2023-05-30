import 'dart:convert';

import 'package:edu_application_pre/http_setup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.date,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  String date;
  bool isExpanded;
}

class _NoticeState extends State<Notice> {
  static List<dynamic> getnoticeList = [];

  String studentKey = '';
  void loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      Map<dynamic, dynamic> dataMap = jsonDecode(userData);

      setState(() {
        studentKey = dataMap['studentKey'] ?? '';
      });
      getNoticeList(studentKey);
    }
  }

  Future<void> getNoticeList(String studentKey) async {
    Map<String, dynamic> data = {
      'userKey': '',
      'search': '',
      'date': '',
      'type': '전체',
    };
    getnoticeList = [];
    var res = await post('/info/getNoticeList/', jsonEncode(data));
    if (res.statusCode == 200) {
      setState(() {
        for (Map<String, dynamic> notice in res.data['resultData']) {
          getnoticeList.add(notice);
        }
      });
    }
  }

  List<Item> getnotice = List<Item>.generate(getnoticeList.length, (index) {
    Map<String, dynamic> noticeList = getnoticeList[index];
    String formattedDate = DateFormat('yyyy/MM/dd HH:mm')
        .format(DateTime.parse(noticeList['createDate']));
    return Item(
      headerValue: noticeList['title'],
      expandedValue: noticeList['content'],
      date: formattedDate,
    );
  });

  @override
  void initState() {
    super.initState();
    setState(() {
      loadData();
      getNoticeList(studentKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공지사항',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true, // 텍스트 중앙 정렬
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          },
          child: Image.asset(
            'assets/img/whitelogo.png',
          ),
        ),
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
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 2, color: Color(0xff9c9c9c)),
              )),
              child: Text.rich(TextSpan(children: const [
                TextSpan(
                    text: ('공지사항'), style: TextStyle(color: Color(0xff5a5a5a))),
                WidgetSpan(
                    child: SizedBox(
                  width: 2,
                )),
                WidgetSpan(
                  child: FaIcon(FontAwesomeIcons.bullhorn,
                      size: 20, color: Color(0xff5a5a5a)),
                )
              ])),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: getnotice.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: getnotice[index].isExpanded ? 0 : 1,
                                  color: Color(0xffc1c1c1)))),
                      child: ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 500),
                        elevation: 0,
                        dividerColor: Color(0xff9c9c9c),
                        expansionCallback: (int itemIndex, bool isExpanded) {
                          setState(() {
                            getnotice[index].isExpanded = !isExpanded;
                          });
                        },
                        children: [
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text(getnotice[index].headerValue,
                                    style: TextStyle(
                                        color: Color(0xff9c9c9c),
                                        fontWeight: FontWeight.w600)),
                                subtitle: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                  child: Text(getnotice[index].date,
                                      style: TextStyle(
                                          color: Color(0xff9c9c9c),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400)),
                                ),
                              );
                            },
                            body: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff6f6f6),
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: Color(0xff9c9c9c)))),
                              padding: EdgeInsets.all(20),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getnotice[index].expandedValue,
                                        style: TextStyle(
                                            color: Color(0xff9c9c9c))),
                                  ],
                                ),
                              ),
                            ),
                            isExpanded: getnotice[index].isExpanded,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
