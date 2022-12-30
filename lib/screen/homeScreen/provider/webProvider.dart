import 'package:flutter/cupertino.dart';

class webProvider extends ChangeNotifier
{
  String url = "https://www.google.com/";
  int progressWeb =0;

  void changeNewUrl(String link) {
    url = link;
    notifyListeners();
  }

  void newprogress(int progress)
  {
    progressWeb = progress;
    notifyListeners();
  }
}