import 'package:flutter/cupertino.dart';
import 'package:pbas/model/constants/THEME_ELEMENTS.dart' as THEME;

class TextAndIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  Color _iconColor;
  TextAndIcon({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right:3.0),
          child: Text(text,
              style:THEME.styleSecondaryDark,),
        ),
        Icon(icon,
          size: THEME.secondaryTextDimension,
          color: iconColor==null? THEME.colorDark:iconColor,),
      ],
    );
  }

  Color get iconColor => _iconColor;
  set iconColor(Color value) {
    _iconColor = value;
  }
}
