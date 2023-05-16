import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrCheck extends StatefulWidget {
  const QrCheck({Key? key}) : super(key: key);

  @override
  State<QrCheck> createState() => _QrCheckState();
}

class _QrCheckState extends State<QrCheck> {
  bool isCount = true;
  static const maxSec = 60; //최대 시간 지정
  int seconds = maxSec; //시간 넣어주고
  late Timer timer; //이건 뭔의미지

  //시간 포멧 설정
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  //초 리셋 다시시작
  void reset() => setState(() {
        seconds = maxSec;
        isCount = true;
      });
  //초 세기 시작
  //mounted : State 객체가 여전히 화면에 나타나 있는지 확인한 후, 그 후에 setState() 메소드를 호출하고 상태를 업데이트
  void startTimer(mounted) {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds--; //1초에 하나씨 줄어듬
      });
      if (seconds == 0) {
        isCount = false; //0이되면 인증시간 만료
      }
    });
  }

  String studentKey = '';
  void loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      Map<String, dynamic> dataMap = jsonDecode(userData);
      setState(() {
        studentKey = dataMap['studentKey'] ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer(mounted);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QR체크',
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
        body: Center(
          child: Column(
            children: [
              Container(
                width: 320,
                height: 450,
                margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                decoration: BoxDecoration(
                    color: Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 190.0, 0.0),
                      child: Text(
                        '출석 체크',
                        style: TextStyle(
                          color: Color(0xff5a5a5a),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    isCount
                        ? QrImageView(
                            data: studentKey,
                            foregroundColor: Color(0xff0099ff),
                            size: 220,
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              QrImageView(
                                data: studentKey,
                                foregroundColor: Color(0xff0099ff),
                                size: 220,
                              ),
                              Positioned(
                                  right: 5,
                                  child: Opacity(
                                    opacity: 0.89,
                                    child: Container(
                                      width: 210,
                                      height: 210,
                                      color: Color(0xffF1F1F1),
                                    ),
                                  )),
                              Positioned(
                                  left: 70,
                                  child: MaterialButton(
                                    color: Colors.white,
                                    shape: CircleBorder(), //원으로 변해라
                                    padding: EdgeInsets.all(10),
                                    onPressed: () {
                                      reset();
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.arrowRotateRight,
                                      color: Color(0xff5a5a5a),
                                      size: 30,
                                    ),
                                  )),
                            ],
                          ),
                    SizedBox(
                      height: 35,
                    ),
                    isCount
                        ? Container(
                            child: Text(
                              format(seconds),
                              style: TextStyle(
                                  color: Color(0xfffa2a2a),
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : Container(
                            child: Text(
                              '인증시간이 만료되었습니다.\n다시시도해주세요',
                              textAlign: TextAlign.center, //text 가운데 정렬
                              style: TextStyle(
                                  color: Color(0xff5a5a5a),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
