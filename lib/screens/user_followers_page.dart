import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nitor_machine_test/data/model/user.dart';
import 'package:http/http.dart' as http;

/*
Note - Currently showing only followers list on both the tabs 
*/

class UsersFollowersPage extends StatefulWidget {
  static const String route = '/userFollowers';
  final User user;
  UsersFollowersPage({Key key, this.user}) : super(key: key);

  @override
  _UsersFollowersPageState createState() => _UsersFollowersPageState(user);
}

class _UsersFollowersPageState extends State<UsersFollowersPage> {
  User user;
  _UsersFollowersPageState(this.user);
  
  
  Future<List<User>> _getUserFollowers() async {
    var response = await http.get(user.followerUrl);
    if (response.statusCode == 200) {
      List userData;
      List<User> mList = [];
       userData = json.decode(response.body);
      for (var obj in userData) {
        User users = new User();
        users.id = obj['id'];
        users.name = obj['login'];
        users.imgUrl = obj['avatar_url'];
        mList.add(users);
      }
      return mList;
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(user.fullName),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                height: 48.0,
                padding: EdgeInsets.only(top: 8.0),
                color: Colors.white,
                child: TabBar(
                    indicatorColor: Colors.purple,
                    labelColor: Colors.black,
                    tabs: <Widget>[Text("Following"), Text("Followers")]),
              ),
            )),
        body: TabBarView(children: <Widget>[
          SafeArea(
              child: FutureBuilder(
            future: _getUserFollowers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      followersListWidget(snapshot.data[index]),
                      Divider(color: Colors.black12,height: 1,)
                    ],
                  );
                },
              );
            },
          )),
          SafeArea(
              child: FutureBuilder(
            future: _getUserFollowers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      followersListWidget(snapshot.data[index]),
                      Divider(color: Colors.black12,height: 1,)
                    ],
                  );
                },
              );
            },
          )),
        ]),
      ),
    );
  }
}


Widget followersListWidget(User users) {
  return InkWell(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 20.0,
        ),
        CircleAvatar(
          radius: 24.0,
          child: ClipOval(
            child: Image.network(
              users.imgUrl,
              fit: BoxFit.fill,
              height: 50.0,
              width: 50.0,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              users.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text('id:' + users.id.toString()),
          ],
        )
      ],
    ),
  ));
}
