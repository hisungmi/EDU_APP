import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool isEdit = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isEdit
          ? AppBar(
              title: Image.asset(
                "assets/img/whitelogo.png",
                height: 80,
              ),
              centerTitle: true,
              backgroundColor: Color(0xff0099FF),
              toolbarHeight: 80,
              elevation: 0.0, //앱바 입체감 없애기
              leading: IconButton(
                  icon: Icon(Icons.menu),
                  iconSize: 30,
                  onPressed: () {
                    print("클릭");
                  }),
              actions: [
                IconButton(
                  icon: Icon(Icons.perm_identity),
                  iconSize: 30,
                  onPressed: () {},
                )
              ],
            )
          : AppBar(
              backgroundColor: Color(0xff0099FF),
              toolbarHeight: 60,
              elevation: 0.0, //앱바 입체감 없애기
              leading: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                    // Navigator.pop(context);
                  },
                  child: Text(
                    "취소",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      print("완료");
                    },
                    child: Text("완료",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )))
              ],
            ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //글자들이 왼쪽에 붙게
            children: [
              Stack(//Positioned 를 쓸수있음
                  children: [
                Positioned(
                  //Stack 안에서만 사용가능
                  left: 0,
                  top: 40,
                  child: Container(
                    width: 450,
                    height: 2,
                    color: Color(0xff9C9C9C),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      profileImage(),
                      SizedBox(
                        width: 17.0,
                      ),
                      isEdit ? profileInfo() : editProfileInfo(),
                    ],
                  ),
                ), //프로필 이름 소개
                isEdit
                    ? Positioned(
                        right: 0,
                        top: 50,
                        child: IconButton(
                          icon: Icon(Icons.create),
                          color: Color(0xff9C9C9C),
                          onPressed: () {
                            setState(() {
                              isEdit = !isEdit;
                            });
                          },
                        ),
                      )
                    : Positioned(
                        left: 113,
                        top: 75,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  width: 1, color: Color(0xff9c9c9c))),
                          child: IconButton(
                            padding: EdgeInsets.all(3),
                            constraints: BoxConstraints(), //아이콘위젯 패딩아예없애는법
                            icon: Icon(Icons.photo_camera),
                            color: Color(0xff9C9C9C),
                            onPressed: () {},
                          ),
                        ),
                      ),
              ]),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 280,
                margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                child: isEdit ? profileLabel() : editProfileLabel(),
              ), //프로필 정보
              SizedBox(
                height: 25.0,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  width: 130,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff9C9C9C),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    child: Text(
                      "학적부 열람",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffFA2A2A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ), //학적부 열람
              SizedBox(
                height: 40.0,
              ),
              Stack(children: [
                Positioned(
                  top: 13,
                  child: Container(
                    width: 450,
                    height: 2,
                    color: Color(0xff9C9C9C),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                  width: 110.0,
                  height: 30.0,
                  color: Colors.white,
                  child: Text(
                    "보호자 프로필",
                    style: TextStyle(
                      color: Color(0xff5A5A5A),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ), //보호자프로필
                Container(
                  height: 200,
                  margin: EdgeInsets.fromLTRB(65.0, 30.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            "성함",
                            style: TextStyle(
                                color: Color(0xff9C9C9C),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            "번호",
                            style: TextStyle(
                                color: Color(0xff9C9C9C),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            "박신비",
                            style: TextStyle(
                                color: Color(0xff9C9C9C),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                            child: Text(
                              "010-7894-4949",
                              style: TextStyle(
                                  color: Color(0xff9C9C9C),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ), //보호자 프로필
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileImage() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          border: Border.all(width: 2, color: Color(0xff9c9c9c))),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/img/profilebasic.png'),
        radius: 55.0,
      ),
    );
  }

  Widget profileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          width: 100,
          height: 25,
          child: Text(
            "김성미 (여)",
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff5A5A5A),
            ),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          "헬로방구~~",
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 14,
            color: Color(0xff9C9C9C),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget editProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          width: 100,
          height: 25,
          child: Text(
            "김성미 (여)",
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff5A5A5A),
            ),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          "헬로방구~~",
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 14,
            color: Color(0xff9C9C9C),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget profileLabel() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            SizedBox(
              height: 25.0,
            ),
            Text.rich(
              //Default Textstyle을 기본적으로 적용 - RichText는 기본스타일을 명시해줘야함
              TextSpan(
                //글자, ,문장을 모아 문단을 구성
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Color(0xffFA2A2A),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                      )),
                  TextSpan(
                      text: '학교',
                      style: TextStyle(
                        color: Color(0xff9C9C9C),
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "생년월일",
              style: TextStyle(
                  color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Color(0xffFA2A2A),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                      )),
                  TextSpan(
                      text: '번호',
                      style: TextStyle(
                        color: Color(0xff9C9C9C),
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Color(0xffFA2A2A),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                      )),
                  TextSpan(
                      text: '이메일',
                      style: TextStyle(
                        color: Color(0xff9C9C9C),
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "주소",
              style: TextStyle(
                  color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          width: 30.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Text(
              "서정중학교 2학년",
              style: TextStyle(
                  color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "2001년 02월 07일",
              style: TextStyle(
                  color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              child: Text(
                "010-4561-4565",
                style: TextStyle(
                    color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              child: Text(
                "sungmi@sungmi.com",
                style: TextStyle(
                    color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 25.0,
              width: 50.0,
            ),
            Container(
              width: 270, //너비를 지정해주면
              margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              child: Text(
                "경기도 고양시 덕양구 고양동 중부대 828호 줄바꿈!!!",
                overflow: TextOverflow.ellipsis, //줄바꿈
                maxLines: 3, //개수
                style: TextStyle(
                    color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget editProfileLabel() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            SizedBox(
              height: 25.0,
            ),
            Text.rich(
              //Default Textstyle을 기본적으로 적용 - RichText는 기본스타일을 명시해줘야함
              TextSpan(
                //글자, ,문장을 모아 문단을 구성
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Color(0xffFA2A2A),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                      )),
                  TextSpan(
                      text: '학교',
                      style: TextStyle(
                        color: Color(0xff9C9C9C),
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "생년월일",
              style: TextStyle(
                  color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Color(0xffFA2A2A),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                      )),
                  TextSpan(
                      text: '번호',
                      style: TextStyle(
                        color: Color(0xff9C9C9C),
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Color(0xffFA2A2A),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                      )),
                  TextSpan(
                      text: '이메일',
                      style: TextStyle(
                        color: Color(0xff9C9C9C),
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "주소",
              style: TextStyle(
                  color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          width: 30.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Text(
              "서정중학교 2학년",
              style: TextStyle(
                  color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "2001년 02월 07일",
              style: TextStyle(
                  color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              child: Text(
                "010-4561-4565",
                style: TextStyle(
                    color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              child: Text(
                "sungmi@sungmi.com",
                style: TextStyle(
                    color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 25.0,
              width: 50.0,
            ),
            Container(
              width: 270, //너비를 지정해주면
              margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              child: Text(
                "경기도 고양시 덕양구 고양동 중부대 828호 줄바꿈!!!",
                overflow: TextOverflow.ellipsis, //줄바꿈
                maxLines: 3, //개수
                style: TextStyle(
                    color: Color(0xff9C9C9C), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )
      ],
    );
  }
}
