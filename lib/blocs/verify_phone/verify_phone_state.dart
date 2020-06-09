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

class VerifiedState extends VerifyPhoneState{
  const VerifiedState();
  @override
  List<Object> get props => [];
}

class VerificationFailedState extends VerifyPhoneState{
  const VerificationFailedState();
  @override
  List<Object> get props => [];
}

class InvalidOtpState extends VerifyPhoneState{
  const InvalidOtpState();
  @override
  List<Object> get props => [];
}