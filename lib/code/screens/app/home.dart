import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InstaStory(
                  imageURL: 'https://picsum.photos/100',
                  userName: 'Your Story',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/200',
                  userName: 'Dwight_Shrute',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/300',
                  userName: 'Micheal_Scott',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/400',
                  userName: 'Jan_Levinson',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/500',
                  userName: 'Jim_Halpert',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/600',
                  userName: 'Pam_Beesly',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/700',
                  userName: 'Nard_Dawg',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/800',
                  userName: 'Oscar_Martinez',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/900',
                  userName: 'Kevin_Malone',
                ),
                InstaStory(
                  imageURL: 'https://picsum.photos/1000',
                  userName: 'Stanley_Hudson',
                ),
              ],
            ),
          ),
          InstaPost(
            userName: 'Dwight_Shrute',
            profilePhotoURL: 'https://picsum.photos/200',
            caption:
                'Identity theft is not a joke, Jim! Millions of families suffer every year.',
            postURL: 'https://picsum.photos/1100',
          ),
          InstaPost(
            userName: 'Micheal_Scott',
            profilePhotoURL: 'https://picsum.photos/300',
            caption:
                'Would I rather be feared or loved? Easy. Both. I want people to be afraid of how much they love me.',
            postURL: 'https://picsum.photos/1200',
          ),
          InstaPost(
            userName: 'Jim_Halpert',
            profilePhotoURL: 'https://picsum.photos/500',
            caption: 'Congratulations, universe. You win.',
            postURL: 'https://picsum.photos/1300',
          ),
          InstaPost(
            userName: 'Pam Beesly',
            profilePhotoURL: 'https://picsum.photos/600',
            caption:
                'Corporate needs you to find the differences between this picture and this picture.',
            postURL: 'https://picsum.photos/1400',
          ),
          InstaPost(
            userName: 'Nard_Dawg',
            profilePhotoURL: 'https://picsum.photos/700',
            caption:
                "I wish there was a way to know you're in the good old days before you leave them...",
            postURL: 'https://picsum.photos/1500',
          ),
          InstaPost(
            userName: 'Stanley Hudson',
            profilePhotoURL: 'https://picsum.photos/1000',
            caption: "Did I stutter!?",
            postURL: 'https://picsum.photos/1600',
          ),
        ],
      ),
    );
  }
}

class InstaPost extends StatefulWidget {
  final String userName;
  final String profilePhotoURL;
  final String postURL;
  final String caption;

  const InstaPost({
    Key? key,
    required this.userName,
    required this.profilePhotoURL,
    required this.postURL,
    required this.caption,
  }) : super(key: key);

  @override
  _InstaPostState createState() => _InstaPostState(
      userName: userName,
      profilePhotoURL: profilePhotoURL,
      postURL: postURL,
      caption: caption);
}

class _InstaPostState extends State<InstaPost> {
  Color _favIconColor = Colors.white;
  IconData _favIcon = Icons.favorite_border;

  final String userName;
  final String profilePhotoURL;
  final String postURL;
  final String caption;

  _InstaPostState({
    // Key? key,
    required this.userName,
    required this.profilePhotoURL,
    required this.postURL,
    required this.caption,
  });
  // : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  child: Image(
                    image: NetworkImage(profilePhotoURL),
                    width: 40.0,
                    height: 40.0,
                  ),
                ),
              ),
              Text(userName),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          Image(
            image: NetworkImage(postURL),
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      if (_favIconColor == Colors.white) {
                        _favIconColor = Colors.red;
                        _favIcon = Icons.favorite;
                      } else {
                        _favIconColor = Colors.white;
                        _favIcon = Icons.favorite_border;
                      }
                    },
                  );
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  if (_favIconColor == Colors.red)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.black,
                        content: const Text(
                          'You have liked the post',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        // action: SnackBarAction(
                        //   label: 'Action',
                        //   onPressed: () {
                        //     // Code to execute.
                        //   },
                        // ),
                      ),
                    );
                  else
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.black,
                        content: const Text(
                          'You have removed your like',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        // action: SnackBarAction(
                        //   label: 'Action',
                        //   onPressed: () {
                        //     // Code to execute.
                        //   },
                        // ),
                      ),
                    );
                },
                icon: Icon(
                  _favIcon,
                  size: 30.0,
                  color: _favIconColor,
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
            child: Text(caption),
          ),
        ],
      ),
    );
  }
}

class InstaStory extends StatelessWidget {
  final String imageURL;
  final String userName;

  const InstaStory({
    Key? key,
    required this.imageURL,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String dispName;
    if (userName.length > 10)
      dispName = userName.substring(0, 9) + '...';
    else
      dispName = userName;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(2.0), //same effect as child container margin
          decoration: BoxDecoration(
            gradient: SweepGradient(
              // startAngle: (120 * 3.14) / 180,
              endAngle: (240 * 3.14) / 180,
              // stops: [0, 0.33, 0.66, 1],
              colors: [
                // Color.fromRGBO(129, 52, 175, 1),
                // Color.fromRGBO(221, 42, 123, 1),
                Color.fromRGBO(221, 42, 123, 1),
                Color.fromRGBO(245, 133, 41, 1),
                Color.fromRGBO(254, 218, 119, 1),
                Color.fromRGBO(245, 133, 41, 1),
                Color.fromRGBO(221, 42, 123, 1),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: Container(
            margin:
                EdgeInsets.all(0.0), //same effect as parent container padding
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image(
                image: NetworkImage(imageURL),
                width: 65.0,
                height: 65.0,
              ),
            ),
          ),
        ),
        Center(
          child: Text(dispName),
        )
      ],
    );
  }
}
