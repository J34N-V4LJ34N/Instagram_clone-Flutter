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
              icon: Icon(Icons.arrow_back_ios, color: _themeChanger.getTheme().accentColor),
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

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _focusNode = FocusNode();
  Icon? _search = Icon(Icons.search);
  Color? _cSearch;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(
        () {
          if (_focusNode.hasFocus == true)
            _search = null;
          else
            _search = Icon(Icons.search);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    if (_themeChanger.getTheme().primaryColor == Colors.black)
      _cSearch = Colors.grey[850];
    else
      _cSearch = Colors.grey[300];
    return TextField(
      focusNode: _focusNode,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: _cSearch,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: const BorderRadius.all(
            const Radius.circular(20.0),
          ),
        ),
        prefixIcon: _search,
        labelText: 'Search',
        // labelStyle: TextStyle(color: Colors.grey[400]),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.grey, width: 0.0),
        // ),
        // isDense: true,
        // contentPadding:
        //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
