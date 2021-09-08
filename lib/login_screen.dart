import 'package:bluestack_apk/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data == "9898989898" ||
              snapshot.data == "9876543210") {
            return ProfileSection(snapshot.data);
          }

          return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                      0.9,
                    ],
                    colors: [
                      Colors.yellow,
                      Colors.red,
                      Colors.indigo,
                      Colors.teal,
                    ],
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CustomCard()],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

Future<String> autoLogin() async {
  final spref = await SharedPreferences.getInstance();
  if (!spref.containsKey('userInfo')) {
    return null;
  }
  String userId = spref.getString('userInfo');
  return userId;
}

class CustomCard extends StatefulWidget {
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String userId;
  bool _isButtonDisabled = false;
  String pass;

  Future<void> Submit(String userId, String password) async {
    final spref = await SharedPreferences.getInstance();

    if (userId == "9898989898" && password == "password123") {
      spref.setString('userInfo', userId);
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => ProfileSection(userId)));
    } else if (userId == "9876543210" && password == "password123") {
      spref.setString('userInfo', userId);
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => ProfileSection(userId)));
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
      return;
    }
  }

  final _formKey = GlobalKey<FormState>();

  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Container(
              height: 150,
              child: Image.asset('assets/game-tv.png'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'User ID'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.length < 3 || value.length > 11) {
                  return 'UserId should be of length 3 to 11';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              onChanged: (value) {
                setState(() {
                  _isButtonDisabled = false;
                });
              },
              onSaved: (value) {
                userId = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              focusNode: _passwordFocusNode,
              validator: (value) {
                if (value.length > 11 || value.length < 3) {
                  return 'Password should in length 3 to 11';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _isButtonDisabled = false;
                });
              },
              onSaved: (value) {
                pass = value;
              },
            ),
            SizedBox(
              height: 8,
            ),
            _isButtonDisabled
                ? TextButton(
                    child: Text("Submit"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: () {},
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Wrong User ID or Password"),
                          backgroundColor: Colors.red,
                        ));
                        setState(() {
                          _isButtonDisabled = true;
                        });
                        return;
                      }
                      _formKey.currentState.save();
                      Submit(userId, pass);
                    },
                    child: Text("Submit"))
          ]),
        )),
      ),
    );
  }
}
