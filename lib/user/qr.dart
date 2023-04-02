import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds--; //1초에 하나씨 줄어듬
      });
      if (seconds == 0) {
        isCount = false; //0이되면 인증시간 만료
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
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
                        ? Container(
                            child: QrImage(
                              data: "김성미",
                              foregroundColor: Color(0xff0099ff),
                              size: 220,
                            ),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                child: QrImage(
                                  data: "김성미",
                                  foregroundColor: Color(0xff0099ff),
                                  size: 220,
                                ),
                              ),
                              Positioned(
                                  right: 10,
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