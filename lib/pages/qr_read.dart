import 'package:mbox/common/common.dart';

class QRRead extends StatefulWidget {
  const QRRead({Key? key}) : super(key: key);

  @override
  State<QRRead> createState() => _QRReadState();
}

class _QRReadState extends State<QRRead> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  QRViewController? controller;
  String result = "";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });

      controller.stopCamera();
      controller.dispose();
      openSavePage();
    });
  }

  Future<dynamic> openSavePage() async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.grey,
            height: 250,
            child: const Column(
              children: [
                ListTile(
                  title: Text("flutter"),
                  subtitle: Text("subscribe my youtube channel"),
                  trailing: Icon(Icons.code),
                ),
                ListTile(
                  title: Text("flutter"),
                  subtitle: Text("subscribe my youtube channel"),
                  trailing: Icon(Icons.code),
                ),
                ListTile(
                  title: Text("flutter"),
                  subtitle: Text("subscribe my youtube channel"),
                  trailing: Icon(Icons.code),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
            ),
          ],
        ),
      ),
    );
  }
}
