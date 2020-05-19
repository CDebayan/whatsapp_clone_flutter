import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_bloc.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_event.dart';
import 'package:whatsappcloneflutter/blocs/select_country_bloc/select_country_state.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/functionality.dart';
import 'package:whatsappcloneflutter/models/country_list_model.dart';
import 'package:whatsappcloneflutter/widgets/widgets.dart';

class SelectCountryScreen extends StatelessWidget with Functionality {
  static const String routeName = "SelectCountryScreen";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool appbarStatus =
            BlocProvider.of<SelectCountryBloc>(context).appbarStatus;
        if (appbarStatus) {
          BlocProvider.of<SelectCountryBloc>(context).updateAppbarStatus();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: appBar(context),
        body: SafeArea(
          child: Container(
            child: BlocBuilder<SelectCountryBloc, SelectCountryState>(
              builder: (_, state) {
                if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedState) {
                  return _buildCountryList(state.countryList);
                } else if (state is ErrorState) {
                  return Container();
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountryList(List<CountryModel> countryList) {
    if (isValidList(countryList)) {
      return ListView.builder(
          itemCount: countryList.length,
          itemBuilder: (context, index) {
            CountryModel countryModel = countryList[index];
            return Column(
              children: <Widget>[
                ListTile(
//                  leading: SvgPicture.network(
//                    countryModel.flag,
//                    height: 20,
//                    width: 20,
//                  ),
                  onTap: () {
                    BlocProvider.of<SelectCountryBloc>(context).add(SelectItemEvent(countryModel: countryModel));
                    Navigator.of(context).pop();
                  },
                  title: Text(countryModel.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "+${countryModel.callingCodes[0]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.colorDefaultText),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      (countryModel.selected == null || !countryModel.selected)
                          ? Container(width: 24,)
                          : Icon(Icons.check),
                    ],
                  ),
                  selected: countryModel.selected != null
                      ? countryModel.selected
                      : false,
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                )
              ],
            );
          });
    }
    return Container();
  }
}

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Constants.colorOffWhite,
    iconTheme: IconThemeData(color: Constants.colorPrimaryDark),
    elevation: 1,
    title: StreamBuilder(
      stream: BlocProvider.of<SelectCountryBloc>(context).showSearch,
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.data) {
          return EditText(
            hint: "",
            onChanged: (value) {
              BlocProvider.of<SelectCountryBloc>(context)
                  .add(SearchCountryEvent(text: value));
            },
          );
        }
        return Text(
          "Choose a country",
          style: TextStyle(color: Constants.colorPrimaryDark),
        );
      },
    ),
    actions: <Widget>[
      StreamBuilder(
          stream: BlocProvider.of<SelectCountryBloc>(context).showSearch,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data) {
              return Container();
            }
            return Container(
              padding: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Constants.colorPrimaryDark,
                ),
                onPressed: () {
                  BlocProvider.of<SelectCountryBloc>(context)
                      .updateAppbarStatus();
                },
              ),
            );
          })
    ],
  );
}
