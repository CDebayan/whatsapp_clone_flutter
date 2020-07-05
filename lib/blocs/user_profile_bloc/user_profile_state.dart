import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsappcloneflutter/models/user_details_model.dart';

abstract class UserProfileState extends Equatable {
  final bool isImageLoading;
  final bool isNameLoading;
  final bool isAboutLoading;
  final UserDetails userDetails;

  const UserProfileState(
    this.isImageLoading,
    this.isNameLoading,
    this.isAboutLoading,
    this.userDetails,
  );

  @override
  List<Object> get props =>
      [isImageLoading, isNameLoading, isAboutLoading, userDetails];
}

class Loading extends UserProfileState {
  Loading({
    bool isImageLoading = true,
    bool isNameLoading = true,
    bool isAboutLoading = true,
    UserDetails userDetails,
  }) : super(isImageLoading, isNameLoading, isAboutLoading, userDetails);
}

class Loaded extends UserProfileState {
  Loaded({
    bool isImageLoading = false,
    bool isNameLoading = false,
    bool isAboutLoading = false,
    @required UserDetails userDetails,
  }) : super(isImageLoading, isNameLoading, isAboutLoading, userDetails);
}

class NoInternet extends UserProfileState {
  NoInternet({
    bool isImageLoading = false,
    bool isNameLoading = false,
    bool isAboutLoading = false,
    UserDetails userDetails,
  }) : super(isImageLoading, isNameLoading, isAboutLoading, userDetails);

}
