import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DetailAssignment extends StatefulWidget {
  const DetailAssignment({
    Key? key,
    required this.assignmentList,
    required this.isSubmission,
  }) : super(key: key);

  final Map<String, dynamic> assignmentList;
  final bool isSubmission;

  @override
  State<DetailAssignment> createState() => _DetailAssignmentState();
}

class _DetailAssignmentState extends State<DetailAssignment> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR'); //한글 로케일 데이터를 초기화 ( 오전,오후로 사용하려고
  }

  @override
  Widget build(BuildContext context) {
    String deadLine = DateFormat('MM월dd일 a HH:mm', 'ko_KR')
        .format(DateTime.parse(widget.assignmentList['deadLine']));
    String createDate = DateFormat('yyyy/MM/dd a HH:mm', 'ko_KR')
        .format(DateTime.parse(widget.assignmentList['createDate']));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          elevation: 4.0, //앱바 입체감 없애기
          title: Center(
            child: Text(
              '과제 상세정보',
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
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 35,
                color: Color(0xffbbbbbb),
                child: Center(
                    child: Text(widget.assignmentList['type'],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white))),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("마감일"),
                              SizedBox(
                                height: 9,
                              ),
                              Container(
                                width: 170,
                                padding:
                                    EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 5.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: Color(0xff9c9c9c)))),
                                child: Text(deadLine,
                                    style: TextStyle(
                                      color: Color(0xff9c9c9c),
                                    )),
                              ),
                            ],
                          ),
                          widget.isSubmission
                              ? Icon(Icons.check_circle,
                                  size: 40, color: Color(0xff4DCC69))
                              : Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Icon(FontAwesomeIcons.times,
                                        size: 30, color: Colors.white),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text('상세 정보'),
                      SizedBox(
                        height: 9,
                      ),
                      Container(
                        width: 350, //너비를 지정해주면
                        height: 350,
                        padding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Color(0xff9c9c9c),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Text(widget.assignmentList['content'],
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 3.0, 0, 0.0),
                        width: 348,
                        child: Text("생성일  $createDate",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                    ]),
              )
            ],
          )),
        ));
  }
}
