import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nitor_machine_test/data/model/user.dart';
import 'package:nitor_machine_test/data/repository/user_repository.dart';
import 'package:nitor_machine_test/res/app_strings.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<List<User>> getAllSearchedUsers(String name) async {
    List<User> userList = new List();
    var response = await http.get("https://api.github.com/search/users?q="+ name);
    if(response.statusCode == 200){
      var searchedUser = json.decode(response.body);
      List searchedList = searchedUser["items"];
       for (var obj in searchedList) {
        User users = new User();
        users.id = obj['id'];
        users.imgUrl = obj['avatar_url'];
        users.score = obj['score'];
        users.name = obj['login'];
        users.profileUrl = obj['url'];
        userList.add(users);
      }
      return userList;
    }else{
      throw Exception();
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    List userData;
    List<User> userList = new List();
    var response = await http.get(AppString.URL_USERS);
    if (response.statusCode == 200) {
      userData = json.decode(response.body);
      for (var obj in userData) {
        User user = new User();
        user.id = obj['id'];
        user.imgUrl = obj['avatar_url'];
        user.profileUrl = obj['url'];
        user.name = obj['login'];
        userList.add(user);
      }
      return userList;
    } else {
      throw Exception();
    }
  }
  }

  

