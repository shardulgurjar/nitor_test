import 'package:nitor_machine_test/data/model/user.dart';

abstract class UserRepository{

  //Return All users 
  Future<List<User>> getAllUsers();
  
  //Return the searched user list 
  Future<List<User>> getAllSearchedUsers(String name);

}