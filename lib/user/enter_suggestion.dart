import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterSuggestion extends StatefulWidget {
  const EnterSuggestion({Key? key}) : super(key: key);

  @override
  State<EnterSuggestion> createState() => _EnterSuggestionState();
}

class _EnterSuggestionState extends State<EnterSuggestion> {
  var now = DateTime.now();
  final typeList = ['강의', '학생', '강사', '시설물', '기타'];
  var selectValue = '기타';

  String name = '';
  String phone = '';
  void loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      Map<String, dynamic> dataMap = jsonDecode(userData);
      setState(() {
        name = dataMap['name'] ?? '';
        phone = dataMap['phone'] ?? '';
      });
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
        backgroundColor: Color(0xff0099FF),
        toolbarHeight: 70,
        elevation: 0.0, //앱바 입체감 없애기
        leading: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(0),
            ),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Text(
              "취소",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Text("건의",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )))
        ],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 50.0, 0.0, 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('날짜'),
                SizedBox(
                  height: 9,
                ),
                Container(
                  width: 190,
                  padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 7.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: Color(0xffcfcfcf)))),
                  child: Text(DateFormat('yyy.MM.d.EEEE').format(now),
                      style: TextStyle(
                        color: Color(0xffcfcfcf),
                      )),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('이름'),
                SizedBox(
                  height: 9,
                ),
                Container(
                  width: 190,
                  padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 7.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: Color(0xffcfcfcf)))),
                  child: Text(name,
                      style: TextStyle(
                        color: Color(0xffcfcfcf),
                      )),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('건의 유형'),
                SizedBox(
                  height: 9,
                ),
                Container(
                  width: 190,
                  height: 34,
                  padding: EdgeInsets.fromLTRB(10.0, 3.0, 12.0, 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 2,
                        color: Color(0xff9c9c9c),
                      )),
                  child: DropdownButton(
                    hint: Text("유형 선택"),
                    icon: FaIcon(FontAwesomeIcons.angleDown),
                    iconDisabledColor: Color(0xff9c9c9c), //선택 안 됐을때 색
                    iconEnabledColor: Color(0xff9c9c9c), //선택 됐을때 색
                    borderRadius: BorderRadius.circular(12),
                    isExpanded: true, //너비 조절 할건지
                    isDense: true, //버튼 높이 조절 할건지
                    menuMaxHeight: 150, //제한 높이
                    style: TextStyle(
                        color: Color(0xff9c9c9c), fontWeight: FontWeight.w500),
                    value: selectValue,
                    items: typeList.map(
                      (String value) {
                        return DropdownMenuItem(
                            value: value, child: Text(value));
                      },
                    ).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('내용'),
                SizedBox(
                  height: 9,
                ),
                Container(
                  width: 336, //너비를 지정해주면
                  height: 200,
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff9c9c9c),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xff9c9c9c),
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        hintText: '내용 입력',
                        border: InputBorder.none, //테두리없앰
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xff9c9c9c))),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('연락받을 번호'),
                SizedBox(
                  height: 9,
                ),
                Container(
                  width: 190,
                  padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 7.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: Color(0xffcfcfcf)))),
                  child: Text(phone,
                      style: TextStyle(
                        color: Color(0xffcfcfcf),
                      )),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          )),
    );
  }
}
