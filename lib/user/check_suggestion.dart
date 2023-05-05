import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CheckSuggestion extends StatelessWidget {
  const CheckSuggestion({
    Key? key,
    required this.isProcess,
    required this.suggestList,
  }) : super(key: key);

  final bool isProcess;
  final Map<String, dynamic> suggestList;

  static const routeName = "/cheack-suggestion";

  @override
  Widget build(BuildContext context) {
    String createDate = DateFormat('yyyy/MM/dd HH:mm')
        .format(DateTime.parse(suggestList['createDate']));
    String? answerDate = (suggestList['answerDate']) == null
        ? ''
        : DateFormat('yyyy/MM/dd HH:mm')
            .format(DateTime.parse(suggestList['answerDate']));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0099FF),
          toolbarHeight: 70,
          elevation: 0.0, //앱바 입체감 없애기
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.angleLeft),
            color: Colors.white,
            onPressed: () {
              //현재 페이지를 스택에서 제거하고 이전 페이지로 돌아감
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
                      Text('이름'),
                      SizedBox(
                        height: 9,
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 5.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Color(0xffcfcfcf)))),
                        child: Text(suggestList['writerName'],
                            style: TextStyle(
                              color: Color(0xffcfcfcf),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
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
                        padding: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 5.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2, color: Color(0xffcfcfcf)))),
                        child: Text(suggestList['type'],
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
                height: 200,
                padding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Color(0xff9c9c9c),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Text(suggestList['content'],
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ),
              Container(
                alignment: Alignment(0.6, 0.0),
                child: Text(createDate,
                    style: TextStyle(color: Color(0xffCFCFCF))),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text('관리자 답변'),
              SizedBox(
                height: 9,
              ),
              Container(
                  width: 336,
                  height: 200,
                  padding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff9c9c9c),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isProcess
                      ? Text("답변을 대기중입니다........",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500))
                      : SingleChildScrollView(
                          child: Text(suggestList['answer'],
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        )),
              Container(
                alignment: Alignment(0.6, 0.0),
                child: Text(answerDate,
                    style: TextStyle(color: Color(0xffCFCFCF))),
              ),
            ],
          )),
        ));
  }
}
