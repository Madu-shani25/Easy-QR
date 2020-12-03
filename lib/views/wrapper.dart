import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_attendence/models/user.dart';
import 'package:student_attendence/services/authenticate.dart';
import 'package:student_attendence/views/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
