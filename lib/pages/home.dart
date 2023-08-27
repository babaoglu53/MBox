import 'package:mbox/common/common.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var pages = const [
    MyMoneyBoxes(),
    QRRead(),
    Profile(
      user: User(name: "Ahmet", user_id: "123456789"),
    )
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.money_rounded),
            label: 'Kumbaralarım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Kod Okut',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profilim',
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: const Color.fromARGB(255, 11, 169, 180),
        unselectedItemColor: Colors.black26,
        iconSize: 30,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
