import 'package:bluestack_apk/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTile(
        title: Text("LogOut!!!"),
        onTap: () async {
          final spref = await SharedPreferences.getInstance();
          spref.remove('userInfo');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
        },
      ),
    );
  }
}
