import 'package:flutter/material.dart';
import 'package:student_attendence/services/auth.dart';
import 'package:student_attendence/shared/constant.dart';
import 'package:student_attendence/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _showForgotPassword = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Sign In'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: () => widget.toggleView(),
            ),
          ],
        ),
        body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child:Form(
            key: _formKey,
            child:Column(
              children:<Widget>[
                SizedBox(height: 10.0),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an Email': null ,
                  onChanged: (val){
                      setState(() => email = val);
                  }
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter Password': null ,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  color: Colors.black,
                  child:Text(
                    'Sign In',
                    style:TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState((){
                            error = 'Could Not Sign In With Those Credentials';
                            loading = false;
                      });
    }
            _showForgotPassword = true;
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
    );
  }
  Widget showForgotPassword(bool visible){
    return FlatButton (
      onPressed: () {  },
      child:Text("Forgot Password?" , style:TextStyle(color:Colors.white)),
    );
  }
}
