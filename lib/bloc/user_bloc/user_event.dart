import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{}

class FetchUserEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FetchUserSearchEvent extends UserEvent{
  
  final String name;
  FetchUserSearchEvent(this.name);
  
  @override
  List<Object> get props => [name];
  
}