import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitor_machine_test/data/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:nitor_machine_test/screens/user_followers_page.dart';

class UserInfoPage extends StatefulWidget {
  static const String route = '/userInfo';

  final User user;

  UserInfoPage({Key key, this.user}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState(user);
}

class _UserInfoPageState extends State<UserInfoPage> {
  User user;
  _UserInfoPageState(this.user);
  Future<User> _getUserDetails() async {
    var response = await http.get(user.profileUrl);
    var jsondata = json.decode(response.body);
    print(jsondata.toString());
    String bio = jsondata['bio'] == null ? "No Bio" : jsondata['bio'];
    String location =
        jsondata['location'] == null ? "No location" : jsondata['location'];
    User users = new User();
    users.imgUrl = jsondata['avatar_url'];
    users.location = location;
    users.bio = bio;
    users.publicGists = jsondata['public_gists'];
    users.publicRepos = jsondata['public_repos'];
    users.followerCount = jsondata["followers"];
    users.followingCount = jsondata["following"];
    user.followerUrl = jsondata['followers_url'];
    DateTime date = DateTime.parse(jsondata["updated_at"]);
    var year = date.year;
    var month = date.month;
    var day = date.day;
    var hour = date.hour;
    var min = date.minute;
    users.updatedAt = hour.toString() +
        ":" +
        min.toString() +
        " on " +
        day.toString() +
        "/" +
        month.toString() +
        "/" +
        year.toString();
    users.fullName = jsondata["name"];
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                CupertinoIcons.share,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () {})
        ],
      ),
      body: SafeArea(
          child: Container(
              child: FutureBuilder(
                  future: _getUserDetails(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return userDetailsCard(context, snapshot.data);
                  }))),
    );
  }
}

Widget userDetailsCard(BuildContext context, User user) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, UsersFollowersPage.route, arguments: user);
      },
      child: Card(
        color: Colors.blueGrey.shade50,
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            ClipOval(
              child: Image.network(
                user.imgUrl,
                fit: BoxFit.fill,
                height: 130.0,
                width: 130.0,
              ),
            ),
            Text(
              user.fullName,
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Alatsi'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_on),
                Text(
                  user.location,
                ),
              ],
            ),
            follow(user.followers, user.following),
            userBioCard(user),
          ],
        ),
      ),
    ),
  );
}

Widget follow(int follower, int following) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("$follower Followers",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          width: 5.0,
        ),
        Text(
          "|",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5.0,
        ),
        Text("$following Following",
            style: TextStyle(fontWeight: FontWeight.bold))
      ],
    ),
  );
}

Widget userBioCard(User user) {
  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        userDetailTile("Bio:", user.bio),
        Divider(
          color: Colors.black12,
          height: 1,
        ),
        userDetailTile("Public Repository:", user.publicRepos.toString()),
        Divider(
          color: Colors.black12,
          height: 1,
        ),
        userDetailTile("Public Gists:", user.publicGists.toString()),
        Divider(
          color: Colors.black12,
          height: 1,
        ),
        userDetailTile("Updated At:", user.updatedAt)
      ],
    ),
  );
}

Widget userDetailTile(String _title, String _subtitle) {
  return ListTile(
    dense: true,
    title: Text(_title),
    subtitle: Text(_subtitle),
  );
}
