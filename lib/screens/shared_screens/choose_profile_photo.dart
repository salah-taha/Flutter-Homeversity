import 'dart:io';

import 'package:fcaihu/constants/constants.dart';
import 'package:fcaihu/services/auth_service.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AnimationNames {
  static final String loading = 'loop_animation';
  static final String done = 'done_animation';
}

class ChooseProfilePhoto extends StatefulWidget {
  static final String id = 'change_photo_screen';
  @override
  _ChooseProfilePhotoState createState() => _ChooseProfilePhotoState();
}

class _ChooseProfilePhotoState extends State<ChooseProfilePhoto> {
  File imageFile;
  String imageUrl;

  //loading
  bool isLoading = false;
  //loading animation name
  String loadingAnimationName = AnimationNames.loading;
  //loading animation controller
  final FlareControls _loadingController = FlareControls();

  _choosePhoto() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        this.imageFile = imageFile;
      });
    }
  }

  _uploadPhoto(BuildContext context) async {
    await AuthService.updateUserPhoto(imageFile: imageFile, context: context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScheme.brightPurple,
      appBar: AppBar(
        title: Text(
          'Choose your Photo',
          style: appBarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsScheme.purple),
        backgroundColor: ColorsScheme.brightPurple,
        elevation: 0,
      ),
      body: isLoading
          ? Padding(
              padding: const EdgeInsets.all(120.0),
              child: FlareActor(
                'assets/loading_animation_purple.flr',
                isPaused: !isLoading,
                alignment: Alignment.center,
                animation: loadingAnimationName,
                controller: _loadingController,
                callback: (name) {
                  if (name == AnimationNames.done) {
                    Navigator.pop(context);
                  } else {
                    _loadingController.play(AnimationNames.loading);
                  }
                },
              ),
            )
          : Container(
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
                              ? AssetImage('assets/images/user_placeholder.png')
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
                  RaisedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await _uploadPhoto(context);
                      setState(() {
                        loadingAnimationName = AnimationNames.done;
                      });
                    },
                    elevation: 0,
                    color: ColorsScheme.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Upload Photo',
                        style: TextStyle(
                          color: ColorsScheme.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 0,
                    color: ColorsScheme.brightPurple,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: ColorsScheme.darkGrey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
