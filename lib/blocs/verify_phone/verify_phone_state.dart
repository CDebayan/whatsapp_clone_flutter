import 'package:equatable/equatable.dart';

abstract class VerifyPhoneState extends Equatable{
  const VerifyPhoneState();
}

class InitialState extends VerifyPhoneState{
  const InitialState();
  @override
  List<Object> get props => [];
}

class VerifyingState extends VerifyPhoneState{
  const VerifyingState();
  @override
  List<Object> get props => [];
}

class InvalidOtpState extends VerifyPhoneState{
  const InvalidOtpState();
  @override
  List<Object> get props => [];
}