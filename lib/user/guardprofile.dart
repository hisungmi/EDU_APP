import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_setup.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool isEdit = true;
  TextEditingController numController =
      TextEditingController(); //텍스트컨트롤러를 생성하여 필드에 할당
  TextEditingController addressController = TextEditingController();

  String studentKey = '';
  String name = '';
  String id = '';
  String birth = '';
  String sex = '';
  String phone = '';
  String emergency = '';
  String school = '';
  String grade = '';
  String address = '';
  String profileImg = '';
  String parentKey = '';
  String remark = '';

  void loadData() async {
    // 로컬 스토리지에서 데이터 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      Map<dynamic, dynamic> dataMap = jsonDecode(userData);

      setState(() {
        studentKey = dataMap['studentKey'] ?? '';
        name = dataMap['name'] ?? '';
        id = dataMap['id'] ?? '';
        birth = dataMap['birth'] ?? '';
        sex = dataMap['sex'] ?? '';
        phone = dataMap['phone'] ?? '';
        emergency = dataMap['emergency'] ?? '';
        school = dataMap['school'] ?? '';
        grade = dataMap['grade'] ?? '';
        address = dataMap['address'] ?? '';
        profileImg = dataMap['profileImg'] ?? '';
        parentKey = dataMap['parentKey'] ?? '';
        remark = dataMap['remark'] ?? '';
      });
    }
  }

  Future<void> getSuggestList(
      String studentKey, String grade, String remark, String school) async {
    //data 맵 객체 생성시 매개변수로 전달
    Map<String, dynamic> data = {
      'studentKey': studentKey,
      'grade': int.parse(grade), //int형으로 변환
      'remark': remark,
      'school': school,
      'phone': numController.text,
      'address': addressController.text,
    };
    var res = await post('/members/editStudent/', jsonEncode(data));
    setState(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //JSON문자열로 인코딩
      String updateData = jsonEncode(res.data['resultData']);
      //수정된 userData 다시 저장
      prefs.setString('userData', updateData);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자녀프로필',
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
            onPressed: () {
              fullMenu();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, //글자들이 왼쪽에 붙게
            children: [
              Stack(//Positioned 를 쓸수있음
                  children: [
                Positioned(
                  //Stack 안에서만 사용가능
                  left: 0,
                  top: 40,
                  child: Container(
                    width: 1920,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                            width: 100,
                            height: 25,
                            child: Text(
                              '$name($sex)',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5A5A5A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ), //프로필 이름 소개
              ]),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Container(
                    height: 280,
                    margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                    child: profileForm()),
              ), //프로필 정보
              SizedBox(
                height: 25.0,
              ),
              Center(
                child: isEdit
                    ? Container(
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
                              color: Color(0xff0099FF),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      )
                    : Container(),
              ), //학적부 열람
              SizedBox(
                height: 40.0,
              ),
              guardProfile()
            ],
          ),
        ),
      ),
    );
  }

  Future fullMenu() {
    return showModalBottomSheet(
        //밑에서 열리는 메뉴
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              color: Colors.white,
              child: Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.min, //크기만큼만 차지
                      children: [
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.circleUser),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('프로필',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 52,
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.chartPie),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('시간표',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/schedule", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.qrcode),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('출석 QR',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/qr", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.clipboardCheck),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('출석 현황',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/class", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.userPen),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('시험',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/exam", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.book),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('과제',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/assigment", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.envelopeOpen),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('건의사항',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/suggestion", (route) => false);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      //카드형식 높이주기위해 감쌈
                      height: 52,
                      child: Card(
                        //카드형식
                        elevation: 0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.bullhorn),
                          iconColor: Color(0xff9c9c9c),
                          title: Text('공지사항',
                              style: TextStyle(
                                color: Color(0xff9c9c9c),
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Divider(thickness: 1),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ])));
        });
  }

  Widget profileImage() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          border: Border.all(width: 2, color: Color(0xff9c9c9c))),
      child: CircleAvatar(
        backgroundImage: profileImg.isNotEmpty
            ? Image.network(baseUrl + profileImg).image
            : Image.asset('assets/img/profilebasic.png').image,
        radius: 55.0,
      ),
    );
  }

  Widget profileForm() {
    return Form(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 1.0),
                child: Text('ID'),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                //Default Textstyle을 기본적으로 적용 - RichText는 기본스타일을 명시해줘야함
                TextSpan(
                  //글자, ,문장을 모아 문단을 구성
                  children: const <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFA2A2A),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(text: '학교'),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text("생년월일"),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                TextSpan(
                  children: const <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFA2A2A),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(text: '번호'),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text("주소"),
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
              Text(id),
              SizedBox(
                height: 25.0,
              ),
              Text("$school $grade학년"),
              SizedBox(
                height: 27.0,
              ),
              Text(birth),
              SizedBox(
                height: 27.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                child: Text(phone),
              ),
              SizedBox(
                height: 25.0,
                width: 50.0,
              ),
              Container(
                width: 230, //너비를 지정해주면
                margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                child: Text(
                  address,
                  overflow: TextOverflow.ellipsis, //줄바꿈
                  maxLines: 3, //개수
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget editProfileForm() {
    return Form(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 1.0),
                child: Text('ID', style: TextStyle(color: Color(0xffCFCFCF))),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                //Default Textstyle을 기본적으로 적용 - RichText는 기본스타일을 명시해줘야함
                TextSpan(
                  //글자, ,문장을 모아 문단을 구성
                  children: const <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFFB0B0),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(
                        text: '학교',
                        style: TextStyle(
                          color: Color(0xffCFCFCF),
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
                  color: Color(0xffCFCFCF),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(
                TextSpan(
                  children: const <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Color(0xffFA2A2A),
                          letterSpacing: 2.0,
                        )),
                    TextSpan(
                        text: '번호',
                        style: TextStyle(
                          color: Color(0xff9C9C9C),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text("주소"),
            ],
          ),
          SizedBox(
            width: 30.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 230,
                height: 32,
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  color: Color(0xffd9d9d9).withOpacity(0.3),
                  border: Border.all(
                    width: 2,
                    color: Color(0xffCFCFCF),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  id,
                  style: TextStyle(
                    color: Color(0xffCFCFCF),
                  ),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Container(
                width: 230,
                height: 32,
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  color: Color(0xffd9d9d9).withOpacity(0.3),
                  border: Border.all(
                    width: 2,
                    color: Color(0xffCFCFCF),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$school $grade학년",
                  style: TextStyle(
                    color: Color(0xffCFCFCF),
                  ),
                ),
              ),
              SizedBox(
                height: 17.0,
              ),
              Container(
                width: 230,
                height: 32,
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  color: Color(0xffd9d9d9).withOpacity(0.3),
                  border: Border.all(
                    width: 2,
                    color: Color(0xffCFCFCF),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  birth,
                  style: TextStyle(color: Color(0xffCFCFCF)),
                ),
              ),
              SizedBox(
                height: 17.0,
              ),
              Container(
                  width: 230,
                  height: 32,
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff9c9c9c),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: numController, //컨트롤러롤 넘컨트롤러에 값을 박아
                    style: TextStyle(
                      color: Color(0xff9c9c9c),
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none, //테두리없앰
                        hintStyle: TextStyle(color: Color(0xff9c9c9c))),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, //숫자만
                      // NumberFormatter(),
                      LengthLimitingTextInputFormatter(11) //최대 13글자
                    ],
                  )),
              SizedBox(
                height: 15.0,
                width: 50.0,
              ),
              Flexible(
                child: Container(
                  width: 230, //너비를 지정해주면
                  height: 75,
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff9c9c9c),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: addressController,
                    maxLines: 5,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xff9c9c9c),
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: InputBorder.none, //테두리없앰
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xff9c9c9c))),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget guardProfile() {
    return Form(
      child: Stack(children: [
        Positioned(
          top: 13,
          child: Container(
            width: 1920,
            height: 2,
            color: Color(0xff9C9C9C),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
          width: 114.0,
          height: 30.0,
          color: Colors.white,
          child: Text(
            "보호자 연락처",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff5A5A5A),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ), //보호자프로필
        Container(
          height: 100,
          margin: EdgeInsets.fromLTRB(75.0, 30.0, 0.0, 0.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "번호",
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                    child: Text(
                      emergency,
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
    );
  }

  Widget editGuardProfile() {
    return Form(
      child: Stack(children: [
        Positioned(
          top: 13,
          child: Container(
            width: 450,
            height: 2,
            color: Color(0xffCFCFCF),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
          width: 110.0,
          height: 30.0,
          color: Colors.white,
          child: Text(
            "보호자 연락처",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffCFCFCF),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ), //보호자프로필
        Container(
          margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 50.0),
          child: Row(
            children: [
              SizedBox(
                width: 65.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "번호",
                    style: TextStyle(
                        color: Color(0xffCFCFCF), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    width: 230,
                    height: 32,
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                    margin: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                      color: Color(0xffd9d9d9).withOpacity(0.3),
                      border: Border.all(
                        width: 2,
                        color: Color(0xffCFCFCF),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      emergency,
                      style: TextStyle(
                          color: Color(0xffCFCFCF),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        )
        //보호자 프로필
      ]),
    );
  }
}

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer(); //동기화를 보장, wirte를 호출하여 기존에 문자열추가
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); //문자열 추가
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }
    var string = buffer.toString(); //버퍼의 내용을 문자열로 만들기위함
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
