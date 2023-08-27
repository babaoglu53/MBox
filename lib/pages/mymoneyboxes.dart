import 'package:mbox/common/common.dart';

class MyMoneyBoxes extends StatefulWidget {
  const MyMoneyBoxes({Key? key}) : super(key: key);

  @override
  State<MyMoneyBoxes> createState() => _MyMoneyBoxesState();
}

class _MyMoneyBoxesState extends State<MyMoneyBoxes> {
  List<MoneyBox> mboxes = [
    const MoneyBox(
      mb_id: "ST331525",
      responsible_id: "ST251533",
    ),
    const MoneyBox(
      mb_id: "ST331534",
      responsible_id: "ST251533",
    ),
    const MoneyBox(
      mb_id: "ST331576",
      responsible_id: "ST251533",
    ),
    const MoneyBox(
      mb_id: "ST331590",
      responsible_id: "ST251533",
    ),
    const MoneyBox(
      mb_id: "ST331534",
      responsible_id: "ST251533",
    ),
  ];

  goToSavePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddMB()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: mboxes.length,
        itemBuilder: (context, index) {
          final mbox = mboxes[index];
          return Card(
            child: ListTile(
              title: Text(mbox.mb_id),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MBInfo(mb: mbox),
                ));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToSavePage(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
