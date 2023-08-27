import 'package:mbox/common/common.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              radius: 50,
              child: Icon(
                Icons.person,
                color: Color(0xffCCCCCC),
                size: 50,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(widget.user.name),
            Text(widget.user.user_id),
          ],
        ),
      ),
    );
  }
}
