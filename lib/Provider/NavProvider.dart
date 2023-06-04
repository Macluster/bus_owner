

import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier
{

  String header="";

  String getHeader()
  {
    return header;
  }

  void setHeader(String title)
  {
      header=title;
      notifyListeners();
  }
  
}