import 'dart:convert';

import 'package:edu_application_pre/http_setup.dart';
import 'package:edu_application_pre/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Children extends StatefulWidget {
  const Children({Key? key}) : super(key: key);

  @override
  State<Children> createState() => _ChildrenState();
}

class _ChildrenState extends State<Children> {
  static List<dynamic> childrenList = [];

  String userType = '';
  String parentKey = '';
  String name = '';
  String id = '';
  String phone = '';
  String createDate = '';
  String editDate = '';
  void loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parData = prefs.getString('PARData');
    String? typeData = prefs.getString('userType');
    if (parData != null && typeData != null) {
      Map<dynamic, dynamic> dataMap = jsonDecode(parData);
      Map<dynamic, dynamic> typeMap = jsonDecode(typeData);
      setState(() {
        userType = typeMap['userType'] ?? '';
        parentKey = dataMap['parentKey'] ?? '';
        name = dataMap['name'] ?? '';
        id = dataMap['id'] ?? '';
        phone = dataMap['phone'] ?? '';
        createDate = dataMap['creatDate'] ?? '';
        editDate = dataMap['edtiDate'] ?? '';

        getStudentList(parentKey);
      });
    }
  }

  Future<void> getStudentList(String parentKey) async {
    Map<String, dynamic> data = {
      'userKey': '',
      'search': '',
      'lectureKey': '',
      'parentKey': parentKey,
    };
    childrenList = [];
    var res = await post('/members/getStudentList/', jsonEncode(data));
    setState(() {
      if (res.statusCode == 200) {
        for (Map<String, dynamic> children in res.data['resultData']) {
          childrenList.add(children);
          // print("list : $childrenList");
        }
      }
    });
  }

  void goMain(Map<String, dynamic> getChildren) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userData', jsonEncode(getChildren));

    int desiredIndex = 0; //홈으로가기
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyHomePage(desiredIndex),
      ),
    );
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
        title: Image.asset(
          'assets/img/logo.png',
          height: 50,
        ),
        centerTitle: true, // 텍스트 중앙 정렬
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8E8).withOpacity(0.8),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        toolbarHeight: 80,
        elevation: 4.0, //앱바 입체감 없애기
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                width: 140,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: childrenList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> getChildren = childrenList[index];
                    return Container(
                      height: 30,
                      margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color(0xff9c9c9c),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(0),
                        ),
                        child: Center(
                          child: Text(
                            getChildren['id'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff9c9c9c),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onPressed: () {
                          goMain(getChildren);
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
