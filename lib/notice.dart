import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.date,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  String date;
  bool isExpanded;
}

class _NoticeState extends State<Notice> {
  List<Item> dataa = [
    Item(
        headerValue: '시험기간3 입니다.',
        expandedValue:
            '시험기간3이 안끝났으니 가서 신나게 놀지마시길 바랍니다. \n 이게 적용이 되려나 나는 잘 모르겠네 \n 최대한 길게 쓰고싶은데 \n 쓸수 있을까 모르겠네',
        date: '2023/05/11 11:59'),
    Item(
        headerValue: '시험기간2 입니다.',
        expandedValue:
            '시험기간2이 안끝났으니 가서 신나게 놀지마시길 바랍니다. \n 이게 적용이 되려나 나는 잘 모르겠네 \n 최대한 길게 쓰고싶은데 \n 쓸수 있을까 모르겠네',
        date: '2023/05/05 11:59'),
    Item(
        headerValue: '시험기간1 입니다.',
        expandedValue:
            '시험기간1이 안끝났으니 가서 신나게 놀지마시길 바랍니다. \n 이게 적용이 되려나 나는 잘 모르겠네 \n 최대한 길게 쓰고싶은데 \n 쓸수 있을까 모르겠네',
        date: '2023/05/04 11:59'),
    Item(
        headerValue: '시험기간이 끝났습니다.',
        expandedValue:
            '여러분 드디어 시험 기간이 끝났습니다.\n 긴 기간 동안 고생 많으셨습니다.\n오늘 저녁은 맛있는 거 드세요!\n 시험 성적은 7월 방학 때 쯤 알려드리겠습니다.\n걱정말고 편하게 노세요.\n @학원 관리자 드림',
        date: '2023/05/01 11:59'),
  ];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공지사항',
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
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 2, color: Color(0xff9c9c9c)),
              )),
              child: Text.rich(TextSpan(children: const [
                TextSpan(
                    text: ('공지사항'), style: TextStyle(color: Color(0xff5a5a5a))),
                WidgetSpan(
                    child: SizedBox(
                  width: 2,
                )),
                WidgetSpan(
                  child: FaIcon(FontAwesomeIcons.bullhorn,
                      size: 20, color: Color(0xff5a5a5a)),
                )
              ])),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataa.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: dataa[index].isExpanded ? 0 : 1,
                                  color: Color(0xffc1c1c1)))),
                      child: ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 500),
                        elevation: 0,
                        dividerColor: Color(0xff9c9c9c),
                        expansionCallback: (int itemIndex, bool isExpanded) {
                          setState(() {
                            dataa[index].isExpanded = !isExpanded;
                          });
                        },
                        children: [
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Container(
                                child: ListTile(
                                  title: Text(dataa[index].headerValue,
                                      style: TextStyle(
                                          color: Color(0xff9c9c9c),
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                    child: Text(dataa[index].date,
                                        style: TextStyle(
                                            color: Color(0xff9c9c9c),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              );
                            },
                            body: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff6f6f6),
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: Color(0xff9c9c9c)))),
                              padding: EdgeInsets.all(20),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(dataa[index].expandedValue,
                                          style: TextStyle(
                                              color: Color(0xff9c9c9c))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            isExpanded: dataa[index].isExpanded,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
