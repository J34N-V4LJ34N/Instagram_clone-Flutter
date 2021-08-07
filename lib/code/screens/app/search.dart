import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/code/models/allpost.dart';
import 'package:instagram_clone/code/models/otherprofileinfo.dart';
import 'package:instagram_clone/code/models/theuser.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _focusNode = FocusNode();
  Icon? _back = null;
  Icon? _search = Icon(Icons.search);
  Color? _cSearch;
  List<UserData>? users;
  List<UserData>? searchStore;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(
        () {
          if (_focusNode.hasFocus == true) {
            _search = null;
            _back = Icon(Icons.arrow_back);
          } else {
            _search = Icon(Icons.search);
            _back = null;
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    users = Provider.of<List<UserData>?>(context);
    searchStore = users;
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    List<UserData>? tempSearchStore;

    initiateSearch(value) {
      if (value.length == 0) {
        setState(() {
          searchStore = users;
          // print('value.length == 0');
        });
      }

      var caseInsensitiveValue = value.toLowerCase();

      if (value.length > 0) {
        // print('value.length > 0');
        tempSearchStore = [];
        users!.forEach((element) {
          if (element.userName.toLowerCase().startsWith(caseInsensitiveValue)) {
            tempSearchStore!.add(element);
            // print('val added');
          }
        });
        tempSearchStore!.forEach((element) {
          // print('#${element.userName}');
        });
        setState(() {
          searchStore = tempSearchStore;
        });
      }
      // else if (value.length > 1) {
      //   print('value.length > 1');
      //   tempSearchStore = [];
      //   queryResultSet!.forEach((element) {
      //     if (element.userName.startsWith(caseInsensitiveValue)) {
      //       print('val added');
      //       tempSearchStore!.add(element);
      //     }
      //   });
      //   tempSearchStore!.forEach((element) {
      //     print('1.${tempSearchStore![1].userName}');
      //   });
      //   setState(() {
      //     searchStore = tempSearchStore;
      //   });
      // }
    }

    if (_themeChanger.getTheme().primaryColor == Colors.black)
      _cSearch = Colors.grey[850];
    else
      _cSearch = Colors.grey[300];
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // Provide a standard title.
          automaticallyImplyLeading: false,
          // centerTitle: true,
          leading: _back,
          title: TextField(
            onChanged: (val) {
              print('First text field: $val');
              initiateSearch(val);
            },
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
          ),
          floating: true,
          snap: true,
        ),
        _focusNode.hasFocus == false
            ? SliverStaggeredGrid.countBuilder(
                crossAxisCount: 3,
                itemCount: Provider.of<List<AllPost>>(context).length,
                itemBuilder: (BuildContext context, int index) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: _themeChanger.getTheme().primaryColor),
                  ),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        Provider.of<List<AllPost>>(context)[Provider.of<List<AllPost>>(context).length - index - 1]
                            .postURL),
                  ),
                ),
                staggeredTileBuilder: (index) => _renderTile(index),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CustomListTile(searchStore: searchStore!, index: index);
                  },
                  childCount: (searchStore!).length,
                ),
              ),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {
        //       return CustomListTile(searchStore: searchStore!, index: index);
        //     },
        //     childCount: (searchStore!).length,
        //   ),
        // ),
        // SliverListView.builder(
        //     itemCount: tempSearchStore.length,
        //     itemBuilder: (context, index) {
        //       return Card(
        //         child: ListTile(
        //           leading: tempSearchStore[index].profilePicURL,
        //           title: Text(tempSearchStore[index].userName),
        //           subtitle: Text(tempSearchStore[index].fullName),
        //         ),
        //       );
        //     }),
      ],
    );
  }
}

StaggeredTile _renderTile(int n) {
  StaggeredTile _tile = StaggeredTile.count(1, 1);

  if (n % 18 == 1 || n % 18 == 9) {
    _tile = StaggeredTile.count(2, 2);
  }

  return _tile;
}

class CustomListTile extends StatelessWidget {
  final searchStore;
  final index;

  const CustomListTile({
    Key? key,
    required this.searchStore,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OtherProfileInfo arg = OtherProfileInfo(
        uid: Provider.of<TheUser?>(context)!.uid,
        userData: Provider.of<UserData>(context),
        otherUserData: searchStore[index],
        otherPosts: Provider.of<List<AllPost>>(context),
        isFollowing: searchStore[index].followers.contains(Provider.of<TheUser?>(context)!.uid));
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: InkWell(
        onTap: () {
          // print('Tapped');
          Navigator.of(context).pushNamed('/otherprofile', arguments: arg);
        },
        child: Row(
          children: [
            (searchStore![index].profilePicURL == 'Loading...')
                ?
                // LoadingCircle()
                Placeholder(
                    color: _themeChanger.getTheme().accentColor,
                    fallbackHeight: 100.0,
                    fallbackWidth: 100.0,
                    strokeWidth: 0.0,
                  )
                : (searchStore![index].profilePicURL == 'null')
                    ? Placeholder(
                        color: _themeChanger.getTheme().accentColor,
                        fallbackHeight: 100.0,
                        fallbackWidth: 100.0,
                        strokeWidth: 0.0,
                      )
                    : ClipOval(
                        child: Image(
                        image: NetworkImage(searchStore![index].profilePicURL!),
                        fit: BoxFit.cover,
                        width: 60.0,
                        height: 60.0,
                      )),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  searchStore![index].userName,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  searchStore![index].fullName,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// SliverGrid(
//           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 150.0,
//             mainAxisSpacing: 10.0,
//             crossAxisSpacing: 10.0,
//             childAspectRatio: 1.0,
//           ),
//           delegate: SliverStaggeredGridDelegate()
//         ),

// Container(
//         margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
//         child: CustomSearchBar(),
//       ),
// class CustomSearchBar extends StatefulWidget {
//   const CustomSearchBar({Key? key}) : super(key: key);

//   @override
//   _CustomSearchBarState createState() => _CustomSearchBarState();
// }

// class _CustomSearchBarState extends State<CustomSearchBar> {
//   final _focusNode = FocusNode();
//   Icon? _search = Icon(Icons.search);
//   Color? _cSearch;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() {
//       setState(
//         () {
//           if (_focusNode.hasFocus == true)
//             _search = null;
//           else
//             _search = Icon(Icons.search);
//         },
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
//     if (_themeChanger.getTheme().primaryColor == Colors.black)
//       _cSearch = Colors.grey[850];
//     else
//       _cSearch = Colors.grey[300];
//     return TextField(
//       focusNode: _focusNode,
//       decoration: InputDecoration(
//         isDense: true,
//         filled: true,
//         fillColor: _cSearch,
//         border: OutlineInputBorder(
//           borderSide: BorderSide(
//             width: 0,
//             style: BorderStyle.none,
//           ),
//           borderRadius: const BorderRadius.all(
//             const Radius.circular(20.0),
//           ),
//         ),
//         prefixIcon: _search,
//         labelText: 'Search',
//         // labelStyle: TextStyle(color: Colors.grey[400]),
//         // enabledBorder: OutlineInputBorder(
//         //   borderSide: BorderSide(color: Colors.grey, width: 0.0),
//         // ),
//         // isDense: true,
//         // contentPadding:
//         //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
// }
