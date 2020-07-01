import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_event.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_state.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/user_details_model.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';

class UserProfileBloc extends Bloc<UserProfileEvent,UserProfileState> with Functionality{
  @override
  UserProfileState get initialState => InitialState();

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async*{
    if(event is FetchUserDetailsEvent){
      yield LoadingState();
      UserDetailsModel userDetailsModel = await DioServices.getUserDetails();
      yield LoadedState(userDetailsModel.data);
    }
  }
  
}