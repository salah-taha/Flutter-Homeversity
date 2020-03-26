import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/screens/shared_screens/signup.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AnimationNames {
  static const String logoIn = 'logo_in';
  static const String logoOut = 'logo_out';
  static const String email = 'email';
  static const String password = 'password';
}

class LoginScreen extends StatefulWidget {
  static final String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form controller key
  final _formKey = GlobalKey<FormState>();

  //user email & password
  String _email;
  String _password;

  //text focus nodes
  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  //selected animation name
  String animationName = 'logo_in';

  //animation detector
  bool isAnimating = false;

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
  void initState() {
    _emailNode.addListener(() {
      if (_emailNode.hasFocus) {
        if (!isAnimating) {
          setState(() {
            isAnimating = true;
            animationName = AnimationNames.email;
          });
        }
      }
    });
    _passNode.addListener(() {
      if (_passNode.hasFocus) {
        if (!isAnimating) {
          setState(() {
            isAnimating = true;
            animationName = AnimationNames.password;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _passNode.dispose();
    _emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.grey,
      body: SafeArea(
        child: Container(
          decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ColorsScheme.brightPurple, ColorsScheme.midPurple]),
//            color: ColorsScheme.grey,
          ),
          height: MediaQuery.of(context).size.height - 24,
          child: Center(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  child: Hero(
                    tag: 'logo',
                    child:
//                          Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal:
//                                    MediaQuery.of(context).size.width * 0.10),
//                            height: 120,
//                            width: 120,
//                            child: Image.asset('assets/welcome/HLogo.png'),
//                          ),
                        Container(
                      width: 300,
                      height: 150,
                      child: FlareActor(
                        'assets/sign_in_animation.flr',
                        animation: animationName,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        callback: (name) {
                          setState(() {
                            animationName = AnimationNames.logoIn;
                            isAnimating = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
//                  Center(
//                    child: RichText(
//                      text: TextSpan(
//                          text: 'FCAI',
//                          style: TextStyle(
//                            fontSize: 40,
//                            color: Colors.blueGrey,
//                          ),
//                          children: <TextSpan>[
//                            TextSpan(
//                              text: ' HU',
//                              style: TextStyle(
//                                color: ColorsScheme.purple,
//                                fontSize: 40,
//                                fontWeight: FontWeight.bold,
//                              ),
//                            ),
//                          ]),
//                    ),
//                  ),
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
                          focusNode: _emailNode,
                          //keyboard input
                          keyboardType: TextInputType.emailAddress,
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
                        height: 13,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        child: TextFormField(
                          focusNode: _passNode,
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
                      /*  FlatButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SignupScreen.id);
                        },
                        child:*/
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, SignupScreen.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Create a New Account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorsScheme.purple,
//                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),

                      /*    Text(
                          'Create a new Account',
                          style: TextStyle(
                            color: ColorsScheme.darkGrey,
                          ),
                        ),*/
                      //       ),

                      FlatButton(
                        onPressed: () {
                          //TODO sign in
                          // _submit()
                        },
                        color: ColorsScheme.purple,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15,
                          ),
                          child: Text(
                            'Login',
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
    );
  }
}
