import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable{
  const UserProfileEvent();
}

class FetchUserDetails extends UserProfileEvent{
  const FetchUserDetails();
  @override
  List<Object> get props => [];
}

class UpdateName extends UserProfileEvent{
  final String name;
  const UpdateName(this.name);
  @override
  List<Object> get props => [name];
}

class UpdateAbout extends UserProfileEvent{
  final String about;
  const UpdateAbout(this.about);
  @override
  List<Object> get props => [about];
}

class UpdateProfileImage extends UserProfileEvent{
  final File image;
  const UpdateProfileImage(this.image);
  @override
  List<Object> get props => [image];
}

class RemoveProfileImage extends UserProfileEvent{
  const RemoveProfileImage();
  @override
  List<Object> get props => [];
}