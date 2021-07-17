import 'package:flutter/material.dart';

class Pistagram extends StatefulWidget {
  const Pistagram({Key? key}) : super(key: key);

  @override
  _PistagramState createState() => _PistagramState();
}

class _PistagramState extends State<Pistagram> {
  int _currentIndex = 0;

  final tabs = [
    Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InstaStory(imageURL: 'https://picsum.photos/100'),
            InstaStory(imageURL: 'https://picsum.photos/200'),
            InstaStory(imageURL: 'https://picsum.photos/300'),
            InstaStory(imageURL: 'https://picsum.photos/400'),
            InstaStory(imageURL: 'https://picsum.photos/500'),
            InstaStory(imageURL: 'https://picsum.photos/600'),
            InstaStory(imageURL: 'https://picsum.photos/700'),
            InstaStory(imageURL: 'https://picsum.photos/800'),
            InstaStory(imageURL: 'https://picsum.photos/900'),
            InstaStory(imageURL: 'https://picsum.photos/1000'),
          ],
        ),
      ),
    ),
    Center(
      child: Text('Bello2'),
    ),
    Center(
      child: Text('Bello3'),
    ),
    Center(
      child: Text('Bello4'),
    ),
    Center(
      child: Text('Bello5'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // shadowColor: Colors.grey[50],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.camera_alt_outlined, color: Colors.grey[50]),
          onPressed: () {},
        ),
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
          child: Center(
            child: Text(
              "Pistagram",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Billabong',
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send_outlined,
              color: Colors.grey[50],
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class InstaStory extends StatelessWidget {
  final String imageURL;

  const InstaStory({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        margin: EdgeInsets.all(0.0), //same effect as parent container padding
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
    );
  }
}
