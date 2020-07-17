import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_event.dart';
import 'package:whatsappcloneflutter/blocs/user_list_bloc/user_list_state.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/contact_list_model.dart';
import 'package:whatsappcloneflutter/models/user_list_model.dart';
import 'package:whatsappcloneflutter/services/dio_services.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState>
    with Functionality {
  @override
  UserListState get initialState => InitialState();

  @override
  Stream<UserListState> mapEventToState(UserListEvent event) async* {
    if (event is PermissionEvent) {
      if (event.permissionStatus == PermissionStatus.granted) {
        yield LoadingState();
        Iterable<Contact> contactList = await ContactsService.getContacts(
            withThumbnails: false,
            photoHighResolution: false,
            orderByGivenName: false,
            iOSLocalizedLabels: false);

        List<ContactListModel> list = List();
        for (var item in contactList) {
          if (isValidObject(item)) {
            String displayName = "";
            if (isValidString(item.displayName)) {
              displayName = item.displayName;
            }
            if (isValidList(item.phones.toList())) {
              for (var item in item.phones.toList()) {
                if (isValidString(item.value)) {
                  var replacedMobile =
                      item.value.replaceAll(" ", "").replaceAll("+", "");
                  list.add(ContactListModel(
                      name: displayName, mobile: replacedMobile));
                }
              }
            }
          }
        }

        UserListModel response = await DioServices.getUserList(list);
        if (isValidObject(response) &&
            isValidString(response.status) &&
            response.status == "1") {
          yield LoadedState(response.userModel);
        } else {
          yield LoadedState(null);
        }
      } else {
        yield RequiredPermissionState();
      }
    }
  }
}
