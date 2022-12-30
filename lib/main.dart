import 'package:flutter/material.dart';
import 'package:inappwebview/screen/homeScreen/provider/webProvider.dart';
import 'package:inappwebview/screen/homeScreen/view/homeScreen.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(
    ChangeNotifierProvider(
      create: (context) => webProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) => inappWebview(),
        },
      ),
    ),
  );
}