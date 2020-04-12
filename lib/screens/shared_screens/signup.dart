import 'package:fcaihu/constants/constants.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static final String id = 'signinScreen';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignupScreen> {
  //form controller key
  final _formKey = GlobalKey<FormState>();

  //user email & password
  String _email;
  String _password;
  String _username;
  String _id;
  String _level;

  //sign in with user email and password
  _submit() {
    //check if the form filled correctly
    if (_formKey.currentState.validate()) {
      //saving the entered data into variables
      _formKey.currentState.save();
    }

    //login with auth services
    //TODO AuthService.login(_email, _password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [ColorsScheme.brightPurple, Colors.purple]),
            ),
            child: ListView(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.13),
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/welcome/HLogo.png'),
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'FCAI',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.blueGrey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' HU',
                            style: TextStyle(
                              color: ColorsScheme.purple,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: ColorsScheme.purple,
                            ),
                            filled: true,
                            fillColor: ColorsScheme.brightPurple,
                          ),
                          textDirection: TextDirection.ltr,
                          validator: (input) => !input.contains('@')
                              ? 'Please enter valid email'
                              : null,
                          onSaved: (input) => _email = input.trim().toString(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'UserName',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: ColorsScheme.purple,
                            ),
                            filled: true,
                            fillColor: ColorsScheme.brightPurple,
                          ),
                          textDirection: TextDirection.ltr,
                          validator: (input) => input.trim().isEmpty
                              ? 'Please enter valid username'
                              : null,
                          onSaved: (input) =>
                              _username = input.trim().toString(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'ID',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(
                              Icons.info_outline,
                              color: ColorsScheme.purple,
                            ),
                            filled: true,
                            fillColor: ColorsScheme.brightPurple,
                          ),
                          textDirection: TextDirection.ltr,
                          validator: (input) => input.trim().isEmpty
                              ? 'Please enter valid ID'
                              : null,
                          onSaved: (input) => _id = input.trim().toString(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Level',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(
                              Icons.school,
                              color: ColorsScheme.purple,
                            ),
                            filled: true,
                            fillColor: ColorsScheme.brightPurple,
                          ),
                          textDirection: TextDirection.ltr,
                          validator: (input) => input.trim().isEmpty
                              ? 'Please enter valid level'
                              : null,
                          onSaved: (input) => _level = input.trim().toString(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: ColorsScheme.purple,
                            ),
                            filled: true,
                            fillColor: ColorsScheme.brightPurple,
                          ),
                          validator: (input) => input.trim().length < 6
                              ? 'Password must be more than 6 characters'
                              : null,
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      FlatButton(
                        onPressed: () {
                          //TODO sign up
                          // _submit()
                        },
                        color: ColorsScheme.purple,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15,
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xfff2f2f2),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                          side: BorderSide(color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
