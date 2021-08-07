import 'package:flutter/material.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/services/database.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'package:intl/intl.dart';

class InstaPost extends StatefulWidget {
  final String userName;
  final String? profilePhotoURL;
  final String postURL;
  final String caption;
  final time;
  final likes;
  final postNum;
  final likedBy;
  final isLiked;
  final String uidOther;

  const InstaPost({
    Key? key,
    required this.userName,
    required this.profilePhotoURL,
    required this.postURL,
    required this.caption,
    required this.time,
    required this.likes,
    required this.postNum,
    required this.likedBy,
    required this.isLiked,
    required this.uidOther,
  }) : super(key: key);

  @override
  _InstaPostState createState() => _InstaPostState();
}

class _InstaPostState extends State<InstaPost> {
  // : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Color _favIconColor = widget.likedBy == true ? Colors.red : Colors.white;
    // IconData _favIcon = widget.likedBy == true ? Icons.favorite : Icons.favorite_border;
    final uid = Provider.of<UserData>(context).uid;
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    // if (_favIconColor != Colors.red) {
    //   _favIconColor = _themeChanger.getTheme().accentColor;
    // }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: ClipOval(
                  child: widget.profilePhotoURL == 'Loading...'
                      ? LoadingCircle()
                      : (widget.profilePhotoURL == 'null')
                          ? Placeholder(
                              color: _themeChanger.getTheme().accentColor,
                              fallbackHeight: 40.0,
                              fallbackWidth: 40.0,
                              strokeWidth: 0.0,
                            )
                          : Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.profilePhotoURL!),
                              width: 40.0,
                              height: 40.0,
                            ),
                ),
              ),
              Text(widget.userName),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          widget.postURL == 'Loading...'
              ? LoadingCircle()
              : Image(
                  image: NetworkImage(widget.postURL),
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Text('${widget.likes} likes'),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  if (widget.isLiked == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: _themeChanger.getTheme().primaryColor,
                        elevation: 100.0,
                        content: Text(
                          'You have liked the post',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _themeChanger.getTheme().accentColor),
                        ),
                        // action: SnackBarAction(
                        //   label: 'Action',
                        //   onPressed: () {
                        //     // Code to execute.
                        //   },
                        // ),
                      ),
                    );
                    DatabaseService(uid: uid)
                        .updateLikesPlus(widget.likes, widget.postNum, widget.likedBy, widget.uidOther);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: _themeChanger.getTheme().primaryColor,
                        elevation: 100.0,
                        content: Text(
                          'You have removed your like',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _themeChanger.getTheme().accentColor),
                        ),
                        // action: SnackBarAction(
                        //   label: 'Action',
                        //   onPressed: () {
                        //     // Code to execute.
                        //   },
                        // ),
                      ),
                    );
                    DatabaseService(uid: uid)
                        .updateLikesMinus(widget.likes, widget.postNum, widget.likedBy, widget.uidOther);
                  }
                  // setState(
                  //   () {
                  //     if (widget.isLiked == false) {
                  //       _favIconColor = _themeChanger.getTheme().accentColor;
                  //       _favIcon = Icons.favorite_border;
                  //     } else {
                  //       _favIconColor = Colors.red;
                  //       _favIcon = Icons.favorite;
                  //     }
                  //   },
                  // );
                },
                icon: Icon(
                  widget.isLiked == false ? Icons.favorite_border : Icons.favorite,
                  size: 30.0,
                  color: widget.isLiked == false ? _themeChanger.getTheme().accentColor : Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.mode_comment_outlined,
                  size: 30.0,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send_outlined,
                  size: 30.0,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_outline,
                  size: 30.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Text(widget.caption),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Text(
              widget.time == 'Loading...' ? 'Loading...' : timeago.format(widget.time.toDate()),
              style: TextStyle(color: Colors.grey, fontSize: 10.0),
            ),
            // : DateFormat('dd-MM-yyyy kk:mm:a').format(widget.time.toDate())),
          ),
        ],
      ),
    );
  }
}
