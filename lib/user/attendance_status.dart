import 'package:edu_application_pre/user/class.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttendanceStatus extends StatefulWidget {
  AttendanceStatus({
    Key? key,
    required this.morning,
    required this.afternoon,
    required this.isAfternoon,
  }) : super(key: key);

  //MyData = 컬리브레이스를 가지고 있음 ->Key? , required가 붙어서 반드시 구현해야하는 알규먼트
  final Map<String, dynamic> morning;
  final Map<String, dynamic> afternoon;
  final bool isAfternoon;
  static const routeName = "/attendance";

  @override
  State<AttendanceStatus> createState() => _AttendanceStatusState();
}

class StateData {
  final String date;
  final String status;
  StateData(
    this.date,
    this.status,
  );

  StateData.fromMap(Map<String, dynamic> map)
      : date = map['date'],
        status = map['status'];
}

class _AttendanceStatusState extends State<AttendanceStatus> {
  final List<Map<String, String>> statuslist = [
    {'date': '03.15', 'status': '출석'},
    {'date': '03.14', 'status': '결석'},
    {'date': '03.13', 'status': '출석'},
    {'date': '03.12', 'status': '출석'},
    {'date': '03.11', 'status': '출석'},
    {'date': '03.10', 'status': '출석'},
    {'date': '03.09', 'status': '출석'},
    {'date': '03.08', 'status': '출석'},
    {'date': '03.07', 'status': '지각'},
    {'date': '03.06', 'status': '보류'},
    {'date': '03.05', 'status': '결석'},
    {'date': '03.04', 'status': '출석'},
    {'date': '03.03', 'status': '지각'},
    {'date': '03.02', 'status': '결석'},
    {'date': '03.01', 'status': '보류'},
  ];

  @override
  Widget build(BuildContext context) {
    Color morningtitlecolor =
        Color(int.parse('0xFF${widget.morning['color'].substring(1)}'));
    Color afternoontitlecolor =
        Color(int.parse('0xFF${widget.afternoon['color'].substring(1)}'));
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
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.isAfternoon == false
                  ? Container(
                      padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                      height: 35,
                      decoration: BoxDecoration(
                          color: morningtitlecolor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        widget.morning['lectureName'],
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
                          color: afternoontitlecolor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        widget.afternoon['lectureName'],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 78,
                    height: 29,
                    decoration: BoxDecoration(
                      color: Color(0xffEAEAEA),
                    ),
                    child: Center(
                        child: Text("날짜",
                            style: TextStyle(color: Color(0xff565656)))),
                  ),
                  Container(
                    width: 280,
                    height: 29,
                    decoration: BoxDecoration(
                      color: Color(0xffEAEAEA),
                    ),
                    child: Center(
                        child: Text("출석",
                            style: TextStyle(color: Color(0xff565656)))),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Expanded(
                //스크롤되게
                child: ListView.builder(
                  shrinkWrap: true, //스크롤되게
                  itemCount: statuslist.length,
                  itemBuilder: (context, index) {
                    String? status = statuslist[index]['status'];
                    String? date = statuslist[index]['date'];
                    Color bgColor = Colors.white;
                    Color textColor = Color(0xff565656);
                    Color bg2Color = Colors.white;
                    Color text2Color = Color(0xff565656);
                    Color bg3Color = Colors.white;
                    Color text3Color = Color(0xff565656);
                    Color bg4Color = Colors.white;
                    Color text4Color = Color(0xff565656);
                    if (status == '출석') {
                      textColor = Colors.white;
                      bgColor = Color(0xffA4CAF8);
                    }
                    if (status == '결석') {
                      text2Color = Colors.white;
                      bg2Color = Color(0xffFD9494);
                    }
                    if (status == '지각') {
                      text3Color = Colors.white;
                      bg3Color = Color(0xFFF4C784);
                    }
                    if (status == '보류') {
                      text4Color = Colors.white;
                      bg4Color = Color(0xffBBBBBB);
                    }
                    return Container(
                      width: 360,
                      height: 37,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 78,
                            height: 37,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  left: BorderSide(
                                      width: 2, color: Color(0xffeaeaea)),
                                  right: BorderSide(
                                      width: 1, color: Color(0xffeaeaea)),
                                  top: BorderSide(
                                      width: 1, color: Color(0xffeaeaea)),
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffeaeaea)),
                                )),
                            child: Center(
                                child: Text(date!,
                                    style: TextStyle(
                                      color: Color(0xff565656),
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ),
                          Container(
                            width: 70,
                            height: 37,
                            decoration: BoxDecoration(
                                color: bgColor,
                                border: Border.all(
                                    color: Color(0xffeaeaea), width: 1)),
                            child: Center(
                                child: Text("출석",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ),
                          Container(
                            width: 70,
                            height: 37,
                            decoration: BoxDecoration(
                                color: bg2Color,
                                border: Border.all(
                                    color: Color(0xffeaeaea), width: 1)),
                            child: Center(
                                child: Text("결석",
                                    style: TextStyle(
                                      color: text2Color,
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ),
                          Container(
                            width: 70,
                            height: 37,
                            decoration: BoxDecoration(
                                color: bg3Color,
                                border: Border.all(
                                    color: Color(0xffeaeaea), width: 1)),
                            child: Center(
                                child: Text("지각",
                                    style: TextStyle(
                                      color: text3Color,
                                      fontWeight: FontWeight.w500,
                                    ))),
                          ),
                          Container(
                              width: 70,
                              height: 37,
                              decoration: BoxDecoration(
                                  color: bg4Color,
                                  border: Border(
                                    left: BorderSide(
                                        width: 1, color: Color(0xffeaeaea)),
                                    right: BorderSide(
                                        width: 2, color: Color(0xffeaeaea)),
                                    top: BorderSide(
                                        width: 1, color: Color(0xffeaeaea)),
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffeaeaea)),
                                  )),
                              child: Center(
                                  child: Text("보류",
                                      style: TextStyle(
                                        color: text4Color,
                                        fontWeight: FontWeight.w500,
                                      )))),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
