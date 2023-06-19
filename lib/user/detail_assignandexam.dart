import 'package:edu_application_pre/http_setup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DetailAssignment extends StatefulWidget {
  const DetailAssignment({
    Key? key,
    required this.status,
    required this.data,
    required this.type,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final Map<String, dynamic> status;
  final String type;

  @override
  State<DetailAssignment> createState() => _DetailAssignmentState();
}

class _DetailAssignmentState extends State<DetailAssignment> {
  late String _fileUrl;
  late String _fileName;
  Future<String> get _localPath async {
    final dir = await getTemporaryDirectory();
    return dir.path;
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR'); //한글 로케일 데이터를 초기화 ( 오전,오후로 사용하려고
    if (widget.type == 'exam') {
      _fileUrl = '$baseUrl/media/${widget.data['testSheet']}';
    } else if (widget.type == 'assignment') {
      _fileUrl = '$baseUrl/media/${widget.data['assignment']}';
    }
    // _fileName = _fileUrl.split('/').last;
  }

  Future<void> downloadFile() async {
    try {
      var request = await http.get(Uri.parse(_fileUrl));
      // final tempDir = await getTemporaryDirectory();
      // final file = File('$_fileUrl');
      // await file.writeAsBytes(request.bodyBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('파일이 다운로드되었습니다.')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('파일 다운로드 중 오류가 발생했습니다.')),
      );
      print('error: $error');
    }
  }

  String deadLine = "";
  String createDate = "";
  String tcreateDate = "";
  String testDate = "";
  String submission = '';
  Map<String, dynamic> testList = {};
  Map<String, dynamic> assList = {};
  Map<String, dynamic> assStatusList = {};
  Map<String, dynamic> testStatusList = {};
  bool ass = false;
  @override
  Widget build(BuildContext context) {
    if (widget.type == 'exam') {
      testList = widget.data;
      testStatusList = widget.status;
      if (testStatusList['studentName'] == '김성미') {
        submission = testStatusList['testProgress'];
      }
      ass = false;
    } else if (widget.type == 'assignment') {
      assList = widget.data;
      assStatusList = widget.status;
      if (assStatusList['studentName'] == '김성미') {
        submission = assStatusList['assignState'];
      }
      ass = true;
    }

    if (ass == true) {
      deadLine = DateFormat('MM월dd일 a HH:mm', 'ko_KR')
          .format(DateTime.parse(assList['deadLine']));
      createDate = DateFormat('yyyy/MM/dd a HH:mm', 'ko_KR')
          .format(DateTime.parse(assList['createDate']));
    } else {
      testDate = DateFormat('MM월dd일 a HH:mm', 'ko_KR')
          .format(DateTime.parse(testList['testDate']));
      tcreateDate = DateFormat('yyyy/MM/dd a HH:mm', 'ko_KR')
          .format(DateTime.parse(testList['createDate']));
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          elevation: 4.0, //앱바 입체감 없애기
          title: Center(
            child: Text(
              ass ? '과제 상세정보' : '시험 상세정보',
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
                    child: Text(ass ? assList['type'] : testList['testType'],
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
                              Text(ass ? "마감일" : "시험일자"),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 170,
                                padding:
                                    EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 5.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xff9c9c9c)))),
                                child: Text(ass ? deadLine : testDate,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9c9c9c),
                                    )),
                              ),
                            ],
                          ),
                          ass
                              ? submission == '제출'
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
                                    )
                              : submission == '예정'
                                  ? Container(
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
                                    )
                                  : Icon(Icons.check_circle,
                                      size: 40, color: Color(0xff4DCC69))
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
                          child: Text(
                              ass
                                  ? assList['content']
                                  : testList['content'].isNotEmpty
                                      ? testList['content']
                                      : '내용 없음',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 3.0, 0, 0.0),
                        width: 348,
                        child: Text(
                            ass ? "생성일  $createDate" : '생성일 $tcreateDate',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ass
                          ? assList['assignment'].isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '파일',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        downloadFile();
                                      },
                                      child: Text(assList['assignment'],
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Color(0xff52BAFF),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                    )
                                  ],
                                )
                              : Text('파일없음',
                                  style: TextStyle(fontWeight: FontWeight.w500))
                          : testList['testSheet'].isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '파일',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        downloadFile();
                                      },
                                      child: Text(testList['testSheet'],
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Color(0xff52BAFF),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                    )
                                  ],
                                )
                              : Text('파일없음',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                    ]),
              )
            ],
          )),
        ));
  }
}
