import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_bloc.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_event.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_state.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_bloc.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_event.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';
import 'package:whatsappcloneflutter/models/text_span_model.dart';
import 'package:whatsappcloneflutter/screens/select_country_screen.dart';
import 'package:whatsappcloneflutter/screens/verify_phone_screen.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Functionality {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _phoneFocusNode = FocusNode();
  final _countryCodeFocusNode = FocusNode();

  String countryAlphaCode;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SelectCountryBloc>(context).add(FetchCountryListEvent());

    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        _initMobileNumberState();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    _countryCodeController.addListener(() {
      _blocInstance().add(SearchCountryByCodeEvent(
          code: _countryCodeController.text.toString().trim(),
          context: context));
    });

    return Scaffold(
      appBar: transparentAppBar(title: "Enter your phone number"),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    //region header
                    LinkText(_textList()),
                    //endregion

                    //region body
                    _body()
                    //endregion
                  ],
                ),
              ),

              //region next button
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is ValidationState) {
                    if (state.status == "countryCodeError") {
                      _showErrorDialog(state.message);
                    } else if (state.status == "countryError") {
                      _countryController.clear();
                      _countryCodeController.clear();
                      _showErrorDialog(state.message);
                    }else if (state.status == "phoneError") {
                      _showErrorDialog(state.message);
                    }else if(state.status == "success"){
                      Navigator.of(context).pushNamed(VerifyPhoneScreen.routeName);
                    }
                  }
                },
                child: Button(
                    text: "Next",
                    onPressed: () {
                      _validatePhone();
                    }),
              ),
              //endregion

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      width: 300,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SelectedCountryState) {
            CountryModel countryModel = state.countryModel;
            if (isValidObject(countryModel)) {
              countryAlphaCode = countryModel.alpha2Code;
              _countryController.text = countryModel.name;
              if (isValidString(countryModel.name) &&
                  countryModel.name != "invalid country code") {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              }
              if (isValidList(countryModel.callingCodes) &&
                  isValidString(countryModel.callingCodes[0])) {
                _countryCodeController.text = countryModel.callingCodes[0];
              }
            }
          }
        },
        child: Column(
          children: <Widget>[
            EditText(
              hint: "Choose a country",
              controller: _countryController,
              textAlign: TextAlign.center,
              readOnly: true,
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                size: 16,
                color: Constants.colorPrimaryDark,
              ),
              contentPadding:
                  const EdgeInsets.only(bottom: -20, left: 16, right: 16),
              onTap: () {
                Navigator.of(context).pushNamed(SelectCountryScreen.routeName);
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: EditText(
                    focusNode: _countryCodeFocusNode,
                    hint: "",
                    controller: _countryCodeController,
                    maxLength: 3,
                    prefixIcon: Icon(
                      Icons.add,
                      size: 16,
                      color: Constants.colorDefaultText,
                    ),
                    keyboardType: TextInputType.phone,
                    contentPadding:
                        const EdgeInsets.only(bottom: -20, left: 20),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                    flex: 3,
                    child: EditText(
                      focusNode: _phoneFocusNode,
                      hint: "phone number",
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //region blocInstance
  LoginBloc _blocInstance() {
    return BlocProvider.of<LoginBloc>(context);
  }

  //endregion

  //region initMobileNumberState
  _initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }

    List<SimCard> mobileNumbers = await MobileNumber.getSimCards;
    print(mobileNumbers);
    _showSimListDialog(mobileNumbers);
  }

  //endregion

  //region showDialog
  void _showSimListDialog(List<SimCard> sims) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Select number",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          contentPadding: EdgeInsets.only(top: 16, left: 16, right: 16),
          content: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: sims.length,
              itemBuilder: (_, index) {
                return Row(
                  children: <Widget>[
                    Icon(
                      Icons.call,
                      color: Constants.colorPrimaryDark,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "+${sims[index].countryPhonePrefix} ${sims[index].number.substring(sims[index].number.length - 10)}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "SIM ${(sims[index].slotIndex + 1)}, ${sims[index].carrierName}",
                            style: TextStyle(
                                color: Constants.colorDefaultText,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Radio(value: null, groupValue: null, onChanged: (value) {})
                  ],
                );
              }),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CANCEL",
                style: TextStyle(
                    color: Constants.colorPrimaryDark,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "USE",
                style: TextStyle(
                    color: Constants.colorPrimaryDark,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //endregion

  //region textList
  List<TextSpanModel> _textList() {
    List<TextSpanModel> list = List<TextSpanModel>();
    list.add(
      TextSpanModel(
        text: 'WhatsApp will send an SMS message to verify your phone number. ',
        color: Constants.colorBlack,
      ),
    );
    list.add(
      TextSpanModel(
        text: "What's my number?",
        onTap: () {
          _initMobileNumberState();
        },
      ),
    );
    return list;
  }

//endregion

  void _validatePhone() {
    String countryCode = _countryCodeController.text.toString().trim();
    String country = _countryController.text.toString().trim();
    String phone = _phoneController.text.toString().trim();
    _blocInstance().add(ValidationEvent(
        countryCode: countryCode, countryAlphaCode: countryAlphaCode,country: country, phone: phone));
  }

  void _showErrorDialog(String errorText) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(errorText),
            contentPadding: EdgeInsets.only(top: 24, left: 24, right: 24),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Constants.colorPrimaryDark),
                  ))
            ],
          );
        });
  }
}
