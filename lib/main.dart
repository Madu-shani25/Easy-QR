import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_attendence/models/user.dart';
import 'package:student_attendence/services/auth.dart';
import 'package:student_attendence/views/wrapper.dart';

void main() => runApp(MyApp(
));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
    child: MaterialApp(
  home: Wrapper(),
    ),
    );
  }
  }