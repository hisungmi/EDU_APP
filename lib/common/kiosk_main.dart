import 'package:flutter/material.dart';

class KioskMain extends StatefulWidget {
  const KioskMain({Key? key}) : super(key: key);

  @override
  State<KioskMain> createState() => KioskMainState();
}

class KioskMainState extends State<KioskMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text(
      '키오스크 페이지입니다',
    ));
  }
}
