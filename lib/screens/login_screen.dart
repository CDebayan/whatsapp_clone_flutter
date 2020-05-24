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
      _blocInstance().add(SearchCountryByCodeEvent(code: _countryCodeController.text.toString().trim(),context: context));
    });

    return Scaffold(
      appBar: transparentAppBar(title: "Enter your phone number"),
      body: SafeArea(
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
            Button(
                text: "Next",
                onPressed: () {
                  Navigator.of(context).pushNamed(VerifyPhoneScreen.routeName);
                }),
            //endregion

            SizedBox(height: 24),
          ],
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
              _countryController.text = countryModel.name;
              if (isValidList(countryModel.callingCodes) && isValidString(countryModel.callingCodes[0])) {
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
                      hint: "phone number",
                      controller: _phoneController,
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
    _showDialog(mobileNumbers);
  }

  //endregion

  //region showDialog
  void _showDialog(List<SimCard> sims) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Select number",
          ),
          contentPadding: EdgeInsets.only(top: 8, left: 8, right: 8),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "+${sims[index].countryPhonePrefix} ${sims[index].number.substring(sims[index].number.length - 10)}"),
                          Text(
                              "SIM ${(sims[index].slotIndex + 1)}, ${sims[index].carrierName}"),
                        ],
                      ),
                    ),
                    Radio(value: true, groupValue: 1, onChanged: (_) {})
                  ],
                );
              }),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CANCEL",
                style: TextStyle(color: Constants.colorPrimaryDark),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "USE",
                style: TextStyle(color: Constants.colorPrimaryDark),
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
}
