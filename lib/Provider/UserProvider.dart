

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier
{


int userId=0;


setCurrentUserId(int id)
{
  this.userId=id;
  notifyListeners();
}


int getUserId()
{
  return userId;
}




}