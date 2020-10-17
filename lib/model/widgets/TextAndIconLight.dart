import 'package:flutter/cupertino.dart';
import 'package:pbas/model/constants/THEME_ELEMENTS.dart' as THEME;

class TextAndIconLight extends StatelessWidget {
  final String text;
  final IconData icon;
  Color _iconColor;
  TextAndIconLight({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right:3.0),
          child: Text(text,
              style:THEME.styleSecondaryLight,),
        ),
        Icon(icon,
          size: THEME.secondaryTextDimension,
          color: iconColor==null? THEME.colorLight:iconColor,),
      ],
    );
  }

  Color get iconColor => _iconColor;
  set iconColor(Color value) {
    _iconColor = value;
  }
}
