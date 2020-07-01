import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_event.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_state.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/general_response.dart';
import 'package:whatsappcloneflutter/models/user_details_model.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState>
    with Functionality {
  @override
  UserProfileState get initialState => InitialState();

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is FetchUserDetailsEvent) {
      yield LoadingState();
      UserDetailsModel userDetailsModel = await DioServices.getUserDetails();
      if (isValidObject(userDetailsModel) &&
          isValidString(userDetailsModel.status)) {
        if (userDetailsModel.status == "1" &&
            isValidObject(userDetailsModel.data)) {
          yield LoadedState(userDetailsModel.data);
        } else if (userDetailsModel.status == "internetError") {
          yield NoInternetState();
        } else {
          yield ErrorState();
        }
      } else {
        yield ErrorState();
      }
    } else if (event is UpdateNameEvent) {
      UserDetails userDetails;
      if (state is LoadedState) {
        userDetails = (state as LoadedState).userDetails;
      }
      yield NameLoadingState();
      GeneralResponse generalResponse = await DioServices.updateName(event.name);
      add(FetchUserDetailsEvent());
    }
  }
}
