import 'package:connectivity/connectivity.dart';
import 'package:fcaihu/constants/constants.dart';
import 'package:flutter/material.dart';

//user profile screen
class Disconnected extends StatefulWidget {
  //profile screen route id
  static final String id = 'Disconnected';

  final Function changeInternetState;

  Disconnected(this.changeInternetState);

  @override
  _DisconnectedState createState() => _DisconnectedState();
}

class _DisconnectedState extends State<Disconnected> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('No Internet Connection'),
          RaisedButton(
            color: ColorsScheme.purple,
            onPressed: () async {
              var result = await Connectivity().checkConnectivity();
              if (result != ConnectivityResult.none) {
                widget.changeInternetState();
              } else {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: ColorsScheme.grey,
                            ),
                            height: 150.0,
                            width: 300.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Connection Error!',
                                    style: TextStyle(
                                      color: ColorsScheme.darkGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'No Internet Connection Found!',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: ColorsScheme.purple,
                                    textColor: ColorsScheme.white,
                                    child: Text('OK'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              }
            },
            child: Text(
              'Retry',
              style: TextStyle(
                color: ColorsScheme.white,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
