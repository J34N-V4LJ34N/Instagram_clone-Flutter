import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: CustomSearchBar(),
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
