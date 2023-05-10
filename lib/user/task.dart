import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Map<String, String>> data = [
    {
      'title': '연습문제 1',
      'date': '마감 5월 16일',
    },
    {
      'title': '연습문제 2',
      'date': '마감 5월 18일',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff0099FF),
          toolbarHeight: 70,
          elevation: 0.0, //앱바 입체감 없애기
          title: Center(
            child: Text(
              '과제',
              textAlign: TextAlign.center,
            ),
          ),
          leading: Container(
            child: IconButton(
              icon: FaIcon(FontAwesomeIcons.angleLeft),
              color: Colors.white,
              onPressed: () {
                //현재 페이지를 스택에서 제거하고 이전 페이지로 돌아감
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            //title 센터 주려고 넣음
            Container(
              width: 60,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 35,
                color: Color(0xff9c9c9c),
                child: Center(
                  child: Text('수능수학',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            // padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xff9c9c9c)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.library_books,
                                        size: 32,
                                        color: Color(0xffA9A9A9),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text.rich(TextSpan(children: [
                                            TextSpan(
                                              text: '연습문제 2 \n',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                                text: '마감 5월 16일 11:59',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ))
                                          ])),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(
                                  FontAwesomeIcons.angleRight,
                                  size: 28.0,
                                  color: Color(0xffA9A9A9),
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}
