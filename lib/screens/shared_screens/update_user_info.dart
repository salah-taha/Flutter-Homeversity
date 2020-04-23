import 'dart:io';

import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/models/provider_data.dart';
import 'package:fcaihu/models/user.dart';
import 'package:fcaihu/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateInfoScreen extends StatefulWidget {
  static final String id = 'updateInfoScreen';

  @override
  _UpdateInfoScreenState createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  String userName;
  File imageFile;
  String imageUrl;

  _choosePhoto() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        this.imageFile = imageFile;
      });
    }
  }

  _changeInfo(BuildContext context, String name) async {
    await AuthService.changeUserInfo(
        imageFile: imageFile,
        context: context,
        userName: userName != null ? userName : name);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<ProviderData>(context).user;
    return Scaffold(
      backgroundColor: ColorsScheme.brightPurple,
      appBar: AppBar(
        title: Text(
          'Update Your Info',
          style: appBarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsScheme.purple),
        backgroundColor: ColorsScheme.brightPurple,
        elevation: 0,
      ),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => _choosePhoto(),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: ColorsScheme.darkGrey,
                    backgroundImage: imageFile == null
                        ? user.imageUrl == ' '
                            ? AssetImage('assets/images/user_placeholder.gif')
                            : NetworkImage(user.imageUrl)
                        : FileImage(imageFile),
                  ),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: ColorsScheme.purple.withAlpha(20),
                    child: Icon(
                      Icons.add_a_photo,
                      color: ColorsScheme.grey,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: TextFormField(
                initialValue: user.name ?? ' ',
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
                  fillColor: ColorsScheme.white,
                ),
                onChanged: (input) => userName = input,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: () => _changeInfo(context, user.name),
              elevation: 0,
              color: ColorsScheme.purple,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Change Info',
                  style: TextStyle(
                    color: ColorsScheme.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
