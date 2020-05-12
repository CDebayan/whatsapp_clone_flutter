import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/widgets/model/text_span_model.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  Button({
    @required this.text,
    @required this.onPressed,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Constants.primaryColor,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: TextStyle(color: Constants.colorWhite),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          "from",
          style: TextStyle(color: Constants.defaultTextColor),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "FACEBOOK",
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 16,
          ),
        ),
      ],
    ));
  }
}

class LinkText extends StatelessWidget {
  final List<TextSpanModel> list;

  LinkText(this.list);

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> textSpanList = List<InlineSpan>();
    for (var item in list) {
      if (item.onTap == null) {
        textSpanList.add(
          TextSpan(
            text: item.text,
            style: TextStyle(
              color:
                  item.color != null ? item.color : Constants.defaultTextColor,
            ),
          ),
        );
      } else {
        textSpanList.add(
          TextSpan(
            text: item.text,
            style: TextStyle(
              color: item.color != null ? item.color : Constants.colorBlue,
            ),
            recognizer: TapGestureRecognizer()..onTap = item.onTap,
          ),
        );
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: textSpanList),
    );
  }
}
