import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitor_machine_test/bloc/user_bloc/user_bloc.dart';
import 'package:nitor_machine_test/bloc/user_bloc/user_event.dart';
import 'package:nitor_machine_test/bloc/user_bloc/user_state.dart';
import 'package:nitor_machine_test/data/model/user.dart';
import 'package:nitor_machine_test/screens/user_info_page.dart';

class HomePage extends StatefulWidget {
  static const String route = "/homePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc userBloc;
  String searchText;
  var _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FetchUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GitHub",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0, fontFamily: "Acme"),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            height: 48.0,
            child: searchBar(),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            child: BlocBuilder<UserBloc, UserState>(
                bloc: userBloc,
                builder: (context, state) {
                  if (state is UserInitialState) {
                    return buildLoading();
                  } else if (state is UserLoadingState) {
                    return buildLoading();
                  } else if (state is UserLoadedState) {
                    return buildUserList(state.users);
                  } else if (state is UserErrorState) {
                    return buildErrorUi(state.message);
                  }
                  return null;
                })),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0,top: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
        controller: _controller,
        onChanged: (text) {
          setState(() {
            searchText = text;
            userBloc.add(FetchUserSearchEvent(searchText));
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _controller.clear();
                    userBloc.add(FetchUserEvent());
                  });
                }),
            hintText: 'Enter a search term'),
      ),
    );
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

Widget buildUserList(List<User> users) {
  return ListView.separated(
    separatorBuilder: (BuildContext context, int index) => Divider(
      height: 1,
    ),
    itemCount: users.length,
    itemBuilder: (BuildContext context, int pos) {
      return Padding(
        padding: EdgeInsets.all(0.0),
        child: InkWell(
          child: ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 50.0,
              child: ClipOval(
                child: Image.network(
                  users[pos].imgUrl,
                  fit: BoxFit.fill,
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14.0,
            ),
            title: Text(
              users[pos].name,
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Alatsi'),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('id:' + users[pos].id.toString()),
                Spacer(),
                Text("Score:"),
                Spacer()
              ],
            ),
          ),
          onTap: () => Navigator.pushNamed(context, UserInfoPage.route,
              arguments: users[pos]),
        ),
      );
    },
  );
}
