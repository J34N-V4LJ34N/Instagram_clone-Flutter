import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/services/database.dart';
import 'package:instagram_clone/code/services/storage.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final UserData userData;
  const EditProfile({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameEditingController = TextEditingController();
  final _userNameEditingController = TextEditingController();
  final _bioEditingController = TextEditingController();

  bool loading = false;

  String _fullName = '';
  String _userName = '';
  String _bio = '';
  String _error = '';

  bool _fullNameChangeFlag = false;
  bool _userNameChangeFlag = false;
  bool _bioChangeFlag = false;

  uploadImageFromCamera() async {
    final _picker = ImagePicker();
    XFile? image;

    //Check Permissions
    await Permission.camera.request();
    var permissionStatus = await Permission.camera.status;
    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        setState(() {
          _error = 'Please provide path';
        });
      } else {
        var downloadURL = StorageService(uid: widget.userData.uid).storeProfilePic(image.path);
        setState(() {
          loading = true;
        });
        await DatabaseService(uid: widget.userData.uid).updateProfilePic(await downloadURL);
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        _error = 'Please allow permissions';
      });
    }
  }

  uploadImageFromStorage() async {
    final _picker = ImagePicker();
    XFile? image;

    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        setState(() {
          _error = 'Please provide path';
        });
      } else {
        var downloadURL = StorageService(uid: widget.userData.uid).storeProfilePic(image.path);
        setState(() {
          loading = true;
        });
        await DatabaseService(uid: widget.userData.uid).updateProfilePic(await downloadURL);
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        _error = 'Please allow permissions';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fullNameEditingController.text = widget.userData.fullName;
    _fullNameEditingController.addListener(_fullNameEditingControllerListener);
    _userNameEditingController.text = widget.userData.userName;
    _userNameEditingController.addListener(_userNameEditingControllerListener);
    _bioEditingController.text = widget.userData.bio;
    _bioEditingController.addListener(_bioEditingControllerListener);
  }

  void _fullNameEditingControllerListener() {
    this._fullName = _fullNameEditingController.text.trim();
    _fullNameChangeFlag = true;
  }

  void _userNameEditingControllerListener() {
    this._userName = _userNameEditingController.text.trim();
    _userNameChangeFlag = true;
  }

  void _bioEditingControllerListener() {
    this._bio = _bioEditingController.text.trim();
    _bioChangeFlag = true;
  }

  @override
  void dispose() {
    _fullNameEditingController.dispose();
    _userNameEditingController.dispose();
    _bioEditingController.dispose();
    super.dispose();
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
                    Icons.close,
                    color: _themeChanger.getTheme().accentColor,
                    size: 40.0,
                  ),
                  // onPressed: () => Navigator.of(context).pop(),
                  onPressed: () => Navigator.of(context).pop(), //This feels better to me than the one above(commented)
                ),
                title: Text(
                  'Edit Profile',
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
                          await DatabaseService(uid: widget.userData.uid).updateProfile(
                            _userNameChangeFlag ? _userName : widget.userData.userName,
                            _fullNameChangeFlag ? _fullName : widget.userData.fullName,
                            _bioChangeFlag ? _bio : widget.userData.bio,
                          );
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
                                    child: (widget.userData.profilePicURL == 'Loading...')
                                        ? LoadingCircle()
                                        : (widget.userData.profilePicURL == 'null')
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
                                            : Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(widget.userData.profilePicURL!),
                                                width: 100.0,
                                                height: 100.0,
                                              ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Change Profile Photo',
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
                              controller: _fullNameEditingController,
                              autocorrect: false,
                              validator: (value) => value!.isEmpty ? 'Enter your full name' : null,
                              // onChanged: (value) {
                              //   setState(() {
                              //     _fullName = value.trim();
                              //   });
                              // },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Full Name',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              controller: _userNameEditingController,
                              autocorrect: false,
                              validator: (value) {
                                value!.isEmpty ? 'Enter an Username' : null;
                                // Pattern pattern =
                                //     r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                // RegExp regex = new RegExp(pattern);
                                !RegExp(r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$').hasMatch(value)
                                    ? 'Invalid username'
                                    : null;
                              },
                              // onChanged: (value) {
                              //   setState(() {
                              //     _userName = value.trim();
                              //   });
                              // },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              controller: _bioEditingController,
                              autocorrect: false,
                              // onChanged: (value) {
                              //   setState(() {
                              //     _bio = value.trim();
                              //   });
                              // },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Bio',
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
