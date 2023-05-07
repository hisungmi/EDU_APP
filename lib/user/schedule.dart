import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

bool isAfternoon = true;
List week = ['월', '화', '수', '목', '금'];
var kColumnLength = 22;
double kFirstColumnHeight = 20;
double kBoxSize = 42;

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (route) => false);
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
        body: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      isAfternoon
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  isAfternoon = false;
                                });
                              },
                              child: Container(
                                width: 65.57,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(12),
                                    ),
                                    border: Border.all(
                                      color: Color(0xff9c9c9c),
                                    )),
                                child: Center(
                                    child: Text(
                                  "오전",
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            )
                          : Container(
                              width: 65.57,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xff0099ee),
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color: Color(0xff0099ee),
                                  )),
                              child: Center(
                                child: Text(
                                  "오전",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                      isAfternoon
                          ? Container(
                              width: 65.57,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xff0099ee),
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color: Color(0xff0099ee),
                                  )),
                              child: Center(
                                child: Text(
                                  "오후",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isAfternoon = true;
                                });
                              },
                              child: Container(
                                width: 65.57,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(12),
                                    ),
                                    border: Border.all(
                                      color: Color(0xff9c9c9c),
                                    )),
                                child: Center(
                                    child: Text(
                                  "오후",
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: kColumnLength / 2 * kBoxSize + kColumnLength,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Container(
                                  width: 30,
                                  height: kColumnLength / 2 * kBoxSize +
                                      kColumnLength,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 24,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index.isEven) {
                                        return Divider(
                                          color: Colors.grey,
                                          height: 0,
                                        );
                                      }
                                      return SizedBox(
                                        height: kBoxSize,
                                        child: Center(
                                          child: Text('${index ~/ 2 + 13}'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            )));
  }
}
