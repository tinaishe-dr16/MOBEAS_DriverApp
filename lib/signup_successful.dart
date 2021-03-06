import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
// import 'loginerr.dart';
// import 'loginerr2.dart';
import 'main.dart';
import 'signup.dart';

class SignupSuccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignupSuccessState();
}

class _SignupSuccessState extends State<SignupSuccess> {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser(BuildContext context) async {
    final User user = (await auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (user != null) {
      usersRef.child(user.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          auth.signOut();
          displayToastMessage(
              "User does not exist! Please create an account", context);
        }
      });
    } else {
      displayToastMessage(
          "Error occured! Cannot Login, try again later", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child: Image.asset('assets/images/cover.png'),
      ),
    );

    final textEmail = TextField(
      cursorColor: Colors.red,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      onChanged: (value) {
        setState(() {
          _email = value.trim();
        });
      },
      decoration: InputDecoration(
        hintText: 'Email',
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
      onChanged: (value) {
        setState(() {
          _password = value.trim();
        });
      },
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
          if (!emailController.text.contains("@")) {
            displayToastMessage("Email address not valid", context);
          } else if (passwordController.text.isEmpty) {
            displayToastMessage("Password is required!", context);
          } else {
            loginUser(context);
          }

          // auth
          //     .signInWithEmailAndPassword(email: _email, password: _password)
          //     .then((_) {
          //   Navigator.pushReplacement(
          //       context, MaterialPageRoute(builder: (context) => Home()));
          // });
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
              'Account created successfully. Login to continue\n',
              style: new TextStyle(color: Colors.red),
            ),
            textEmail,
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
