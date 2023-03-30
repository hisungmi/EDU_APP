import 'package:edu_application_pre/user/class.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttendanceStatus extends StatelessWidget {
  const AttendanceStatus({
    Key? key,
    required this.morning,
    required this.evening,
    required this.isAfternoon,
  }) : super(key: key);

  //컬리브레이스를 가지고 있음 ->Key? , required가 붙어서 반드시 구현해야하는 알규먼트
  final MyData morning;
  final MyData evening;
  final bool isAfternoon;
  static const routeName = "/attendance";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0099FF),
        toolbarHeight: 70,
        elevation: 0.0, //앱바 입체감 없애기
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isAfternoon == false
                  ? Container(
                      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      height: 35,
                      decoration: BoxDecoration(
                          color: Color(0xff0099ee),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10),
                          )),
                      child: Text(
                        morning.lectureName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      height: 35,
                      decoration: BoxDecoration(
                          color: Color(0xff0099ee),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10),
                          )),
                      child: Text(
                        evening.lectureName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
