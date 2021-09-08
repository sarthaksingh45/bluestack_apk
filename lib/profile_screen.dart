import 'package:bluestack_apk/Widgets/drawer.dart';
import 'package:bluestack_apk/Widgets/list_tile.dart';
import 'package:bluestack_apk/helpers/profile.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './data_helper.dart';

class ProfileSection extends StatefulWidget {
  String userName;

  ProfileSection(this.userName);
  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

Future<ProfileData> fetchProfile(String userName) async {
  String sentUser;
  if (userName == "9898989898") {
    sentUser = "userdetails1";
  } else {
    sentUser = "userdetails2";
  }
  final response = await http.get(Uri.parse(
      "https://048a4050-01cd-4d39-b312-67588a2ebe70.mock.pstmn.io//$sentUser"));

  if (response.statusCode == 200) {
    return ProfileData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failedddddddd!!!!');
  }
}

Future<List<RecData>> fetchData() async {
  //print("Yes we made it");
  final response = await http.get(Uri.parse(
      "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all"));
  //print("Function");
  List<RecData> comingData = [];
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    //print("response DAta isssssss" + responseData.toString());
    final fetchedData = responseData['data']['tournaments'] as List<dynamic>;
    //print("Fetched Data isssssssssss" + fetchedData.toString());
    fetchedData.forEach((element) {
      //print("1St                          " + element.toString());
      comingData.add(
          RecData(element['name'], element['cover_url'], element['game_name']));
    });
  } else {
    print("Error Occured");
  }
  print('Coming DAta ' + comingData[0].gameName);
  return comingData;
}

class _ProfileSectionState extends State<ProfileSection> {
  Future<List<RecData>> _myfuture;

  @override
  void initState() {
    super.initState();
    //print("INitStare");
    _myfuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

    final deviceSize = MediaQuery.of(context).size;
    return FutureBuilder<ProfileData>(
        future: fetchProfile(widget.userName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              key: _scaffoldState,
              drawer: AppDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: deviceSize.width,
                      height: 100,
                      //width: double.infinity,
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.notes_sharp),
                              onPressed: () {
                                _scaffoldState.currentState.openDrawer();
                              }),
                          Expanded(
                            child: Container(
                              child: Text(
                                snapshot.data.gameId,
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      //width: double.infinity,
                      //width: deviceSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data.imageUrl),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 150,
                            width: 20,
                          ),
                          Container(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data.name,
                                  style: TextStyle(fontSize: 23),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blue, width: 3),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                        snapshot.data.elo.toString() +
                                            " elo rating",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 130,
                        child: Expanded(
                            child: Row(
                          children: [
                            Container(
                              height: 130,
                              width: (deviceSize.width - 20) / 3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.orange[800],
                                      Colors.orange[200]
                                    ]),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data.played.toString() +
                                      " \ntotal matches played",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 130,
                              width: (deviceSize.width - 20) / 3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.deepPurple[900],
                                      Colors.deepPurple[200]
                                    ]),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data.won.toString() +
                                      " \nmatches won",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 130,
                              width: (deviceSize.width - 20) / 3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.deepOrange[800],
                                      Colors.amber[400]
                                    ]),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data.played.toString() +
                                      " \npercentage winrate",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: deviceSize.width,
                        child: Text(
                          "Recommended for You",
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 600,
                        child: FutureBuilder<List<RecData>>(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemBuilder: (ctx, i) {
                                    return RecSecListTile(
                                        snapshot.data[i].name,
                                        snapshot.data[i].imageUrl,
                                        snapshot.data[i].gameName);
                                  },
                                  itemCount: snapshot.data.length);
                            }

                            return Center(
                              child: Text("NOpe"),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Center(child: CircularProgressIndicator()));
        });
  }
}
