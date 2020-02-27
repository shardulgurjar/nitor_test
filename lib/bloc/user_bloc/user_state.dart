import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:nitor_machine_test/data/model/user.dart';


abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {

  List<User> users;

  UserLoadedState({@required this.users});

  @override
  List<Object> get props => [users];
}

class UserErrorState extends UserState {

  String message;

  UserErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}