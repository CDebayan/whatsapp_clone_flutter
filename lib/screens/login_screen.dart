import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_bloc.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_event.dart';
import 'package:whatsappcloneflutter/blocs/login_bloc/login_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/country_picker/country_model.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/text_span_model.dart';
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

  String _countryAlphaCode;
  BuildContext _context;

  @override
  void initState() {
    super.initState();

    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        _initMobileNumberState();
      } else {}
    });
  }

  @override
  Widget build(BuildContext _context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Builder(
        builder: (context) {
          this._context = context;
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
                          } else if (state.status == "phoneError") {
                            _showErrorDialog(state.message);
                          } else if (state.status == "success") {
                            _showAlertDialog();
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
        },
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
              _countryAlphaCode = countryModel.alpha2Code;
              _countryController.text = countryModel.name;
              if (isValidString(countryModel.name) &&
                  countryModel.name != "invalid country code") {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              }
              if (isValidString(countryModel.callingCodes) &&
                  isValidString(countryModel.callingCodes)) {
                _countryCodeController.text = countryModel.callingCodes;
              }
            }
          } else if (state is SetSimNumberState) {
            CountryModel countryModel = state.countryModel;
            if (isValidObject(countryModel)) {
              _countryAlphaCode = countryModel.alpha2Code;
              _countryController.text = countryModel.name;
              if (isValidString(countryModel.name) &&
                  countryModel.name != "invalid country code") {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              }
              if (isValidString(countryModel.callingCodes) &&
                  isValidString(countryModel.callingCodes)) {
                _countryCodeController.text = countryModel.callingCodes;
              }
            }
            if (isValidString(state.phone)) {
              _phoneController.text = state.phone;
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
                _blocInstance().add(SelectCountryEvent(context: context));
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: EditText(
                    focusNode: _countryCodeFocusNode,
                    hint: "",
                    controller: _countryCodeController,
                    maxLength: 4,
                    onChanged: (value) {
                      _blocInstance().add(
                        SearchCountryByCodeEvent(
                          code: _countryCodeController.text.toString().trim(),
                        ),
                      );
                    },
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
            SizedBox(
              height: 16,
            ),
            Text(
              "Carrier SMS charges may apply",
              style: TextStyle(color: Constants.colorDefaultText),
            ),
          ],
        ),
      ),
    );
  }

  //region blocInstance
  LoginBloc _blocInstance() {
    return BlocProvider.of<LoginBloc>(_context);
  }

  //endregion

  //region initMobileNumberState
  _initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }

    List<SimCard> sims = await MobileNumber.getSimCards;
    if (isValidList(sims) && isValidObject(sims[0])) {
      var selectedSim = sims[0];
      _showSimListDialog(sims, selectedSim);
    }
  }

  //endregion

  //region showDialog
  void _showSimListDialog(List<SimCard> sims, SimCard selectedSim) {
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
                    Radio(
                        value: sims[index],
                        groupValue: selectedSim,
                        onChanged: (value) {
                          Navigator.of(context).pop();
                          _showSimListDialog(sims, value);
                        })
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
                _blocInstance().add(
                  SetSimNumberEvent(
                    simCard: selectedSim,
                  ),
                );
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
        countryCode: countryCode,
        countryAlphaCode: _countryAlphaCode,
        country: country,
        phone: phone));
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
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Constants.colorPrimaryDark),
                ),
              ),
            ],
          );
        });
  }

  void _showAlertDialog() {
    String _countryCode = _countryCodeController.text.toString().trim();

    String _mobileNo = _phoneController.text.toString().trim();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("We will be verifying the phone number:"),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "+$_countryCode $_mobileNo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Is this OK, or would you like to edit the number?"),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Constants.colorPrimaryDark),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(
                            VerifyPhoneScreen.routeName,
                            arguments: "$_countryCode $_mobileNo");
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: Constants.colorPrimaryDark),
                      ),
                    )
                  ],
                ),
              ],
            ),
            contentPadding:
                EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 16),
          );
        });
  }
}
