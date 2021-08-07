import 'package:flutter/material.dart';
import 'package:instagram_clone/code/models/allpost.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/services/database.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:provider/provider.dart';

class OtherProfile extends StatefulWidget {
  final String uid;
  final UserData userData;
  final UserData otherUserData;
  final List<AllPost> otherPosts;
  final bool isFollowing;
  const OtherProfile({
    Key? key,
    required this.uid,
    required this.userData,
    required this.otherUserData,
    required this.otherPosts,
    required this.isFollowing,
  }) : super(key: key);

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> with SingleTickerProviderStateMixin {
  bool loading = false;
  late TabController _tabController;
  late ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    List<AllPost> theRealOtherPosts = [];
    for (AllPost allPost in widget.otherPosts)
      if (allPost.uid == widget.otherUserData.uid) theRealOtherPosts.add(allPost);
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: _themeChanger.getTheme().accentColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  widget.otherUserData.userName,
                  style: TextStyle(color: _themeChanger.getTheme().accentColor),
                )),
            body: NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              child: ClipOval(
                                  child: (widget.otherUserData.profilePicURL == 'Loading...')
                                      ? LoadingCircle()
                                      : (widget.otherUserData.profilePicURL == 'null')
                                          ? Placeholder(
                                              color: _themeChanger.getTheme().accentColor,
                                              fallbackHeight: 100.0,
                                              fallbackWidth: 100.0,
                                              strokeWidth: 0.0,
                                            )
                                          : Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(widget.otherUserData.profilePicURL!),
                                              width: 100.0,
                                              height: 100.0,
                                            )),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  child: RichText(
                                    text: new TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: '${widget.otherUserData.numberOfPosts}',
                                            style: new TextStyle(
                                              color: _themeChanger.getTheme().accentColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Text('Posts')
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  child: RichText(
                                    text: new TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: widget.otherUserData.numberOfFollowers.toString(),
                                            style: new TextStyle(
                                              color: _themeChanger.getTheme().accentColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Text('Followers')
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                    child: RichText(
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: widget.otherUserData.numberOfFollowing.toString(),
                                              style: new TextStyle(
                                                color: _themeChanger.getTheme().accentColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text('Following')
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 20.0,
                          ),
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 14.0,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: widget.otherUserData.fullName,
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _themeChanger.getTheme().accentColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 20.0,
                          ),
                          child: Text(widget.otherUserData.bio),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20.0, 10.0, 3.0, 0.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      loading = true;
                                    });
                                    if (widget.isFollowing == false) {
                                      DatabaseService(uid: widget.uid).updateFollow(
                                          widget.uid,
                                          widget.otherUserData.uid,
                                          widget.otherUserData.numberOfFollowers,
                                          widget.otherUserData.followers,
                                          widget.userData.numberOfFollowing,
                                          widget.userData.following);
                                    } else {
                                      DatabaseService(uid: widget.uid).updateUnfollow(
                                          widget.uid,
                                          widget.otherUserData.uid,
                                          widget.otherUserData.numberOfFollowers,
                                          widget.otherUserData.followers,
                                          widget.userData.numberOfFollowing,
                                          widget.userData.following);
                                    }
                                    Navigator.of(context).pop();
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
                                  child: widget.isFollowing
                                      ? Text(
                                          'Following',
                                          style: TextStyle(color: _themeChanger.getTheme().accentColor),
                                        )
                                      : Text(
                                          'Follow',
                                          style: TextStyle(color: _themeChanger.getTheme().accentColor),
                                        ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side: BorderSide(
                                          color: _themeChanger.getTheme().accentColor,
                                        ),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all<double>(0.0),
                                    backgroundColor: widget.isFollowing
                                        ? MaterialStateProperty.all(_themeChanger.getTheme().primaryColor)
                                        : MaterialStateProperty.all(Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(3.0, 10.0, 20.0, 0.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: _themeChanger.getTheme().accentColor,
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(
                                        color: _themeChanger.getTheme().accentColor,
                                      ),
                                    ),
                                  ),
                                  elevation: MaterialStateProperty.all<double>(0.0),
                                  backgroundColor: MaterialStateProperty.all(_themeChanger.getTheme().primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    forceElevated: boxIsScrolled,
                    title: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            'Posts',
                            style: TextStyle(color: _themeChanger.getTheme().accentColor),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Tagged-(COMING SOON)',
                            style: TextStyle(color: _themeChanger.getTheme().accentColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  PageOne(theRealOtherPosts),
                  PageTwo(),
                ],
                controller: _tabController,
              ),
            ),
          );
  }
}

class PageOne extends StatelessWidget {
  final List<AllPost> otherPosts;
  PageOne(this.otherPosts);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 1,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      itemCount: otherPosts.length,
      itemBuilder: (context, index) => Container(
        child: otherPosts[index].postURL == 'Loading...'
            ? LoadingCircle()
            : Image(fit: BoxFit.cover, image: NetworkImage(otherPosts[index].postURL)),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // primary: false,
      padding: const EdgeInsets.all(0),
      crossAxisSpacing: 3.0,
      mainAxisSpacing: 3.0,
      crossAxisCount: 3,
      children: <Widget>[
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/200')),
      ],
    );
  }
}
