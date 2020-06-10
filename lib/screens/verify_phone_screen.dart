import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappcloneflutter/blocs/verify_phone/verify_phone_bloc.dart';
import 'package:whatsappcloneflutter/blocs/verify_phone/verify_phone_event.dart';
import 'package:whatsappcloneflutter/blocs/verify_phone/verify_phone_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/models/text_span_model.dart';
import 'package:whatsappcloneflutter/screens/dashboard_screen.dart';
import 'package:whatsappcloneflutter/widgets/otp_pin.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class VerifyPhoneScreen extends StatelessWidget {
  static const String routeName = "VerifyPhoneScreen";
  final TextEditingController _otpController = TextEditingController();
  static BuildContext _context;
  static String _countryCode;
  static String _mobileNo;

  @override
  Widget build(BuildContext context) {
    String args = ModalRoute.of(context).settings.arguments;
    var splitValue = args.split(" ");
    _countryCode =  splitValue[0];
    _mobileNo =  splitValue[1];

    _otpController.addListener(() {
      String _otp = _otpController.text.toString().trim();
      if (_otp.length == 6) {
        _blocInstance().add(ValidateOtpEvent(countryCode: _countryCode,mobileNo: _mobileNo,otp: _otp));
      }
    });

    return BlocProvider(
      create: (_) => VerifyPhoneBloc(),
      child: Builder(builder: (context) {
        _context = context;
        return Scaffold(
          appBar: transparentAppBar(title: "Verify +$_countryCode $_mobileNo"),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: BlocConsumer<VerifyPhoneBloc, VerifyPhoneState>(
                    builder: (context, state) {
                  return Column(
                    children: <Widget>[
                      LinkText(_textList()),
                      OtpPin(_otpController),
                      Text(
                        "Enter 6-digit code",
                        style: TextStyle(color: Constants.colorDefaultText),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.message,
                            color: Constants.colorDefaultText,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Text(
                            "Resend SMS",
                            style: TextStyle(
                                color: Constants.colorDefaultText,
                                fontWeight: FontWeight.bold),
                          )),
                          Text(
                            "1:02",
                            style: TextStyle(
                              color: Constants.colorDefaultText,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.call,
                            color: Constants.colorDefaultText,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Text(
                            "Call me",
                            style: TextStyle(
                                color: Constants.colorDefaultText,
                                fontWeight: FontWeight.bold),
                          )),
                          Text(
                            "1:02",
                            style: TextStyle(
                              color: Constants.colorDefaultText,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ],
                  );
                }, listener: (context, state) {
                  if (state is InvalidOtpState) {
                    _showErrorDialog("Invalid OTP");
                  }else if(state is VerifyingState){
                    _showProgressDialog();
                  }else if(state is VerifiedState){
                    Navigator.of(context).pushNamedAndRemoveUntil(DashboardScreen.routeName, (r) => false);
                  }else if(state is VerificationFailedState){
                    _showErrorDialog("Login Failed");
                  }
                }),
              ),
            ),
          ),
        );
      }),
    );
  }

  //region blocInstance
  VerifyPhoneBloc _blocInstance() {
    return BlocProvider.of<VerifyPhoneBloc>(_context);
  }

  //endregion

  void _showErrorDialog(String message) {
    showDialog(
      context: _context,
      builder: (_) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop();
                },
                child: Text("OK"))
          ],
        );
      },
    );
  }

  void _showProgressDialog() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: Row(children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 24,),
            Text("Verifying")
          ],),
        );
      },
    );
  }

  List<TextSpanModel> _textList() {
    List<TextSpanModel> list = List<TextSpanModel>();
    list.add(
      TextSpanModel(
        text: "Waiting to automatically detect an SMS sent to +$_countryCode $_mobileNo. ",
        color: Constants.colorBlack,
      ),
    );
    list.add(
      TextSpanModel(
        text: "Wrong number?",
        onTap: () {
          Navigator.of(_context).pop();
        },
      ),
    );
    return list;
  }
}
