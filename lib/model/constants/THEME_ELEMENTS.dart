library THEME_ELEMENTS;
    import 'package:flutter/material.dart';

    //Main theme
    const String MAIN_FONT_NAME="Montserrat";

    //Dimensions
    const double CARD_HEIGHT= 400;
    const double CARD_WIDTH= 270;
    const double CARD_MAP_IMAGE_WIDTH=CARD_WIDTH*0.5;
    const double CARD_MAP_IMAGE_HEIGHT=CARD_HEIGHT*0.35;


const double titleTextDimension=18;
    const double secondaryTextDimension= 12;

    //Colors
    const Color colorDark=Color.fromRGBO(54, 59, 76,1.0);
    const Color primaryColor=Colors.deepOrange;
    const Color colorLight=Colors.white;
    const Color colorPink=Colors.pinkAccent;

    //Text Style
    final styleTitleDark = TextStyle(fontSize: titleTextDimension, color: colorDark,fontWeight: FontWeight.bold);
    final styleSecondaryDark = TextStyle(fontSize:secondaryTextDimension,color: colorDark);

    final styleTitleWhite = TextStyle(fontSize: titleTextDimension, color: colorLight,fontWeight: FontWeight.bold);
    final styleSecondaryLight = TextStyle(fontSize:secondaryTextDimension,color: colorLight);

    //String
    //Main Page
    const String textMinutes=" dakika";
    const String textMeters=" metre";
    const String textStart="Başla";

