import 'dart:convert';
import 'package:edu_application_pre/layout/wave_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../http_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  bool isLogin = false;
  String id = '';

  void doLogin() async {
    // async await 잊지 말고 걸어주기!
    if (id == 'kiosk') {
      await Navigator.pushNamed(context, '/kiosk');
    } else {
      Map<String, dynamic> data = {
        'userType': 'STU',
        'id': id,
      }; // Map<String, dynamic>이 우리가 사용하는 {key: value} 형식의 데이터

      // axios 사용해서 날릴 때도 {key: value} 형식의 데이터를 json으로 변환해서 날려줬죠?? 여기서도 마찬가지로 json 형태로 변환해서 데이터에 실어 보내줍니다!
      var result = await post(
          '/members/compare/',
          jsonEncode(
              data)); // axios에서 await ApiClient(url, data) 형식으로 사용했던 것과 형태가 매우 유사하죠?
      // json 형태의 데이터를 다시 원래 형태로 변환, 즉 데이터 파싱은 jsonDecode(utf8.decode(result.bodyBytes))로 진행해주면 됩니다. 그럼 우리가 원하는 데이터 값을 얻을 수 있어요!
      print(result.data);
      // result.data를 로컬 스토리지에 저장하기
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //JSON 형식의 문자열로 변환하여 저장
      String userJsonData = jsonEncode(result.data);
      await prefs.setString('userData', userJsonData);

      if (!mounted) return;
      await Navigator.pushReplacementNamed(context, "/home");
    }
  }

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
                    child: SizedBox(height: 294, child: WaveWidget()),
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
                              onChanged: (text) {
                                setState(() {
                                  id = text;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  doLogin();
                                },
                                style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9))),
                                child: Text("login")),
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
                child: SizedBox(height: 294, child: WaveWidget()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
