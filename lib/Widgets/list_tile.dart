import 'package:flutter/material.dart';

class RecSecListTile extends StatelessWidget {
  String name;
  String gameName;
  String imageUrl;

  RecSecListTile(this.name, this.imageUrl, this.gameName);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      elevation: 8,
      child: Container(
        height: 180,
        child: Column(
          children: [
            Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                )),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 350,
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          gameName,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  IconButton(icon: Icon(Icons.navigate_next), onPressed: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
