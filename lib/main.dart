import 'package:flutter/material.dart';
import 'package:kos/ChooseScreen.dart';
import 'package:kos/FrontScreen.dart';
import 'package:kos/MenuScreen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        home: MenuScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    ),
  );
}

