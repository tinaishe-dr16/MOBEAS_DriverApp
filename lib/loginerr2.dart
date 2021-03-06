import 'package:flutter/material.dart';
// import 'home.dart';
// import 'signup_successful.dart';
import 'signup.dart';

class LoginErr2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginErr2State();
}

class _LoginErr2State extends State<LoginErr2> {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    final logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child: Image.asset('assets/images/cover.png'),
      ),
    );

    final textUsername = TextField(
      cursorColor: Colors.red,
      controller: usernameController,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    final textPassword = TextField(
      cursorColor: Colors.red,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    final btnLogin = RaisedButton(
        child: Text('Login'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          /*if (usernameController != null &&
              usernameController.text == "tinaishe_dr" &&
              passwordController != null &&
              passwordController.text == "titi16071999") {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          } else if (usernameController != null || passwordController != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginErr2()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginErr()));
          }*/
        });

    final btnForgotPassword = FlatButton(
      onPressed: () => null,
      child: Text(
        "Forgot Password?",
        style: new TextStyle(color: Colors.blue),
      ),
    );

    final btnSignup = FlatButton(
      onPressed: () => {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Signup()))
      },
      child: Text(
        "Signup",
        style: new TextStyle(color: Colors.blue),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('MOBEAS Login'),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: new Center(
        child: new ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 25, right: 25),
          children: [
            logo,
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Please enter a username/password.\n',
              style: new TextStyle(color: Colors.red),
            ),
            textUsername,
            SizedBox(
              height: 8.0,
            ),
            textPassword,
            SizedBox(
              height: 20.0,
            ),
            btnLogin,
            btnForgotPassword,
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Don\'t have an account?'), btnSignup],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
