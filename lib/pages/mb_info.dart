import 'package:mbox/common/common.dart';

class MBInfo extends StatefulWidget {
  final MoneyBox mb;
  const MBInfo({super.key, required this.mb});

  @override
  State<MBInfo> createState() => _MBInfoState();
}

class _MBInfoState extends State<MBInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.mb.mb_id,
        ),
      ),
    );
  }
}
