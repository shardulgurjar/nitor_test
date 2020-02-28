import 'package:bloc/bloc.dart';
import 'package:nitor_machine_test/bloc/user_bloc/user_event.dart';
import 'package:nitor_machine_test/bloc/user_bloc/user_state.dart';
import 'package:nitor_machine_test/data/model/user.dart';
import 'package:nitor_machine_test/data/repository/user_repository.dart';


class UserBloc extends Bloc<UserEvent, UserState>{

  UserRepository userRepository;

  UserBloc({this.userRepository});

  @override
  UserState get initialState => UserInitialState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if(event is FetchUserEvent){
      yield  UserLoadingState();
      try{
        List<User> users = await userRepository.getAllUsers();
        yield UserLoadedState(users: users);
      }catch(e){
        yield UserErrorState(message: e.toString());
      }
    }else if (event is FetchUserSearchEvent){
      yield UserLoadingState();
      try{
        List<User> users = await userRepository.getAllSearchedUsers(event.name.toString());
        yield UserLoadedState(users: users);
      }catch(e){
        yield UserErrorState(message: e.toString());
      }
    }
  }
}