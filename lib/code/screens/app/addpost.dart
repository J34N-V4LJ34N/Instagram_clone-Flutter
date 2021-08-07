import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/services/database.dart';
import 'package:instagram_clone/code/services/storage.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  final UserData userData;
  const AddPost({Key? key, required this.userData}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String _caption = '';
  String _error = '';
  XFile? _image;

  bool _imageUploaded = false;

  uploadImageFromCamera() async {
    final _picker = ImagePicker();

    //Check Permissions
    await Permission.camera.request();
    var permissionStatus = await Permission.camera.status;
    if (permissionStatus.isGranted) {
      //Select Image
      _image = await _picker.pickImage(source: ImageSource.camera);
      if (_image == null) {
        setState(() {
          _error = 'Please provide path';
        });
      } else {
        setState(() {
          _imageUploaded = true;
        });
      }
    } else {
      setState(() {
        _error = 'Please allow permissions';
      });
    }
  }

  uploadImageFromStorage() async {
    final _picker = ImagePicker();

    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Select Image
      _image = await _picker.pickImage(source: ImageSource.gallery);
      if (_image == null) {
        setState(() {
          _error = 'Please provide path';
        });
      } else {
        setState(() {
          _imageUploaded = true;
        });
      }
    } else {
      setState(() {
        _error = 'Please allow permissions';
      });
    }
  }

  uploadImageToDatabase() async {
    String downloadURL =
        await StorageService(uid: widget.userData.uid).storePost(_image!.path, widget.userData.numberOfPosts);
    await DatabaseService(uid: widget.userData.uid)
        .addPost(downloadURL, _caption, DateTime.now(), widget.userData.numberOfPosts, 0, ['Jean']);
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return loading
        ? Loading()
        : GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: _themeChanger.getTheme().accentColor,
                    size: 40.0,
                  ),
                  // onPressed: () => Navigator.of(context).pop(),
                  onPressed: () => Navigator.of(context).pop(), //This feels better to me than the one above(commented)
                ),
                title: Text(
                  'New Post',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.blue,
                        size: 40.0,
                      ),
                      // onPressed: () => Navigator.of(context).pop(),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          uploadImageToDatabase();
                          DatabaseService(uid: widget.userData.uid).updateNum(widget.userData.numberOfPosts);
                          Navigator.of(context).pop();
                          // auth.createUserWithEmailAndPassword(
                          //     email: _email, password: _password);
                        }
                      } //This feels better to me than the one above(commented)
                      ),
                ],
              ),
              body: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text('Camera'),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text('Gallery'),
                                value: 2,
                              ),
                            ],
                            onSelected: (result) async {
                              if (result == 1) {
                                uploadImageFromCamera();
                              }
                              if (result == 2) {
                                uploadImageFromStorage();
                              }
                            },
                            child: InkWell(
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: (!_imageUploaded)
                                        ? Container(
                                            height: 100.0,
                                            width: 100.0,
                                            child: Placeholder(
                                              color: _themeChanger.getTheme().accentColor,
                                              fallbackHeight: 100.0,
                                              fallbackWidth: 100.0,
                                              strokeWidth: 0.0,
                                            ),
                                          )
                                        : Image.file(
                                            File(_image!.path),
                                            fit: BoxFit.cover,
                                            width: 100.0,
                                            height: 100.0,
                                          ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Add Image',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                              // onTap: () {
                              //   // print("tapped on container");
                              //   uploadImageFromStorage();
                              // },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: Text(
                              _error,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              validator: (value) => value!.isEmpty ? 'Enter caption' : null,
                              onChanged: (value) {
                                setState(() {
                                  _caption = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Caption',
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(34.0, 10.0, 34.0, 10.0),
                          //   child: ElevatedButton(
                          //     onPressed: () async {
                          //       if (_formKey.currentState!.validate()) {
                          //         setState(() {
                          //           loading = true;
                          //         });
                          //         final user = Provider.of<UserData>(context);
                          //         await DatabaseService(uid: user.uid).updateProfile(_username, _fullname, _bio);
                          //         Navigator.of(context).pushReplacementNamed('/');
                          //         // auth.createUserWithEmailAndPassword(
                          //         //     email: _email, password: _password);
                          //       }
                          //     },
                          //     child: Text('Sign up'),
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Colors.blue,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
