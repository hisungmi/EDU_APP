import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckSuggestion extends StatefulWidget {
  const CheckSuggestion({Key? key}) : super(key: key);

  @override
  State<CheckSuggestion> createState() => _CheckSuggestionState();
}

class _CheckSuggestionState extends State<CheckSuggestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0099FF),
          toolbarHeight: 70,
          elevation: 0.0, //앱바 입체감 없애기
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.angleLeft),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 50.0, 0.0, 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('날짜'),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          width: 150,
                          padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 7.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: Color(0xffcfcfcf)))),
                          child: Text('쓴 날짜',
                              style: TextStyle(
                                color: Color(0xffcfcfcf),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('유형'),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          width: 100,
                          padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 7.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: Color(0xffcfcfcf)))),
                          child: Text('유형',
                              style: TextStyle(
                                color: Color(0xffcfcfcf),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('건의 내용'),
                SizedBox(
                  height: 9,
                ),
                Container(
                  width: 336, //너비를 지정해주면
                  height: 140,
                  padding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff9c9c9c),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("건의사항여깄따",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text('관리자 답변'),
                SizedBox(
                  height: 9,
                ),
                Container(
                    width: 336, //너비를 지정해주면
                    height: 140,
                    padding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Color(0xff9c9c9c),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("답답답답답답",
                        style: TextStyle(fontWeight: FontWeight.w500))),
              ],
            ),
          ),
        ));
  }
}
