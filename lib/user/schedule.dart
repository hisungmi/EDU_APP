import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  bool isAfternoon = true;
  double kFirstColumnHeight = 20;
  double kBoxSize = 52;
  List week = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    int kColumnLength = isAfternoon ? 24 : 16;
    List<Widget> builDayColumn(int index) {
      return [
        //높이가 부모와 동일한 회색 수직 선
        const VerticalDivider(
          color: Colors.grey,
          width: 0,
        ),
        //확장 가능한 공간을 만들수 있음, 부모위젯 내에서 사용시 자식위젯들 사이에서 사용가능한 모든 공간을 차지하도록 확장됨, flex로 확장 가능정도를 지정할 수 있음.
        Expanded(
          flex: 7, //해당 Expanded위젯은 부모위젯 내에서 7등분이 공간을 차지함
          //Stack : column위젯과 겹치지 않는 container, position 위젯을 자식으로 가질수 있음
          //여러개의 자식 위젯을 세로로 배치
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Text(
                      week[index],
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  //List.generate() 함수는 첫 번째 인자로 전달한 수만큼 인덱스를 생성하고, 두 번째 인자로 전달한 함수를 이용하여 해당 인덱스의 값으로 구성된 리스트를 생성
                  //스프레드 연산자 ... 는 리스트나 맵ㅇ르 펼쳐서 다른 리스트나 맵에 추가함,
                  ...List.generate(
                    kColumnLength,
                    (index) {
                      //짝수인 경우선위젯, 홀수인 경우 container.
                      if (index % 2 == 0) {
                        return Divider(
                          color: Colors.grey,
                          height: 0,
                        );
                      }
                      //return : 함수내에서 값을 반환할떄, list.generate 함수는 리스트를 생성하여 반환하기에 return 키워드를 씀
                      return SizedBox(
                        height: kBoxSize,
                        child: Container(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ];
    }

    List<Widget> buildTimeColumn(int index) {
      return [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              SizedBox(
                height: kFirstColumnHeight,
                width: kFirstColumnHeight,
              ),
              ...List.generate(
                kColumnLength,
                (index) {
                  if (index % 2 == 0) {
                    return const Divider(
                      color: Colors.grey,
                      height: 0,
                    );
                  }
                  return SizedBox(
                    height: kBoxSize,
                    child: Center(
                        child: isAfternoon
                            ? Text('${index ~/ 2 + 13}',
                                style: TextStyle(fontSize: 14))
                            : Text('${index ~/ 2 + 5}',
                                style: TextStyle(fontSize: 14))),
                  );
                },
              ),
            ],
          ),
        )
      ];
    }

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
                      height: isAfternoon
                          ? kColumnLength / 2 * kBoxSize + kColumnLength
                          : kColumnLength / 2 * kBoxSize + kColumnLength + 6,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // Column(
                          //   children: [
                          //     SizedBox(
                          //       height: 20,
                          //     ),
                          //     Expanded(
                          //       child: Container(
                          //         width: 20,
                          //         height: kColumnLength / 2 * kBoxSize +
                          //             kColumnLength,
                          //         child: ListView.builder(
                          //           shrinkWrap: true,
                          //           itemCount: 24,
                          //           itemBuilder: (context, index) {
                          //             //isEven : index가 짝수인 경우 true를 반환
                          //             if (index.isEven) {
                          //               return Divider(
                          //                 color: Colors.grey,
                          //                 height: 0,
                          //               );
                          //             }
                          //             return SizedBox(
                          //               height: kBoxSize,
                          //               child: Center(
                          //                 child: Text('${index ~/ 2 + 13}',
                          //                     style: TextStyle(fontSize: 14)),
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          ...buildTimeColumn(0),
                          //spread operator(...)를 사용
                          ...builDayColumn(0),
                          ...builDayColumn(1),
                          ...builDayColumn(2),
                          ...builDayColumn(3),
                          ...builDayColumn(4),
                          ...builDayColumn(5),
                          ...builDayColumn(6),
                        ],
                      )),
                ],
              ),
            )));
  }
}
