import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:edu_application_pre/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // Future<void> confirmation(BuildContext context) async {
  // }

  // Future<void> attendCheck(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userData = prefs.getString('userData');
  //   Map<dynamic, dynamic> dataMap = {};
  //
  //   if (userData != null) {
  //     dataMap = jsonDecode(userData);
  //   }
  //
  //   bool? confirmed = await confirmation(context);
  //   final qrAttendListProvider =
  //       Provider.of<AttendProvider>(context, listen: false);
  //
  //   if (confirmed == true && qrAttendListProvider.qrAttendList.isEmpty) {
  //     var data = {
  //       'studentKey': dataMap['studentKey'],
  //       'state': '출석',
  //     };
  //
  //     qrAttendListProvider.setAttendList(data);
  //     print(qrAttendListProvider.setAttendList);
  //
  //     Navigator.pop(context, true);
  //   } else {
  //     // 취소를 누르면 알림창 닫기
  //     Navigator.pop(context, false); // 추가된 코드: 알림창 닫기
  //     return;
  //   }
  // }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff0099ff))),
        centerTitle: true,
        // 텍스트 중앙 정렬
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.home),
          color: Color(0xff0099ff),
          iconSize: 30,
          onPressed: () {
            int desiredIndex = 0; // 2번째 인덱스로 이동하려면 1로 설정
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MyHomePage(desiredIndex),
              ),
              (route) => false,
            );
          },
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8E8).withOpacity(0.8),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        toolbarHeight: 80,
        elevation: 4.0,
        //앱바 입체감 없애기
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            color: Color(0xff0099ff),
            iconSize: 35,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('QR을 스캔하세요.'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 300.0
    //     : 300.0;
    var scanArea = 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Consumer<AttendProvider>(builder: (context, attendProvider, child) {
      return Column(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
          Center(
            child: (result != null)
                ? ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? userData = prefs.getString('userData');
                      Map<dynamic, dynamic> dataMap = {};

                      if (userData != null) {
                        dataMap = jsonDecode(userData);
                      }

                      var data = {
                        'studentKey': dataMap['studentKey'],
                        'state': '출석',
                      };

                      if (attendProvider.qrAttendList.isEmpty) {
                        attendProvider.setAttendList(data);
                        print(attendProvider.qrAttendList);
                      }
                    },
                    child: Text('출석 체크'),
                  )
                : Text('Scan a code'),
          ),
        ],
      );
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
