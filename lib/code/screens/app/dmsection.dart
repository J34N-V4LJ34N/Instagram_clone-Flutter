import 'package:flutter/material.dart';
import 'package:instagram_clone/code/screens/app/search.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';

class DMsection extends StatelessWidget {
  const DMsection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: _themeChanger.getTheme().accentColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            shadowColor: Colors.transparent,
            title: Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
              child: Text(
                "Kevin_Malone",
                style: TextStyle(
                  color: _themeChanger.getTheme().accentColor,
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.video_call,
                  color: _themeChanger.getTheme().accentColor,
                ),
                onPressed: () {
                  _themeChanger.setTheme(dark);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: _themeChanger.getTheme().accentColor,
                ),
                onPressed: () {
                  _themeChanger.setTheme(light);
                },
              ),
            ],
          ),
          body: ListView(
            // padding: const EdgeInsets.all(8),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchBar(),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  tileColor: _themeChanger.getTheme().primaryColor,
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage('https://picsum.photos/100'),
                    ),
                  ),
                  title: Text('Oscar Martinez'),
                  subtitle: Text('Active 2h ago'),
                  trailing: Icon(Icons.camera_alt_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
