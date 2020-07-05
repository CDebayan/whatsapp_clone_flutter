import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_event.dart';
import 'package:whatsappcloneflutter/blocs/user_profile_bloc/user_profile_state.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/user_details_model.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState>
    with Functionality {
  @override
  UserProfileState get initialState => Loading();

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is FetchUserDetails) {
      yield* _mapFetchUserDetailsToState();
    } else if (event is UpdateNameEvent) {
      yield* _mapUpdateNameToState(event);
    } else if (event is UpdateAboutEvent) {
      yield* _mapUpdateAboutToState(event);
    }
  }

  Stream<UserProfileState> _mapFetchUserDetailsToState() async* {
    yield Loading();
    UserDetailsModel userDetailsModel = await DioServices.getUserDetails();
    yield* _validateUserDetails(userDetailsModel);
  }

  Stream<UserProfileState> _validateUserDetails(
      UserDetailsModel userDetailsModel) async* {
    if (isValidObject(userDetailsModel) &&
        isValidString(userDetailsModel.status)) {
      if (userDetailsModel.status == "1" &&
          isValidObject(userDetailsModel.data)) {
        yield Loaded(userDetails: userDetailsModel.data);
      } else if (userDetailsModel.status == "internetError") {
        yield NoInternet();
      } else {
        yield Loaded(userDetails: null);
      }
    } else {
      yield Loaded(userDetails: null);
    }
  }

  Stream<UserProfileState> _mapUpdateNameToState(UpdateNameEvent event) async* {
    UserDetails userDetails;
    if (state is Loaded) {
      userDetails = (state as Loaded).userDetails;
    }
    yield Loading(isImageLoading: false,isNameLoading: true,isAboutLoading: false,userDetails: userDetails);
    UserDetailsModel userDetailsModel = await DioServices.updateName(event.name);
    yield* _validateUserDetails(userDetailsModel);
  }

  Stream<UserProfileState> _mapUpdateAboutToState(UpdateAboutEvent event) async* {
    UserDetails userDetails;
    if (state is Loaded) {
      userDetails = (state as Loaded).userDetails;
    }
    yield Loading(isImageLoading: false,isNameLoading: false,isAboutLoading: true,userDetails: userDetails);
    UserDetailsModel userDetailsModel = await DioServices.updateAbout(event.about);
    yield* _validateUserDetails(userDetailsModel);
  }
}
