import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/screens/shared_screens/login.dart';
import 'package:fcaihu/services/auth_service.dart';
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
  _submit(BuildContext context) {
    //check if the form filled correctly
    if (_formKey.currentState.validate()) {
      //saving the entered data into variables
      _formKey.currentState.save();
      //login with auth services
      return AuthService.signUp(
          userName: _username,
          password: _password,
          email: _email,
          id: _id,
          level: _level,
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.grey,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ColorsScheme.brightPurple, ColorsScheme.midPurple]),
          ),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'FCAI',
                        style: TextStyle(
                          fontSize: 40,
                          color: ColorsScheme.midPurple,
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
                            onSaved: (input) =>
                                _email = input.trim().toString(),
                          ),
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
                            onSaved: (input) =>
                                _level = input.trim().toString(),
                          ),
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
                          height: 10,
                        ),
                        FlatButton(
                          onPressed: () async {
                            String result = await _submit(context);
                            if (result != null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          height: 200.0,
                                          width: 300.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15.0),
                                                child: Text(
                                                  'Error',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  result,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          ColorsScheme.purple,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                LoginScreen.id);
                                                      },
                                                      child: Text('Login'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            } else {
                              Navigator.pop(context);
                            }
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
