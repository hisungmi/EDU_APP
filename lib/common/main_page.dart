import 'package:edu_application_pre/layout/wave_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = true;
          });
        },
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Transform.rotate(
                    angle: 180 * pi / 180,
                    child: Container(height: 294, child: WaveWidget()),
                  )),
              if (!isLogin)
                Container(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.all(2),
                          //   margin: EdgeInsets.only(bottom: 14),
                          //   height: 10,
                          //   width: 149,
                          //   decoration: BoxDecoration(
                          //       border:
                          //           Border.all(width: 1, color: Color(0xff9C9C9C)),
                          //       borderRadius: BorderRadius.circular(4)),
                          //   child: const LinearProgressIndicator(
                          //     backgroundColor: Colors.white,
                          //   ),
                          // ),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: Image.asset(
                              'assets/img/logo.png',
                              width: 141,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: Color(0xff0099FF),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xff9C9C9C),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(11, 0, 11, 0),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0099FF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xff9C9C9C),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: Color(0xff0099FF),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xff9C9C9C),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 14),
                              child: const Text(
                                '터치 시 다음 화면으로 넘어가요!',
                                style: TextStyle(
                                  color: Color(0xff9C9C9C),
                                  // shadows: [
                                  //   Shadow(
                                  //       offset: Offset(1, 1),
                                  //       blurRadius: 1.0,
                                  //       color: Colors.black)
                                  // ],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ])),
              if (isLogin)
                Form(
                    child: Center(
                  child: Container(
                    padding: EdgeInsets.all(40.0),
                    // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                    // SingleChildScrollView으로 감싸 줌
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: Image.asset(
                              'assets/img/logo.png',
                              width: 75,
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(labelText: 'ID'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/home');
                                },
                                child: Text("login"),
                                style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9)))),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(height: 294, child: WaveWidget()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
