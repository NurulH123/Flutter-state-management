import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/notes.dart';
import 'package:state_management/screens/add_or_detail_screeen.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Notes(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: HomeScreen(),
        routes: {
          AddOrDetailScreen.routeName: (context) => AddOrDetailScreen(),
        },
      ),
    );
  }
}
