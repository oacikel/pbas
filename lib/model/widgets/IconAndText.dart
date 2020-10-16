import 'package:flutter/cupertino.dart';
import 'package:pbas/model/constants/THEME_ELEMENTS.dart' as THEME;

class IconAndText extends StatelessWidget {
  final String text;
  final IconData icon;
  Color iconColor;
  IconAndText({Key key, this.text, this.icon,this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 3),
            child: Icon(icon,
              size: THEME.secondaryTextDimension,
              color: iconColor==null? THEME.colorDark:iconColor,),
          ),
          Text(text,
            style:THEME.styleSecondaryDark,),
        ],
      );
  }
}
