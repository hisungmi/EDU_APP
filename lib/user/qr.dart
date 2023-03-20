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
                width: 310,
                margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                padding: EdgeInsets.fromLTRB(20, 25, 50, 90),
                decoration: BoxDecoration(
                    color: Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCount = !isCount;
                        });
                      },
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
                            margin: EdgeInsets.fromLTRB(35, 0, 0, 0),
                            child: QrImage(
                              data: "김성미",
                              foregroundColor: Color(0xff0099ff),
                              size: 200,
                            ),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(35, 0, 0, 0),
                                child: QrImage(
                                  data: "김성미",
                                  foregroundColor: Color(0xff0099ff),
                                  size: 200,
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
                                  right: 50,
                                  child: MaterialButton(
                                    color: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(10), //원으로 변해라
                                    onPressed: () {
                                      setState(() {
                                        isCount = !isCount;
                                      });
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
                            margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                            child: Text(
                              '( 03:55 )',
                              style: TextStyle(
                                  color: Color(0xfffa2a2a),
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
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
