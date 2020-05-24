import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whatsappcloneflutter/constants.dart';
import 'package:whatsappcloneflutter/models/text_span_model.dart';

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
      color: Constants.colorPrimary,
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
          style: TextStyle(color: Constants.colorDefaultText),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "FACEBOOK",
          style: TextStyle(
            color: Constants.colorPrimary,
            fontSize: 16,
          ),
        ),
      ],
    ));
  }
}

////////////////////////////////////////////////////////////////////////////////////

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
                  item.color != null ? item.color : Constants.colorDefaultText,
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

////////////////////////////////////////////////////////////////////////////////////

class EditText extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String errorText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool enabled;
  final TextAlign textAlign;
  final bool readOnly;
  final GestureTapCallback onTap;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry contentPadding;

  EditText(
      {@required this.hint,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.errorText,
      this.enabled,
      this.textAlign = TextAlign.left,
      this.readOnly = false,
      this.onTap,
      this.onChanged,
      this.maxLength,
      this.keyboardType = TextInputType.text,
      this.contentPadding = const EdgeInsets.only(bottom: -20)});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TextField(
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          textAlign: textAlign,
          readOnly: readOnly,
          keyboardType: keyboardType,
          onTap: onTap,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            counterText: "",
            contentPadding: contentPadding,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constants.colorPrimaryDark),
            ),
          ),
        ),
        Positioned(
            bottom: 8,
            left: 0,
            child: prefixIcon != null ? prefixIcon : Container()),
        Positioned(
            bottom: 8,
            right: 0,
            child: suffixIcon != null ? suffixIcon : Container())
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////

AppBar transparentAppBar({String title = ""}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(color: Constants.colorPrimaryDark),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}
